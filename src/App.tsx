import './App.css';

import { useState } from 'react';

import WOW from '@/components/WOW';
import ZXSJ from '@/components/ZXSJ';
import Login from '@/components/Login';
import { useAuth } from './contexts/AuthContext';

function App() {
  const [activeTab, setActiveTab] = useState<'wow' | 'zxsj'>('wow');
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
            className={`tab-button ${activeTab === 'wow' ? 'active' : ''}`}
            onClick={() => setActiveTab('wow')}
          >
            魔兽世界
          </button>
          <button
            className={`tab-button ${activeTab === 'zxsj' ? 'active' : ''}`}
            onClick={() => setActiveTab('zxsj')}
            disabled={true}
          >
            诛仙世界
          </button>
        </div>
        <div className='user-info'>
          <button className='logout-button' onClick={logout}>
            退出登录
          </button>
        </div>
      </div>

      <div className='tab-content'>{activeTab === 'wow' ? <WOW /> : <ZXSJ />}</div>
    </div>
  );
}

export default App;
