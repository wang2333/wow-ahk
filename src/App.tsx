import './App.css';
import { useEffect, useState } from 'react';
import Login from '@/components/Login';
import WOW from '@/components/WOW';
// import ZXSJ from '@/components/ZXSJ';
import { useAuth } from './contexts/AuthContext';
import Help from './components/Help';
import Install from './components/Install';
import Loading from './components/Loading';
import { Window } from '@tauri-apps/api/window';

function App() {
  const [activeTab, setActiveTab] = useState<'wow' | 'zxsj' | 'help' | 'install'>('help');
  const {
    userInfo,
    userAccount,
    isLoading,
    isLoading2,
    isLoading3,
    login,
    logout,
    clearUserState
  } = useAuth();

  useEffect(() => {
    const disableRefresh = (e: KeyboardEvent) => {
      // 禁用 F12
      if (e.key === 'F12') {
        e.preventDefault();
        return false;
      }
      if (e.key === 'F5') {
        e.preventDefault();
        return false;
      }
      // 禁用 Ctrl+R
      if ((e.ctrlKey || e.metaKey) && e.key === 'r') {
        e.preventDefault();
        return false;
      }
      if ((e.ctrlKey || e.metaKey) && e.key === 'R') {
        e.preventDefault();
        return false;
      }
      // 禁用 Ctrl+Shift+C
      if ((e.ctrlKey || e.metaKey) && e.shiftKey && e.key === 'c') {
        e.preventDefault();
        return false;
      }
      if ((e.ctrlKey || e.metaKey) && e.shiftKey && e.key === 'C') {
        e.preventDefault();
        return false;
      }
    };
    // 禁用鼠标右键
    const disabledRightClick = (e: MouseEvent) => {
      e.preventDefault();
      return false;
    };

    document.addEventListener('keydown', disableRefresh);
    document.addEventListener('contextmenu', disabledRightClick);
    return () => {
      document.removeEventListener('keydown', disableRefresh);
      document.removeEventListener('contextmenu', disabledRightClick);
    };
  }, []);

  // 监听窗口关闭事件
  useEffect(() => {
    // 设置窗口关闭前的回调函数，清理用户状态
    const setupCloseHandler = async () => {
      const appWindow = Window.getCurrent();
      await appWindow.onCloseRequested(async () => {
        // 在窗口关闭前调用clearUserState清理用户状态
        await clearUserState();
      });
    };

    setupCloseHandler().catch(console.error);
  }, [clearUserState]);

  if (!userAccount) {
    return (
      <>
        <Loading isLoading={isLoading || isLoading2 || isLoading3} />
        <Login onLogin={login} isLoading={isLoading} />
      </>
    );
  }
  if (userAccount.length !== 10) {
    return (
      <>
        <Loading isLoading={isLoading || isLoading2 || isLoading3} />
        <Login onLogin={login} isLoading={isLoading} />
      </>
    );
  }
  if (!userInfo) {
    return (
      <>
        <Loading isLoading={isLoading || isLoading2 || isLoading3} />
        <Login onLogin={login} isLoading={isLoading} />
      </>
    );
  }

  // 用户已登录，显示主应用
  return (
    <>
      <Loading isLoading={isLoading || isLoading2 || isLoading3} />
      <div className='app-container'>
        <div className='header'>
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
            <div className='tab-container'>
              <button
                className={`tab-button ${activeTab === 'help' ? 'active' : ''}`}
                onClick={() => setActiveTab('help')}
              >
                使用说明
              </button>
              <button
                className={`tab-button ${activeTab === 'wow' ? 'active' : ''}`}
                onClick={() => setActiveTab('wow')}
              >
                魔兽世界
              </button>
              <button
                className={`tab-button ${activeTab === 'install' ? 'active' : ''}`}
                onClick={() => setActiveTab('install')}
              >
                插件安装
              </button>
            </div>
            <span className='group-link'>售前QQ：154019212</span>
          </div>

          <div className='user-info'>
            <button className='logout-button' onClick={logout}>
              退出登录
            </button>
          </div>
        </div>

        <div className='tab-content'>
          {activeTab === 'wow' && <WOW />}
          {activeTab === 'help' && <Help />}
          {activeTab === 'install' && <Install />}
        </div>
      </div>
    </>
  );
}

export default App;
