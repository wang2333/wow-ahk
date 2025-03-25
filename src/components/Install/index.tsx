import './style.css';
import React, { useState } from 'react';
import { invoke } from '@tauri-apps/api/core';
import { open } from '@tauri-apps/plugin-dialog';
import { exists } from '@tauri-apps/plugin-fs';

interface InstallProps {}

const pluginsMap: Record<number, string> = {
  2: 'WR', // 佳佳-WLK
  3: '!WR', // 佳佳-正式服
  4: 'AH' // AutoHelp
};

const Install: React.FC<InstallProps> = () => {
  const [gamePath, setGamePath] = useState<string>('');
  const [isInstalling, setIsInstalling] = useState<boolean>(false);
  const [message, setMessage] = useState<{
    text: string;
    type: 'success' | 'error' | 'info' | null;
  }>({
    text: '',
    type: null
  });

  // 选择游戏目录
  const selectGamePath = async () => {
    try {
      const selected = await open({
        directory: true,
        multiple: false,
        title: '选择魔兽世界安装目录'
      });

      if (selected && !Array.isArray(selected)) {
        // 验证目录是否存在
        if (await exists(selected)) {
          setGamePath(selected);
          setMessage({ text: '已选择游戏目录: ' + selected, type: 'info' });
        } else {
          setMessage({ text: `所选目录不存在: ${selected}`, type: 'error' });
        }
      }
    } catch (error) {
      setMessage({ text: `选择游戏目录失败: ${error}`, type: 'error' });
    }
  };

  // 安装插件
  const installAddon = async (type: number) => {
    if (!gamePath) {
      const errorMsg = '请先选择魔兽世界安装目录';
      setMessage({ text: errorMsg, type: 'error' });
      return;
    }
    console.log('👻 ~ gamePath:', gamePath);

    try {
      setIsInstalling(true);
      setMessage({ text: '正在安装插件，请稍候...', type: 'info' });

      const pluginType = pluginsMap[type];
      if (!pluginType) {
        throw new Error(`未知的插件类型: ${type}`);
      }

      // 调用后端API安装插件
      const result = await invoke<string>('install_addon', {
        pluginType,
        targetDir: gamePath + '/Interface/AddOns'
      });

      setMessage({ text: result, type: 'success' });
    } catch (error) {
      setMessage({
        text: `安装失败: ${error instanceof Error ? error.message : String(error)}`,
        type: 'error'
      });
    } finally {
      setIsInstalling(false);
    }
  };

  return (
    <div>
      <p className='install-description'>请选择魔兽世界目录，然后点击安装按钮。</p>

      <div className='path-selection'>
        <div className='path-item'>
          <label>
            <b>第1步: 选择游戏目录</b>
          </label>
          <div className='path-input-group'>
            <input
              type='text'
              value={gamePath}
              readOnly
              placeholder='选择魔兽世界AddOns目录'
              style={{
                backgroundColor: gamePath ? '#f0fff0' : '#fff0f0',
                borderColor: gamePath ? 'green' : '#ccc'
              }}
            />
            <button onClick={selectGamePath} disabled={isInstalling} style={{ fontWeight: 'bold' }}>
              浏览...
            </button>
          </div>
          {!gamePath && (
            <p style={{ color: 'red', fontSize: '0.9em' }}>请先选择游戏插件目录，再进行安装</p>
          )}
        </div>
      </div>

      <div className='install-actions'>
        <label>
          <b>第2步: 选择要安装的插件</b>
        </label>
        <div style={{ display: 'flex', gap: '10px', marginTop: '10px' }}>
          <button
            className='install-button'
            onClick={() => installAddon(2)}
            disabled={isInstalling || !gamePath}
          >
            {isInstalling ? '安装中...' : '佳佳-WLK'}
          </button>
          <button
            className='install-button'
            onClick={() => installAddon(3)}
            disabled={isInstalling || !gamePath}
          >
            {isInstalling ? '安装中...' : '佳佳-正式服'}
          </button>
          <button
            className='install-button'
            onClick={() => installAddon(4)}
            disabled={isInstalling || !gamePath}
          >
            {isInstalling ? '安装中...' : 'AutoHelp'}
          </button>
        </div>
      </div>

      {message.text && <div className={`message ${message.type}`}>{message.text}</div>}

      <div className='install-help'>
        <h3>帮助说明:</h3>
        <ul>
          <li>怀旧服选择_classic_文件夹: World of Warcraft\_classic_</li>
          <li>正式服选择_retail_文件夹: World of Warcraft\_retail_</li>
          <li>安装完成后重启游戏即可使用插件</li>
        </ul>
      </div>
    </div>
  );
};

export default Install;
