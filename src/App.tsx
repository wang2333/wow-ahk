import { useState, useEffect } from 'react';
import { invoke } from '@tauri-apps/api/core';
import { register, unregister } from '@tauri-apps/plugin-global-shortcut';
import { color_mappings, rgbToHex } from './config';
import './App.css';
import mode1 from './assets/mode1.wav';
import mode2 from './assets/mode2.wav';
import pause from './assets/pause.wav';

interface ColorInfo {
  r: number;
  g: number;
  b: number;
}

// 创建音频对象
const mode1Audio = new Audio(mode1);
const mode2Audio = new Audio(mode2);
const pauseAudio = new Audio(pause);

function App() {
  const [color, setColor] = useState<string | null>(null);
  const [model, setModel] = useState(0);
  const [autoMove, setAutoMove] = useState(false);
  const [path, setPath] = useState('');
  const [coordinates, setCoordinates] = useState({
    x1: 100,
    x2: 200,
    y: 100
  });

  const registerShortcuts = async () => {
    try {
      // 注册F1热键
      await register('F1', async () => {
        console.log('1 :>> ', 1);
        setModel(1);
        mode1Audio.play().catch(console.error);
      });

      // 注册F2热键
      await register('F2', async () => {
        setModel(2);
        mode2Audio.play().catch(console.error);
      });

      // 注册F3热键
      await register('F3', async () => {
        setModel(0);
        setColor(null);
        pauseAudio.play().catch(console.error);
      });
    } catch (error) {
      console.error('注册热键失败:', error);
    }
  };
  const cleanup = async () => {
    try {
      await unregister('F1');
      await unregister('F2');
      await unregister('F3');
    } catch (error) {
      console.error('注销热键失败:', error);
    }
  };

  // 注册全局热键
  useEffect(() => {
    registerShortcuts();
    // 清理函数：注销所有热键
    return () => {
      cleanup();
    };
  }, []);

  useEffect(() => {
    let intervalId: number | null = null;

    if (model !== 0) {
      intervalId = window.setInterval(async () => {
        const newColor = await invoke<ColorInfo | null>('get_pixel_color', {
          x: model === 1 ? coordinates.x1 : coordinates.x2,
          y: coordinates.y
        });

        if (newColor) {
          // 转换为十六进制格式
          const hexColor = rgbToHex(newColor.r, newColor.g, newColor.b);
          setColor(hexColor);

          const keyCombo = color_mappings[hexColor];
          // 检查颜色匹配并触发按键
          if (keyCombo) {
            await invoke('press_keys', { keys: keyCombo.split('-') });
          }
        }
      }, 100);
    }

    return () => {
      if (intervalId !== null) {
        clearInterval(intervalId);
      }
    };
  }, [model, coordinates]);

  useEffect(() => {
    if (autoMove && path && model !== 0) {
      const moveMouseOnPath = async () => {
        try {
          await invoke('move_mouse', { path });
        } catch (error) {
          console.error('鼠标移动失败:', error);
        }
      };

      moveMouseOnPath();
    }
  }, [autoMove, path, model]);

  const handleCoordinateChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setCoordinates(prev => ({
      ...prev,
      [name]: parseInt(value) || 0
    }));
  };

  return (
    <main className='container'>
      <div className='coordinate-inputs'>
        <div>
          <label>X1: </label>
          <input type='number' name='x1' value={coordinates.x1} onChange={handleCoordinateChange} />
        </div>
        <div>
          <label>X2: </label>
          <input type='number' name='x2' value={coordinates.x2} onChange={handleCoordinateChange} />
        </div>
        <div>
          <label>Y: </label>
          <input
            type='number'
            name='y'
            value={coordinates.y}
            onChange={handleCoordinateChange}
            min='0'
          />
        </div>
      </div>

      <div className='auto-move-section'>
        <div>
          <label>
            <input
              type='checkbox'
              checked={autoMove}
              onChange={e => setAutoMove(e.target.checked)}
            />
            启用挂机移动
          </label>
        </div>
        <div>
          <label>移动路径: </label>
          <input
            type='text'
            value={path}
            onChange={e => setPath(e.target.value)}
            placeholder='格式: x1,y1;x2,y2;x3,y3'
          />
        </div>
      </div>

      {color && (
        <div className='color-info'>
          <p>检测到的颜色值：</p>
          <p>{color}</p>
          <div
            className='color-preview'
            style={{
              width: '50px',
              height: '50px',
              backgroundColor: color,
              border: '1px solid #ccc',
              margin: '10px auto'
            }}
          />
        </div>
      )}
    </main>
  );
}

export default App;
