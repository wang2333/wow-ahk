import { useEffect, useState } from 'react';

import mode1 from '@/assets/mode1.wav';
import mode2 from '@/assets/mode2.wav';
import pause from '@/assets/pause.wav';
import { invoke } from '@tauri-apps/api/core';
import { register, unregister } from '@tauri-apps/plugin-global-shortcut';
import { useAuth } from '@/contexts/AuthContext';
import {
  color_mappings_JIAJIA,
  color_mappings_ZHUZHU,
  color_mappings_XIAOYI_SS,
  color_mappings_XIAOYI_LR,
  rgbToHex
} from './config';
import styles from './index.module.css';

interface ColorInfo {
  r: number;
  g: number;
  b: number;
}
type ColorMapping = 'JIAJIA' | 'ZHUZHU' | 'XIAOYI_SS' | 'XIAOYI_LR';

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
  const { user, updateWowCoordinates } = useAuth();
  const [color, setColor] = useState<string | null>(null);
  const [model, setModel] = useState(0);
  const [autoMove, setAutoMove] = useState(false);
  const [moveInterval, setMoveInterval] = useState(500);
  const [moveKeys, setMoveKeys] = useState('T');
  const [selectedMapping, setSelectedMapping] = useState<ColorMapping>('JIAJIA');

  const colorMapDict = {
    JIAJIA: color_mappings_JIAJIA,
    ZHUZHU: color_mappings_ZHUZHU,
    XIAOYI_SS: color_mappings_XIAOYI_SS,
    XIAOYI_LR: color_mappings_XIAOYI_LR
  };
  const color_mappings = colorMapDict[selectedMapping];

  // 从用户设置中获取坐标，如果没有则使用默认值
  const [coordinates, setCoordinates] = useState({
    x1: user?.settings?.wowCoordinates?.x1 || 2,
    x2: user?.settings?.wowCoordinates?.x2 || 2550,
    y: user?.settings?.wowCoordinates?.y || 30
  });

  // 当用户或用户设置变化时，更新坐标
  useEffect(() => {
    console.log('👻 ~ user:', user);
    if (user?.settings?.wowCoordinates) {
      setCoordinates(prev => ({
        ...prev,
        x1: user.settings.wowCoordinates.x1,
        x2: user.settings.wowCoordinates.x2,
        y: user.settings.wowCoordinates.y
      }));
    }
  }, [user, user?.settings]);

  // 注册全局热键
  useEffect(() => {
    registerShortcuts();
    // 清理函数：注销所有热键
    return () => {
      cleanup();
    };
  }, []);

  const autokey = async (params: { x: number; y: number }) => {
    const newColor = await invoke<ColorInfo>('get_pixel_color', params);
    // 转换为十六进制格式
    const hexColor = rgbToHex(newColor.r, newColor.g, newColor.b);
    setColor(hexColor);

    const keyCombo1 = color_mappings?.[hexColor.toLowerCase()];
    if (keyCombo1) {
      await invoke('press_keys', { keys: keyCombo1.split('-') });
      return;
    }
    const keyCombo2 = color_mappings?.[hexColor.toUpperCase()];
    if (keyCombo2) {
      await invoke('press_keys', { keys: keyCombo2.split('-') });
      return;
    }
  };

  useEffect(() => {
    let isRunning = true;
    let currentIndex = 0;

    const handleCheckColor = async () => {
      if (!isRunning) return;

      if (selectedMapping === 'XIAOYI_LR' || selectedMapping === 'XIAOYI_SS') {
        await autokey({
          x: coordinates.x1 + 34,
          y: coordinates.y
        });
      }

      await autokey({
        x: model === 1 || selectedMapping !== 'JIAJIA' ? coordinates.x1 : coordinates.x2,
        y: coordinates.y
      });

      // 递归调用，确保前一个操作完成后才开始下一个
      handleCheckColor();
    };

    const handleMove = async () => {
      if (!isRunning) return;

      const point = MOUSE_POSITIONS[currentIndex];
      await invoke('move_mouse_to_point', { x: point.x, y: point.y });
      currentIndex = (currentIndex + 1) % MOUSE_POSITIONS.length;
      await invoke('press_keys', { keys: [moveKeys] });

      setTimeout(handleMove, moveInterval);
    };

    // 启动检测
    if (model !== 0) {
      handleCheckColor();
      // 自动移动鼠标拾取
      if (autoMove) {
        handleMove();
      }
    }
    return () => {
      isRunning = false;
    };
  }, [model, coordinates, autoMove, moveInterval, selectedMapping]);

  const registerShortcuts = async () => {
    try {
      // 注册F1热键
      await register('F1', async e => {
        if (e.state === 'Pressed') {
          if (selectedMapping === 'XIAOYI_LR') {
            await invoke('press_keys', { keys: ['SHIFT', 'F11'] });
          } else if (selectedMapping === 'XIAOYI_SS') {
            await invoke('press_keys', { keys: ['ALT', 'SHIFT', 'F11'] });
          }
          setModel(1);
          mode1Audio.play().catch(console.error);
        }
      });

      // 注册F2热键
      await register('F2', async e => {
        if (e.state === 'Pressed') {
          if (selectedMapping === 'XIAOYI_LR') {
            await invoke('press_keys', { keys: ['ALT', 'CTRL', 'SHIFT', 'F11'] });
          } else if (selectedMapping === 'XIAOYI_SS') {
            await invoke('press_keys', { keys: ['ALT', 'CTRL', 'SHIFT', 'F11'] });
          }
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

      await register('F8', async e => {
        if (e.state === 'Pressed') {
          const info = await invoke<{ x: number; y: number }>('get_current_position_color');
          if (info) {
            const newCoordinates = {
              ...coordinates,
              x1: info.x,
              y: info.y
            };
            setCoordinates(newCoordinates);
            // 更新用户设置中的坐标
            updateWowCoordinates(newCoordinates);
          }
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
      await unregister('F8');
    } catch (error) {
      console.error('注销热键失败:', error);
    }
  };

  const handleCoordinateChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    const newValue = parseInt(value) || 0;
    const newCoordinates = {
      ...coordinates,
      [name]: newValue
    };

    setCoordinates(newCoordinates);
    // 更新用户设置中的坐标
    updateWowCoordinates(newCoordinates);
  };

  const handleIntervalChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const value = parseInt(e.target.value) || 500;
    setMoveInterval(Math.max(100, value));
  };

  return (
    <div className={styles.container}>
      {/* 坐标设置区域 */}
      <div className={styles.card}>
        <h3 className={styles.cardTitle}>
          基础设置
          <span
            className={`${styles.statusLabel} ${
              model === 1 ? styles.statusLabelMode1 : model === 2 ? styles.statusLabelMode2 : ''
            }`}
          >
            当前模式: {model === 0 ? '已暂停' : model === 1 ? '模式1' : '模式2'}
          </span>
          {color && <span className={styles.statusLabel}>执行按键：{color_mappings?.[color]}</span>}
        </h3>
        <div className={styles.settingsContainer}>
          <div className={styles.mappingSelection}>
            <label className={styles.label}>配置选择</label>
            <select
              value={selectedMapping}
              onChange={e => setSelectedMapping(e.target.value as ColorMapping)}
              className={styles.input}
            >
              <option value='JIAJIA'>佳佳一键宏</option>
              <option value='ZHUZHU'>猪猪一键宏</option>
              <option value='XIAOYI_SS'>小易SS一键宏</option>
              <option value='XIAOYI_LR'>小易LR一键宏</option>
            </select>
          </div>
          <div className={styles.coordinateInputs}>
            <div className={styles.inputGroup}>
              <label className={styles.label}>X坐标</label>
              <input
                type='number'
                name='x1'
                value={coordinates.x1}
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
          <div className={styles.inputGroupCompact}>
            <label className={styles.label}>拾取按键</label>
            <select
              value={moveKeys}
              onChange={e => setMoveKeys(e.target.value)}
              className={styles.input}
            >
              <option value='T'>T</option>
              <option value='Q'>Q</option>
            </select>
          </div>
        </div>
      </div>
    </div>
  );
}

export default WOW;
