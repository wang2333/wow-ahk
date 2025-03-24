import { createContext, ReactNode, useContext, useEffect, useState } from 'react';

import request from '@/Utils/axios';
import { message } from '@tauri-apps/plugin-dialog';
import { Store } from '@tauri-apps/plugin-store';

// 坐标接口
interface Coordinates {
  x1: number;
  x2: number;
  y: number;
}

// 热键设置接口
interface HotkeySettings {
  mode1Key: string;
  mode2Key: string;
  pauseKey: string;
}

// 游戏设置接口
interface GameSettings {
  wowCoordinates: Coordinates;
  hotkeySettings: HotkeySettings;
  // 可以在这里添加更多游戏设置
}

// 用户接口
interface User {
  keyCode: string;
  userType: string;
  loginTime: number;
}

interface AuthContextType {
  userAccount: string | null;
  userInfo: User | null;
  gameSettings: GameSettings;
  isLoading: boolean;
  login: (keyCode: string) => Promise<void>;
  logout: () => Promise<void>;
  updateWowCoordinates: (coordinates: Coordinates) => Promise<void>;
  updateHotkeySettings: (hotkeys: HotkeySettings) => Promise<void>;
  checkUser: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

// 默认游戏设置
const DEFAULT_GAME_SETTINGS: GameSettings = {
  wowCoordinates: { x1: 10, x2: 2550, y: 10 },
  hotkeySettings: { mode1Key: 'F1', mode2Key: 'F2', pauseKey: 'F3' }
};

// 创建存储实例
const userAccountStorePromise = Store.load('user-account.json');
const userStorePromise = Store.load('user-data.json');
const gameSettingsStorePromise = Store.load('game-settings.json');

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [userAccount, setUserAccount] = useState<string | null>(null);
  const [userInfo, setUserInfo] = useState<User | null>(null);
  const [gameSettings, setGameSettings] = useState<GameSettings>(DEFAULT_GAME_SETTINGS);
  const [isLoading, setIsLoading] = useState(false);

  // 加载游戏设置
  const loadGameSettings = async () => {
    try {
      const store = await gameSettingsStorePromise;
      const savedSettings = await store.get<GameSettings>('gameSettings');

      if (savedSettings) {
        setGameSettings(savedSettings);
      } else {
        // 如果没有保存的设置，使用默认设置并保存
        await saveGameSettings(DEFAULT_GAME_SETTINGS);
      }
    } catch (error) {
      console.error('加载游戏设置失败:', error);
      // 出错时使用默认设置
      setGameSettings(DEFAULT_GAME_SETTINGS);
    }
  };

  // 保存游戏设置
  const saveGameSettings = async (settings: GameSettings) => {
    try {
      const store = await gameSettingsStorePromise;
      await store.set('gameSettings', settings);
      await store.save();
    } catch (error) {
      console.error('保存游戏设置失败:', error);
    }
  };

  // 检查保存的用户数据
  const loadSavedUser = async () => {
    const userAccountStore = await userAccountStorePromise;
    const savedUserAccount = await userAccountStore.get<string>('userAccount');
    const store = await userStorePromise;
    const savedUser = await store.get<User>('user');

    if (savedUserAccount) {
      setUserAccount(savedUserAccount);
    } else {
      return;
    }
    if (savedUser) {
      setUserInfo(savedUser);
    }
  };

  const checkUser = async () => {
    const userAccountStore = await userAccountStorePromise;
    const savedUserAccount = await userAccountStore.get<string>('userAccount');
    if (!savedUserAccount) {
      return;
    }
    await request('/api/verify', {
      method: 'GET',
      params: {
        keyCode: savedUserAccount
      }
    }).catch(async err => {
      console.log('👻 ~ err:', err)
      if (err.message === '卡密不存在' || err.message === '卡密已过期' || err.message === '卡密已禁用') {
        await clearUserState();
      }
    });
  };

  // 清空用户状态的函数，只清除用户登录信息，不清除游戏设置
  const clearUserState = async (): Promise<void> => {
    setUserInfo(null);
    // 只清除用户数据，不清除游戏设置
    const store = await userStorePromise;
    await store.set('user', null);
    await store.save();
  };

  // 初始化时加载用户和游戏设置，并设置应用关闭事件监听
  useEffect(() => {
    // 加载保存的用户数据
    loadSavedUser();
    // 加载游戏设置
    loadGameSettings();
  }, []);

  // 更新WOW坐标
  const updateWowCoordinates = async (coordinates: Coordinates): Promise<void> => {
    const newSettings = {
      ...gameSettings,
      wowCoordinates: coordinates
    };
    setGameSettings(newSettings);
    await saveGameSettings(newSettings);
  };

  // 更新热键设置
  const updateHotkeySettings = async (hotkeys: HotkeySettings): Promise<void> => {
    const newSettings = {
      ...gameSettings,
      hotkeySettings: hotkeys
    };
    setGameSettings(newSettings);
    await saveGameSettings(newSettings);
  };

  const login = async (keyCode: string) => {
    setIsLoading(true);

    await request<{
      success: boolean;
      message: string;
      data: {
        userType: string;
      };
    }>('/api/login', {
      method: 'GET',
      params: {
        keyCode
      }
    })
      .then(async response => {
        const userData = {
          keyCode,
          userType: response.data.userType.toString(),
          loginTime: new Date().getTime()
        };
        setUserInfo(userData);
        setUserAccount(keyCode);
        // 保存用户数据到存储
        const store = await userStorePromise;
        await store.set('user', userData);
        await store.save();

        const userAccountStore = await userAccountStorePromise;
        await userAccountStore.set('userAccount', keyCode);
        await userAccountStore.save();
      })
      .catch(async error => {
        await message(error.message, '登录失败');
      })
      .finally(() => {
        setIsLoading(false);
      });
  };

  const logout = async () => {
    setIsLoading(true);

    // 注意：这里使用完整的API路径
    await request<{ success: boolean }>('/api/logout', {
      method: 'GET',
      params: {
        keyCode: userAccount
      }
    })
      .then(async () => {
        await message('退出成功', '退出成功');
        await clearUserState();
      })
      .catch(async (err) => {
        await message(err.message, '退出失败');
      })
      .finally(() => {
        setIsLoading(false);
      });
  };

  return (
    <AuthContext.Provider
      value={{
        userAccount,
        userInfo,
        gameSettings,
        isLoading,
        login,
        logout,
        updateWowCoordinates,
        updateHotkeySettings,
        checkUser
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);

  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }

  return context;
};
