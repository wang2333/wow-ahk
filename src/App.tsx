import './App.css';

import { useEffect, useState } from 'react';

import Login from '@/components/Login';
import WOW from '@/components/WOW';
// import ZXSJ from '@/components/ZXSJ';
import { useAuth } from './contexts/AuthContext';
import Help from './components/Help';
import Install from './components/Install';
import Loading from './components/Loading';

function App() {
  const [activeTab, setActiveTab] = useState<'wow' | 'zxsj' | 'help' | 'install'>('help');
  const { userInfo, isLoading, login, logout } = useAuth();

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
      // 禁用 Ctrl+Shift+C
      if ((e.ctrlKey || e.metaKey) && e.shiftKey && e.key === 'c') {
        e.preventDefault();
        return false;
      }
      return false;
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

  // 如果用户未登录，显示登录页面
  if (!userInfo) {
    return (
      <>
        <Loading isLoading={isLoading} />
        <Login onLogin={login} isLoading={isLoading} />
      </>
    );
  }

  // 用户已登录，显示主应用
  return (
    <>
      <Loading isLoading={isLoading} />
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
