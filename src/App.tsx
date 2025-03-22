import './App.css';

import { useState } from 'react';

import Login from '@/components/Login';
import WOW from '@/components/WOW';
// import ZXSJ from '@/components/ZXSJ';
import { useAuth } from './contexts/AuthContext';
import Help from './components/Help';

function App() {
  const [activeTab, setActiveTab] = useState<'wow' | 'zxsj' | 'help'>('help');
  const { userInfo, isLoading, login, logout } = useAuth();

  // 如果用户未登录，显示登录页面
  if (!userInfo) {
    return <Login onLogin={login} isLoading={isLoading} />;
  }

  // 用户已登录，显示主应用
  return (
    <div className='app-container'>
      <div className='header'>
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

          {/* <button
            className={`tab-button ${activeTab === 'zxsj' ? 'active' : ''}`}
            onClick={() => setActiveTab('zxsj')}
            disabled={true}
          >
            诛仙世界
          </button> */}
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
      </div>
    </div>
  );
}

export default App;
