import { createContext, ReactNode, useContext, useEffect, useState } from 'react';

import request from '@/Utils/axios';
import { message } from '@tauri-apps/plugin-dialog';
import { Store } from '@tauri-apps/plugin-store';
import { invoke } from '@tauri-apps/api/core';

// 热键设置接口
interface HotkeySettings {
  mode1Key: string;
  mode2Key: string;
  pauseKey: string;
}
interface ColorBlock {
  isCustomColorBlock: boolean;
  x: number;
  y: number;
}
type ColorMapping = 'JIAJIA' | 'JIAJIA_REAL' | 'ZHUZHU' | 'XIAOYI_SS' | 'XIAOYI_LR' | 'AH' | '';

// 游戏设置接口
interface GameSettings {
  hotkeySettings: HotkeySettings;
  customColorBlock: ColorBlock;
  selectedMacro: ColorMapping;
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
  machineCode: string;
  userInfo: User | null;
  gameSettings: GameSettings;
  isLoading: boolean;
  isLoading2: boolean;
  isLoading3: boolean;
  login: (keyCode: string) => Promise<void>;
  logout: () => Promise<void>;
  updateHotkeySettings: (hotkeys: HotkeySettings) => Promise<void>;
  updateCustomColorBlock: (colorBlock: ColorBlock) => Promise<void>;
  updateSelectedMacro: (selectedMacro: ColorMapping) => Promise<void>;
  checkUser: () => Promise<void>;
  checkUser2: () => Promise<void>;
  checkUser3: () => Promise<void>;
  clearUserState: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

// 默认游戏设置
const DEFAULT_GAME_SETTINGS: GameSettings = {
  hotkeySettings: { mode1Key: 'F1', mode2Key: 'F2', pauseKey: 'F3' },
  customColorBlock: { isCustomColorBlock: false, x: 0, y: 0 },
  selectedMacro: ''
};

// 创建存储实例
const userAccountStorePromise = Store.load('user-account.json');
const userStorePromise = Store.load('user-data.json');
const gameSettingsStorePromise = Store.load('game-settings.json');

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [userAccount, setUserAccount] = useState<string | null>(null);
  const [userInfo, setUserInfo] = useState<User | null>(null);
  const [gameSettings, setGameSettings] = useState<GameSettings>(DEFAULT_GAME_SETTINGS);
  const [isLoading, setIsLoading] = useState(true);
  const [machineCode, setMachineCode] = useState<string>('');

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
    setIsLoading(true);
    setIsLoading2(true);
    setIsLoading3(true);
    const userAccountStore = await userAccountStorePromise;
    const savedUserAccount = await userAccountStore.get<string>('userAccount');
    const store = await userStorePromise;
    const savedUser = await store.get<User>('user');

