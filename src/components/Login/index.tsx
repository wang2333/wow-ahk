import { useState } from 'react';
import './styles.css';

interface LoginProps {
  onLogin: (username: string, password: string) => Promise<boolean>;
  isLoading: boolean;
}

const Login = ({ onLogin, isLoading }: LoginProps) => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');

    if (!username.trim() || !password.trim()) {
      setError('用户名和密码不能为空');
      return;
    }

    try {
      const success = await onLogin(username, password);
      if (!success) {
        setError('用户名或密码错误');
      }
    } catch (err) {
      setError('登录过程中发生错误，请重试');
      console.error(err);
    }
  };

  return (
    <div className='login-container'>
      <div className='login-form-container'>
        <h2>登录</h2>
        <form onSubmit={handleSubmit} autoComplete='off' className='login-form'>
          {error && <div className='error-message'>{error}</div>}

          <div className='form-group'>
            <label htmlFor='username'>用户名</label>
            <input
              type='text'
              id='username'
              value={username}
              onChange={e => setUsername(e.target.value)}
              disabled={isLoading}
            />
          </div>

          <div className='form-group'>
            <label htmlFor='password'>密码</label>
            <input
              type='password'
              id='password'
              value={password}
              onChange={e => setPassword(e.target.value)}
              disabled={isLoading}
            />
          </div>

          <button type='submit' className='login-button' disabled={isLoading}>
            {isLoading ? '登录中...' : '登录'}
          </button>
        </form>
      </div>
    </div>
  );
};

export default Login;
