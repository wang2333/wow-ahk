import './styles.css';
import { useEffect, useState } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import request from '@/Utils/axios';
import { message } from '@tauri-apps/plugin-dialog';

interface LoginProps {
  onLogin: (keyCode: string) => void;
  isLoading: boolean;
}

const Login = ({ onLogin, isLoading }: LoginProps) => {
  const { userAccount } = useAuth();
  const [keyCode, setKeyCode] = useState<string>(userAccount || '');
  const [error, setError] = useState('');

  useEffect(() => {
    if (userAccount) {
      setKeyCode(userAccount);
    }
  }, [userAccount]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!keyCode.trim()) {
      setError('卡密不能为空');
      return;
    }

    try {
      await onLogin(keyCode);
    } catch (err) {
      console.error(err);
    }
  };

  const handleUnbindSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!userAccount) {
      setError('卡密不能为空');
      return;
    }
    await request('/api/unbindMachine', {
      method: 'GET',
      params: {
        keyCode
      }
    })
      .then(async () => {
        await message('机器码解绑成功', '操作成功');
      })
      .catch(async (err: any) => {
        await message(err.message || '解绑失败，请稍后重试', '操作失败');
      });
  };

  return (
    <div className='login-container'>
      <div className='login-form-container'>
        <h2>登录</h2>
        <form onSubmit={handleSubmit} autoComplete='off' className='login-form'>
          {error && <div className='error-message'>{error}</div>}

          <div className='form-group'>
            <label htmlFor='keyCode'>卡密</label>
            <input
              type='text'
              id='keyCode'
              value={keyCode}
              onChange={e => setKeyCode(e.target.value)}
              disabled={isLoading}
            />
          </div>

          <button type='submit' className='login-button' disabled={isLoading}>
            {isLoading ? '登录中...' : '登录'}
          </button>

          <button type='button' className='unbind-button' onClick={handleUnbindSubmit}>
            自助解绑机器码（一天一次）
          </button>
        </form>
      </div>
      <span
        style={{
          display: 'flex',
          lineHeight: '50px',
          color: 'green',
          fontSize: '18px'
        }}
      >
        售前QQ：154019212
      </span>
    </div>
  );
};

export default Login;
