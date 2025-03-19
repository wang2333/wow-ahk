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

// 用户设置接口
interface UserSettings {
  wowCoordinates: Coordinates;
  // 可以在这里添加更多游戏设置
}

interface User {
  username: string;
  isLoggedIn: boolean;
  settings: UserSettings;
}

interface AuthContextType {
  user: User | null;
  isLoading: boolean;
  login: (username: string, password: string) => Promise<boolean>;
  logout: () => Promise<void>;
  updateUserSettings: (settings: Partial<UserSettings>) => Promise<void>;
  updateWowCoordinates: (coordinates: Coordinates) => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

// 默认用户设置
const DEFAULT_USER_SETTINGS: UserSettings = {
  wowCoordinates: { x1: 15, x2: 2550, y: 15 }
};

// 创建存储实例
const storePromise = Store.load('user-data.json');

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [user, setUser] = useState<User | null>(null);
  const [isLoading, setIsLoading] = useState(false);

  const checkSavedUser = async () => {
    try {
      const store = await storePromise;
      const savedUser = await store.get<User>('user');

      if (savedUser && savedUser.isLoggedIn) {
        // 确保用户有设置对象
        if (!savedUser.settings) {
          savedUser.settings = DEFAULT_USER_SETTINGS;
        } else if (!savedUser.settings.wowCoordinates) {
          savedUser.settings.wowCoordinates = DEFAULT_USER_SETTINGS.wowCoordinates;
        }

        setUser(savedUser);
      }
    } catch (error) {
      console.error('Failed to load user data:', error);
    } finally {
      setIsLoading(false);
    }
  };

  // 清空用户状态的函数
  const clearUserState = async (): Promise<void> => {
    setUser(null);
    // 通过 Store API 清除用户数据
    const store = await storePromise;
    await store.set('user', null);
    await store.save();
    console.log('用户状态已清空');
    return;
  };

  // 初始化时检查是否有保存的用户会话并设置应用关闭事件监听
  useEffect(() => {
    // 加载保存的用户数据
    checkSavedUser();

    // 设置应用关闭事件监听器
    let unlistenFn: (() => void) | undefined;
    const setupCloseHandler = async () => {
      try {
        const appWindow = await getCurrentWindow();

        // 在窗口关闭请求时执行清理操作
        unlistenFn = await appWindow.onCloseRequested(async () => {
          // 阻止默认关闭行为，以便先执行清理操作
          // event.preventDefault();
          // 清空用户状态
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

  // 更新用户设置
  const updateUserSettings = async (newSettings: Partial<UserSettings>): Promise<void> => {
    if (!user) return;

    try {
      const updatedUser = {
        ...user,
        settings: {
          ...user.settings,
          ...newSettings
        }
      };

      setUser(updatedUser);

      // 保存到存储
      const store = await storePromise;
      await store.set('user', updatedUser);
      await store.save();
    } catch (error) {
      console.error('Failed to update user settings:', error);
    }
  };

  // 更新WOW坐标的便捷方法
  const updateWowCoordinates = async (coordinates: Coordinates): Promise<void> => {
    await updateUserSettings({
      wowCoordinates: coordinates
    });
  };

  const login = async (username: string, password: string): Promise<boolean> => {
    setIsLoading(true);

    try {
      // 使用axios获取所有用户
      try {
        interface UserResponse {
          success: boolean;
          data: Array<{ UserName: string; Password: string }>;
          message: string;
        }

        // 注意：这里使用完整的API路径
        const succsess = await request<UserResponse>('/api/verifyUser', {
          method: 'GET',
          params: {
            username,
            password
          }
        });
        if (succsess) {
          const userData: User = {
            username: username,
            isLoggedIn: true,
            settings: DEFAULT_USER_SETTINGS
          };

          setUser(userData);

          // 保存用户数据到存储
          const store = await storePromise;
          await store.set('user', userData);
          await store.save();

          return true;
        }
      } catch (error) {
        console.error('获取用户列表失败:', error);
      }

      return false;
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
        user,
        isLoading,
        login,
        logout,
        updateUserSettings,
        updateWowCoordinates
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
