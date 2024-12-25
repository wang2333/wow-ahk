import './App.css';

import { useState } from 'react';

import WOW from '@/components/WOW';
import ZXSJ from '@/components/ZXSJ';

function App() {
  const [activeTab, setActiveTab] = useState<'wow' | 'zxsj'>('wow');

  return (
    <div className='app-container'>
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
        >
          诛仙世界
        </button>
      </div>

      <div className='tab-content'>{activeTab === 'wow' ? <WOW /> : <ZXSJ />}</div>
    </div>
  );
}

export default App;
