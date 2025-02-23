import { useEffect, useState } from 'react';

import mode1 from '@/assets/mode1.wav';
import mode2 from '@/assets/mode2.wav';
import pause from '@/assets/pause.wav';
import { invoke } from '@tauri-apps/api/core';
import { register, unregister } from '@tauri-apps/plugin-global-shortcut';
import { color_mappings, rgbToHex } from './config';
import styles from './index.module.css';

interface ColorInfo {
  r: number;
  g: number;
  b: number;
}

// 创建音频对象
const mode1Audio = new Audio(mode1);
const mode2Audio = new Audio(mode2);
const pauseAudio = new Audio(pause);

const MOUSE_CENTER = { x: 1275, y: 720 };
// 生成圆形轨迹坐标点
const MOUSE_POSITIONS: any = [];
for (let angle = 0; angle < 360; angle += 30) {
  const radian = (angle * Math.PI) / 180;
  MOUSE_POSITIONS.push({
    x: MOUSE_CENTER.x + 90 * Math.cos(radian),
    y: MOUSE_CENTER.y + 90 * Math.sin(radian)
  });
}
for (let angle = 0; angle < 360; angle += 30) {
  const radian = (angle * Math.PI) / 180;
  MOUSE_POSITIONS.push({
    x: MOUSE_CENTER.x + 60 * Math.cos(radian),
    y: MOUSE_CENTER.y + 60 * Math.sin(radian)
  });
}
MOUSE_POSITIONS.push(MOUSE_CENTER);

function WOW() {
  const [color, setColor] = useState<string | null>(null);
  const [model, setModel] = useState(0);
  const [autoMove, setAutoMove] = useState(false);
  const [moveInterval, setMoveInterval] = useState(700);

  const [coordinates, setCoordinates] = useState({
    x1: 1,
    x2: 2550,
    y: 25
  });

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
    let moveTimer: number | null = null;

    if (model !== 0) {
      intervalId = window.setInterval(async () => {
        const newColor = await invoke<ColorInfo>('get_pixel_color', {
          x: model === 1 ? coordinates.x1 : coordinates.x2,
          y: coordinates.y
        });

        // 转换为十六进制格式
        const hexColor = rgbToHex(newColor.r, newColor.g, newColor.b);
        setColor(hexColor);

        const keyCombo = color_mappings[hexColor];
        // 检查颜色匹配并触发按键

        if (keyCombo) {
          await invoke('press_keys', { keys: keyCombo.split('-') });
        }
      }, 100);
    }

    // 自动移动鼠标拾取
    if (autoMove && model !== 0) {
      let currentIndex = 0;
      moveTimer = window.setInterval(async () => {
        const point = MOUSE_POSITIONS[currentIndex];
        await invoke('move_mouse_to_point', { x: point.x, y: point.y });
        currentIndex = (currentIndex + 1) % MOUSE_POSITIONS.length;
        await invoke('press_keys', { keys: ['F12'] });
      }, moveInterval);
    }

    return () => {
      if (intervalId !== null) {
        clearInterval(intervalId);
      }
      if (moveTimer !== null) {
        clearInterval(moveTimer);
      }
    };
  }, [model, coordinates, autoMove, moveInterval]);

  const registerShortcuts = async () => {
    try {
      // 注册F1热键
      await register('F1', async e => {
        if (e.state === 'Pressed') {
          setModel(1);
          mode1Audio.play().catch(console.error);
        }
      });

      // 注册F2热键
      await register('F2', async e => {
        if (e.state === 'Pressed') {
          setModel(2);
          mode2Audio.play().catch(console.error);
        }
      });

      // 注册F3热键
      await register('F3', async e => {
        if (e.state === 'Pressed') {
          setModel(0);
          setColor(null);
          pauseAudio.play().catch(console.error);
        }
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

  const handleCoordinateChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setCoordinates(prev => ({
      ...prev,
      [name]: parseInt(value) || 0
    }));
  };

  const handleIntervalChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const value = parseInt(e.target.value) || 500;
    setMoveInterval(Math.max(100, value));
  };

  return (
    <div className={styles.container}>
      {/* 坐标设置区域 */}
      <div className={styles.card}>
        <h3 className={styles.cardTitle}>坐标设置</h3>
        <div className={styles.coordinateInputs}>
          <div className={styles.inputGroup}>
            <label className={styles.label}>X1 坐标</label>
            <input
              type='number'
              name='x1'
              value={coordinates.x1}
              onChange={handleCoordinateChange}
              className={styles.input}
            />
          </div>
          <div className={styles.inputGroup}>
            <label className={styles.label}>X2 坐标</label>
            <input
              type='number'
              name='x2'
              value={coordinates.x2}
              onChange={handleCoordinateChange}
              className={styles.input}
            />
          </div>
          <div className={styles.inputGroup}>
            <label className={styles.label}>Y 坐标</label>
            <input
              type='number'
              name='y'
              value={coordinates.y}
              onChange={handleCoordinateChange}
              min='0'
              className={styles.input}
            />
          </div>
        </div>
      </div>

      {/* 鼠标移动控制区域 */}
      <div className={styles.card}>
        <h3 className={styles.cardTitle}>
          <span>自动拾取设置</span>
          <label className={styles.toggleSwitch}>
            <input
              type='checkbox'
              checked={autoMove}
              onChange={e => setAutoMove(e.target.checked)}
              className={styles.toggleInput}
            />
            <span className={styles.toggleSlider}></span>
          </label>
        </h3>

        <div className={styles.controlSection}>
          <div className={styles.inputGroupCompact}>
            <label className={styles.label}>移动间隔(ms)</label>
            <input
              type='number'
              value={moveInterval}
              onChange={handleIntervalChange}
              min='100'
              step='100'
              className={styles.input}
            />
          </div>
        </div>
      </div>

      {/* 状态显示区域 */}
      <div className={styles.card}>
        <h3 className={styles.cardTitle}>运行状态</h3>
        <div className={styles.statusSection}>
          <div className={styles.statusGroup}>
            <span
              className={`${styles.statusLabel} ${
                model === 1 ? styles.statusLabelMode1 : model === 2 ? styles.statusLabelMode2 : ''
              }`}
            >
              当前模式: {model === 0 ? '已暂停' : model === 1 ? '模式1' : '模式2'}
            </span>

            {color && <span className={styles.statusLabel}>执行按键：{color_mappings[color]}</span>}
          </div>
        </div>
      </div>
    </div>
  );
}

export default WOW;
