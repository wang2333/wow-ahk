import { useEffect, useState } from 'react';

import mode1 from '@/assets/mode1.wav';
import mode2 from '@/assets/mode2.wav';
import pause from '@/assets/pause.wav';
import { useAuth } from '@/contexts/AuthContext';
import { invoke } from '@tauri-apps/api/core';
import { register, unregister } from '@tauri-apps/plugin-global-shortcut';
import {
  color_mappings_JIAJIA,
  color_mappings_JIAJIA_REAL,
  color_mappings_XIAOYI_LR,
  color_mappings_XIAOYI_SS,
  color_mappings_ZHUZHU,
  rgbToHex
} from './config';
import styles from './index.module.css';

interface ColorInfo {
  r: number;
  g: number;
  b: number;
}
type ColorMapping = 'JIAJIA' | 'JIAJIA_REAL' | 'ZHUZHU' | 'XIAOYI_SS' | 'XIAOYI_LR' | 'AH';

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

const colorMapDict = {
  JIAJIA: color_mappings_JIAJIA,
  JIAJIA_REAL: color_mappings_JIAJIA_REAL,
  ZHUZHU: color_mappings_ZHUZHU,
  XIAOYI_SS: color_mappings_XIAOYI_SS,
  XIAOYI_LR: color_mappings_XIAOYI_LR,
  AH: null
};

// function findSolutions(targetF, targetG) {
//   const solutions = [];

//   // Loop over all possible values for b, c, d, a (from 0 to 14)
//   for (let b = 0; b <= 14; b++) {
//       for (let c = 0; c <= 14; c++) {
//           const f = b * 14 + c;
//           if (f === targetF) {
//               for (let d = 0; d <= 14; d++) {
//                   for (let a = 0; a <= 14; a++) {
//                       const g = d * 14 + a;
//                       if (g === targetG) {
//                           solutions.push({ a, b, c, d });
//                       }
//                   }
//               }
//           }
//       }
//   }
//   return solutions;
// }

// Example usage:
// const targetF = 200;
// const targetG = 300;
// const solutions = findSolutions(targetF, targetG);
// console.log(solutions);

function getKeyNum(targetNum: number, actionNum: number) {
  const keyMap = [
    'NUMPAD4',
    'NUMPAD5',
    'NUMPAD6',
    'NUMPAD1',
    'NUMPAD2',
    'NUMPAD3',
    'NUMPADDIVIDE',
    'NUMPADMULTIPLY',
    'NUMPADMINUS',
    'NUMPADPLUS',
    'NUMPAD7',
    'NUMPAD8',
    'NUMPAD9'
  ];

  const keyNum1 = Math.floor(targetNum / 13);
  const keyNum2 = targetNum % 13;
  const keyNum3 = Math.floor(actionNum / 13);
  const keyNum4 = actionNum % 13;
  // const f = keyNum2 * 13 + keyNum3;
  // const g = keyNum4 * 13 + keyNum1;
  return [keyMap[keyNum1], keyMap[keyNum2], keyMap[keyNum3], keyMap[keyNum4]];
}

