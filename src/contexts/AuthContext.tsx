import { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { Store } from '@tauri-apps/plugin-store';

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
  wowCoordinates: { x1: 0, x2: 0, y: 0 }
};

// 模拟用户数据，实际应用中应该从服务器获取或使用更安全的方式存储
const MOCK_USERS = [
  { username: 'wxs', password: '123' },
  { username: '031701', password: '031701' }, // 西凉凉果
  { username: '031702', password: '031702' },
  { username: '031703', password: '031703' },
  { username: '031704', password: '031704' },
  { username: '031705', password: '031705' },
  { username: '031706', password: '031706' },
  { username: '031707', password: '031707' },
  { username: '031708', password: '031708' },
  { username: '031709', password: '031709' },
  { username: '031710', password: '031710' },
  { username: '031711', password: '031711' },
  { username: '031712', password: '031712' },
  { username: '031713', password: '031713' },
  { username: '031714', password: '031714' },
  { username: '031715', password: '031715' },
  { username: '031716', password: '031716' },
  { username: '031717', password: '031717' },
  { username: '031718', password: '031718' },
  { username: '031719', password: '031719' },
  { username: '031720', password: '031720' }
];

// 创建存储实例
const storePromise = Store.load('user-data.json');

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [user, setUser] = useState<User | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  const checkSavedUser = async () => {
    try {
      const store = await storePromise;
      const savedUser = await store.get<User>('user');

      if (savedUser && savedUser.isLoggedIn) {
        // 确保用户有设置对象
        if (!savedUser.settings) {
          savedUser.settings = DEFAULT_USER_SETTINGS;
        } else if (!savedUser.settings.wowCoordinates) {
          // 确保有坐标设置
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

  // 初始化时检查是否有保存的用户会话
  useEffect(() => {
    checkSavedUser();
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
      // 模拟API调用延迟
      await new Promise(resolve => setTimeout(resolve, 1000));

      // 验证用户
      const foundUser = MOCK_USERS.find(u => u.username === username && u.password === password);

      if (foundUser) {
        const userData: User = {
          username: foundUser.username,
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

      return false;
    } catch (error) {
      console.error('Login error:', error);
      return false;
    } finally {
      setIsLoading(false);
    }
  };

  const logout = async (): Promise<void> => {
    setIsLoading(true);

    try {
      setUser(null);

      // 清除存储的用户数据
      const store = await storePromise;
      await store.set('user', null);
      await store.save();
    } catch (error) {
      console.error('Logout error:', error);
    } finally {
      setIsLoading(false);
    }
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
