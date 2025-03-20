import { createContext, useContext, useState, ReactNode, useEffect } from 'react';
import { Store } from '@tauri-apps/plugin-store';
import { getCurrentWindow } from '@tauri-apps/api/window';
import request from '@/Utils/axios';

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
}

interface AuthContextType {
  userInfo: User | null;
  gameSettings: GameSettings;
  isLoading: boolean;
  login: (keyCode: string) => Promise<boolean>;
  logout: () => Promise<void>;
  updateWowCoordinates: (coordinates: Coordinates) => Promise<void>;
  updateHotkeySettings: (hotkeys: HotkeySettings) => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

// 默认游戏设置
const DEFAULT_GAME_SETTINGS: GameSettings = {
  wowCoordinates: { x1: 10, x2: 2550, y: 10 },
  hotkeySettings: { mode1Key: 'F1', mode2Key: 'F2', pauseKey: 'F3' }
};

// 创建存储实例
const userStorePromise = Store.load('user-data.json');
const gameSettingsStorePromise = Store.load('game-settings.json');

export const AuthProvider = ({ children }: { children: ReactNode }) => {
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
  const checkSavedUser = async () => {
    try {
      const store = await userStorePromise;
      const savedUser = await store.get<User>('user');

      if (savedUser) {
        setUserInfo(savedUser);
      }
    } catch (error) {
      console.error('加载用户数据失败:', error);
    } finally {
      setIsLoading(false);
    }
  };

  // 清空用户状态的函数，只清除用户登录信息，不清除游戏设置
  const clearUserState = async (): Promise<void> => {
    setUserInfo(null);
    // 只清除用户数据，不清除游戏设置
    const store = await userStorePromise;
    await store.set('user', null);
    await store.save();
    console.log('用户状态已清空');
    return;
  };

  // 初始化时加载用户和游戏设置，并设置应用关闭事件监听
  useEffect(() => {
    // 加载保存的用户数据
    checkSavedUser();
    // 加载游戏设置
    loadGameSettings();

    // 设置应用关闭事件监听器
    let unlistenFn: (() => void) | undefined;
    const setupCloseHandler = async () => {
      try {
        const appWindow = await getCurrentWindow();

        // 在窗口关闭请求时执行清理操作
        unlistenFn = await appWindow.onCloseRequested(async () => {
          // 只清空用户状态，不清空游戏设置
          await clearUserState();
          appWindow.close();
        });
      } catch (error) {
        console.error('设置窗口关闭事件监听器失败:', error);
      }
    };
    setupCloseHandler();
    // 组件卸载时移除事件监听器
    return () => {
      if (unlistenFn) {
        unlistenFn();
      }
    };
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

  const login = async (keyCode: string): Promise<boolean> => {
    setIsLoading(true);

    try {
      // 注意：这里使用完整的API路径
      const response = await request<{ user_type: string }>('/api/verifyCard', {
        method: 'GET',
        params: {
          keyCode
        }
      });
      console.log('👻 ~ response:', response)
      const userData = {
        keyCode,
        userType: response.user_type
      };
      setUserInfo(userData);
      // 保存用户数据到存储
      const store = await userStorePromise;
      await store.set('user', userData);
      await store.save();
      return true;
    } catch (error) {
      console.error('登录总体错误:', error);
      return false;
    } finally {
      setIsLoading(false);
    }
  };

  const logout = async (): Promise<void> => {
    setIsLoading(true);
    await clearUserState();
    setIsLoading(false);
  };

  return (
    <AuthContext.Provider
      value={{
        userInfo,
        gameSettings,
        isLoading,
        login,
        logout,
        updateWowCoordinates,
        updateHotkeySettings
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