function WOW() {
  const { userInfo, gameSettings, updateWowCoordinates, updateHotkeySettings, checkUser } =
    useAuth();
  const [color, setColor] = useState<string | null>(null);
  const [model, setModel] = useState(0);
  const [autoMove, setAutoMove] = useState(false);
  const [moveInterval, setMoveInterval] = useState(500);
  const [moveKeys, setMoveKeys] = useState('T');
  const [configs, setConfigs] = useState<{ value: string; label: string }[]>([]);
  const [selectedMapping, setSelectedMapping] = useState<ColorMapping>('JIAJIA');

  // 添加自定义热键状态，从游戏设置中加载
  const [hotkeys, setHotkeys] = useState({
    mode1Key: gameSettings?.hotkeySettings?.mode1Key || '',
    mode2Key: gameSettings?.hotkeySettings?.mode2Key || '',
    pauseKey: gameSettings?.hotkeySettings?.pauseKey || ''
  });

  // 从游戏设置中获取坐标
  const [coordinates, setCoordinates] = useState({
    x1: gameSettings?.wowCoordinates?.x1 || 2,
    x2: gameSettings?.wowCoordinates?.x2 || 2550,
    y: gameSettings?.wowCoordinates?.y || 30
  });

  const color_mappings = colorMapDict[selectedMapping];

  useEffect(() => {
    let configs = [];
    const userType = userInfo && userInfo.userType ? userInfo.userType.toString() : '';
    if (userType) {
      if (userType === '0' || userType === '99') {
        configs.push({ value: 'ZHUZHU', label: '猪猪一键宏' });
        configs.push({ value: 'JIAJIA', label: '佳佳一键宏-WLK' });
        configs.push({ value: 'JIAJIA_REAL', label: '佳佳一键宏-正式服' });
        configs.push({ value: 'XIAOYI_SS', label: '小易一键宏-术士' });
        configs.push({ value: 'XIAOYI_LR', label: '小易一键宏-猎人' });
        configs.push({ value: 'AH', label: 'AH一键宏' });
      }
      if (userType.includes('1')) {
        configs.push({ value: 'ZHUZHU', label: '猪猪一键宏' });
      }
      if (userType.includes('2')) {
        configs.push({ value: 'JIAJIA', label: '佳佳一键宏-WLK' });
      }
      if (userType.includes('3')) {
        configs.push({ value: 'JIAJIA_REAL', label: '佳佳一键宏-正式服' });
      }
      if (userType.includes('4')) {
        configs.push({ value: 'AH', label: 'AH一键宏' });
      }
      if (userType.includes('5')) {
        configs.push({ value: 'XIAOYI_SS', label: '小易一键宏-术士' });
        configs.push({ value: 'XIAOYI_LR', label: '小易一键宏-猎人' });
      }
    }
    if (configs.length) {
      setConfigs(configs);
      setSelectedMapping(configs[0].value as ColorMapping);
    }
  }, [userInfo]);

  // 当游戏设置变化时，更新坐标和热键设置
  useEffect(() => {
    if (gameSettings?.wowCoordinates) {
      setCoordinates(prev => ({
        ...prev,
        x1: gameSettings.wowCoordinates.x1,
        x2: gameSettings.wowCoordinates.x2,
        y: gameSettings.wowCoordinates.y
      }));
    }
    if (gameSettings?.hotkeySettings) {
      setHotkeys(prev => ({
        ...prev,
        mode1Key: gameSettings.hotkeySettings.mode1Key || prev.mode1Key,
        mode2Key: gameSettings.hotkeySettings.mode2Key || prev.mode2Key,
        pauseKey: gameSettings.hotkeySettings.pauseKey || prev.pauseKey
      }));
    }
  }, [gameSettings]);

  // 注册全局热键
  useEffect(() => {
    registerShortcuts();
    // 清理函数：注销所有热键
    return () => {
      cleanup();
    };
  }, [hotkeys]); // 添加hotkeys作为依赖项，当热键改变时重新注册

  useEffect(() => {
    let isRunning = true;
    let currentIndex = 0;

    const autokey = async (params: { x: number; y: number }) => {
      const newColor = await invoke<ColorInfo>('get_pixel_color', params);
      if (!newColor) return;
      if (selectedMapping === 'AH') {
        if (newColor.g !== 0 && newColor.b !== 0) {
          const keys = getKeyNum(newColor.g, newColor.b).filter(v => !!v);
          if (keys.length === 4) {
            let promises = [];
            for await (const key of keys) {
              promises.push(invoke('press_keys', { keys: [key] }));
            }
            promises.push(setTimeout(() => Promise.resolve(), 200));
            await Promise.all(promises);
          }
        }
        return;
      }

      let hexColor = '';
      // 转换为十六进制格式
      if (selectedMapping === 'JIAJIA_REAL') {
        hexColor = rgbToHex(newColor.b, newColor.g, newColor.r);
      } else {
        hexColor = rgbToHex(newColor.r, newColor.g, newColor.b);
      }
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

    const handleCheckColor = async () => {
      if (!isRunning) return;

      if (selectedMapping === 'XIAOYI_LR' || selectedMapping === 'XIAOYI_SS') {
        await autokey({
          x: coordinates.x1 + 34,
          y: coordinates.y
        });
      }

      await autokey({
        x:
          model === 1 || (selectedMapping !== 'JIAJIA' && selectedMapping !== 'JIAJIA_REAL')
            ? coordinates.x1
            : coordinates.x2,
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
      // 在注册前先尝试注销所有热键，防止重复注册
      await cleanup();
      if (hotkeys.mode1Key) {
        // 注册模式1热键
        await register(hotkeys.mode1Key, async e => {
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
      }
      if (hotkeys.mode2Key) {
        // 注册模式2热键
        await register(hotkeys.mode2Key, async e => {
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
      }

      if (hotkeys.pauseKey) {
        // 注册暂停热键
        await register(hotkeys.pauseKey, async e => {
          if (e.state === 'Pressed') {
            setModel(0);
            setColor(null);
            pauseAudio.play().catch(console.error);
          }
        });
      }

      // 注册坐标获取热键
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
      await register('F9', async e => {
        if (e.state === 'Pressed') {
          const info = await invoke<{ x: number; y: number }>('get_current_position_color');
          if (info) {
            const newCoordinates = {
              ...coordinates,
              x2: info.x,
              y: info.y
            };
            setCoordinates(newCoordinates);
            // 更新用户设置中的坐标
            updateWowCoordinates(newCoordinates);
          }
        }
      });
      await checkUser();
    } catch (error) {
      console.error('注册热键失败:', error);
    }
  };

  const cleanup = async () => {
    try {
      // 使用try-catch分别处理每个热键的注销，确保一个失败不影响其他热键
      try {
        hotkeys.mode1Key && (await unregister(hotkeys.mode1Key));
      } catch (e) {
        console.log(`${hotkeys.mode1Key}热键注销:`, e);
      }
      try {
        hotkeys.mode2Key && (await unregister(hotkeys.mode2Key));
      } catch (e) {
        console.log(`${hotkeys.mode2Key}热键注销:`, e);
      }
      try {
        hotkeys.pauseKey && (await unregister(hotkeys.pauseKey));
      } catch (e) {
        console.log(`${hotkeys.pauseKey}热键注销:`, e);
      }
      try {
        await unregister('F8');
      } catch (e) {
        console.log(`F8热键注销:`, e);
      }
      try {
        await unregister('F9');
      } catch (e) {
        console.log(`F9热键注销:`, e);
      }
    } catch (error) {
      console.error('注销热键失败:', error);
    }
  };

  const handleHotkeyChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const { name, value } = e.target;
    const newHotkeys = {
      ...hotkeys,
      [name]: value
    };

    setHotkeys(newHotkeys);
    // 更新用户设置中的热键
    updateHotkeySettings(newHotkeys);
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

  // 创建可用热键选项列表
  const availableHotkeys = ['', '`', 'F1', 'F2', 'F3', '1', '2', '3', 'Q', 'W', 'E', 'R', 'T'];

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
          {color && (
            <span className={styles.statusLabel}>
              执行按键：
              {color_mappings?.[color.toLowerCase()] || color_mappings?.[color.toUpperCase()]}
            </span>
          )}
        </h3>
        <div className={styles.settingsContainer}>
          <div className={styles.mappingSelection}>
            <label className={styles.label}>配置选择</label>
            <select
              value={selectedMapping}
              onChange={e => setSelectedMapping(e.target.value as ColorMapping)}
              className={styles.input}
            >
              {configs.map(config => (
                <option key={config.value} value={config.value}>
                  {config.label}
                </option>
              ))}
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

      {/* 新增热键设置区域 */}
      <div className={styles.card}>
        <h3 className={styles.cardTitle}>热键设置</h3>
        <div className={styles.controlSection}>
          <div className={styles.inputGroupCompact}>
            <label className={styles.label}>模式1热键</label>
            <select
              name='mode1Key'
              value={hotkeys.mode1Key}
              onChange={handleHotkeyChange}
              className={styles.input}
            >
              {availableHotkeys.map(key => (
                <option key={key} value={key}>
                  {key}
                </option>
              ))}
            </select>
          </div>
          <div className={styles.inputGroupCompact}>
            <label className={styles.label}>模式2热键</label>
            <select
              name='mode2Key'
              value={hotkeys.mode2Key}
              onChange={handleHotkeyChange}
              className={styles.input}
            >
              {availableHotkeys.map(key => (
                <option key={key} value={key}>
                  {key}
                </option>
              ))}
            </select>
          </div>
          <div className={styles.inputGroupCompact}>
            <label className={styles.label}>暂停热键</label>
            <select
              name='pauseKey'
              value={hotkeys.pauseKey}
              onChange={handleHotkeyChange}
              className={styles.input}
            >
              {availableHotkeys.map(key => (
                <option key={key} value={key}>
                  {key}
                </option>
              ))}
            </select>
          </div>
        </div>
      </div>

      {/* 鼠标移动控制区域 */}
      {userInfo?.userType === '99' && (
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
      )}
    </div>
  );
}

export default WOW;