    if (savedUserAccount) {
      setUserAccount(savedUserAccount);
      setIsLoading(false);
      setIsLoading2(false);
      setIsLoading3(false);
    } else {
      setIsLoading(false);
      setIsLoading2(false);
      setIsLoading3(false);
      return;
    }
    if (savedUser) {
      setUserInfo(savedUser);
    }
  };

  const checkUser = async () => {
    setIsLoading(true);
    setIsLoading2(true);
    setIsLoading3(true);

    const userAccountStore = await userAccountStorePromise;
    const savedUserAccount = await userAccountStore.get<string>('userAccount');
    if (!savedUserAccount || savedUserAccount.length !== 10) {
      setUserInfo(null);
      await clearUserState();
      setIsLoading(false);
      setIsLoading2(false);
      setIsLoading3(false);
      return;
    }
    await request('/api/verify', {
      method: 'GET',
      params: {
        keyCode: savedUserAccount,
        machineCode
      }
    })
      .then(async () => {
        setIsLoading(false);
        setIsLoading2(false);
        setIsLoading3(false);
      })
      .catch(async () => {
        setUserInfo(null);
        await clearUserState();
      });
  };

  const [isLoading2, setIsLoading2] = useState(true);
  const checkUser2 = async () => {
    setIsLoading(true);
    setIsLoading2(true);
    setIsLoading3(true);
    const userAccountStore = await userAccountStorePromise;
    const savedUserAccount = await userAccountStore.get<string>('userAccount');
    if (!savedUserAccount || savedUserAccount.length !== 10) {
      setUserInfo(null);
      await clearUserState();
      setIsLoading(false);
      setIsLoading2(false);
      setIsLoading3(false);
      return;
    }
    await request('/api/verify', {
      method: 'GET',
      params: {
        keyCode: savedUserAccount,
        machineCode
      }
    })
      .then(async () => {
        setIsLoading(false);
        setIsLoading2(false);
        setIsLoading3(false);
      })
      .catch(async () => {
        setUserInfo(null);
        await clearUserState();
      });
  };

  const [isLoading3, setIsLoading3] = useState(true);
  const checkUser3 = async () => {
    setIsLoading(true);
    setIsLoading2(true);
    setIsLoading3(true);
    const userAccountStore = await userAccountStorePromise;
    const savedUserAccount = await userAccountStore.get<string>('userAccount');
    if (!savedUserAccount || savedUserAccount.length !== 10) {
      setUserInfo(null);
      await clearUserState();
      setIsLoading(false);
      setIsLoading2(false);
      setIsLoading3(false);
      return;
    }
    await request('/api/verify', {
      method: 'GET',
      params: {
        keyCode: savedUserAccount,
        machineCode
      }
    })
      .then(async () => {
        setIsLoading(false);
        setIsLoading2(false);
        setIsLoading3(false);
      })
      .catch(async () => {
        setUserInfo(null);
        await clearUserState();
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

    invoke<string>('get_hostname').then(code => {
      setMachineCode(code);
    });
  }, []);

  const updateGameSettings = async (settings: GameSettings): Promise<void> => {
    setGameSettings(settings);
    await saveGameSettings(settings);
  };
  // 更新热键设置
  const updateHotkeySettings = async (hotkeys: HotkeySettings): Promise<void> => {
    const newSettings = {
      ...gameSettings,
      hotkeySettings: hotkeys
    };
    updateGameSettings(newSettings);
  };
  // 更新颜色块设置
  const updateCustomColorBlock = async (colorBlock: ColorBlock): Promise<void> => {
    const newSettings = {
      ...gameSettings,
      customColorBlock: colorBlock
    };
    updateGameSettings(newSettings);
  };
  // 更新一键宏选择
  const updateSelectedMacro = async (selectedMacro: ColorMapping): Promise<void> => {
    const newSettings = {
      ...gameSettings,
      selectedMacro
    };
    updateGameSettings(newSettings);
  };

  const login = async (keyCode: string) => {
    setIsLoading(true);
    setIsLoading2(true);
    setIsLoading3(true);

    await request<{
      success: boolean;
      message: string;
      data: {
        userType: string;
      };
    }>('/api/login', {
      method: 'GET',
      params: {
        keyCode,
        machineCode
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
        setIsLoading2(false);
        setIsLoading3(false);
      });
  };

  const logout = async () => {
    setIsLoading(true);
    setIsLoading2(true);
    setIsLoading3(true);

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
      .catch(async err => {
        await message(err.message, '退出失败');
      })
      .finally(() => {
        setIsLoading(false);
        setIsLoading2(false);
        setIsLoading3(false);
      });
  };

  return (
    <AuthContext.Provider
      value={{
        userAccount,
        machineCode,
        userInfo,
        gameSettings,
        isLoading,
        isLoading2,
        isLoading3,
        login,
        logout,
        updateHotkeySettings,
        updateCustomColorBlock,
        updateSelectedMacro,
        checkUser,
        checkUser2,
        checkUser3,
        clearUserState
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
