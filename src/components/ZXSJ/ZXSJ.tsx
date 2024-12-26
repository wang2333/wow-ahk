import { useEffect, useState } from 'react';

import { invoke } from '@tauri-apps/api/core';
import { BaseDirectory, readTextFile, writeTextFile } from '@tauri-apps/plugin-fs';
import { register, unregister } from '@tauri-apps/plugin-global-shortcut';
import styles from './index.module.css';

interface ColorInfo {
  r: number;
  g: number;
  b: number;
}

interface PositionColorInfo {
  x: number;
  y: number;
  color: ColorInfo;
}

interface MonitorPoint {
  id: string;
  x: number;
  y: number;
  targetColor: string;
  keys: string[];
}

const CONFIG_FILE = 'zxsj-config.json';

function ZXSJ() {
  const [isRunning, setIsRunning] = useState(false);
  const [points, setPoints] = useState<MonitorPoint[]>([]);
  const [editingPoint, setEditingPoint] = useState<MonitorPoint>({
    id: '',
    x: 0,
    y: 0,
    targetColor: '#000000',
    keys: []
  });
  const [isPicking, setIsPicking] = useState(false);

  useEffect(() => {
    // 加载配置
    loadConfig();
    // 注册热键
    registerShortcuts();
    return () => {
      cleanup();
    };
  }, []);

  // 监控点位颜色
  useEffect(() => {
    let intervalId: number | null = null;

    if (isRunning && points.length > 0) {
      intervalId = window.setInterval(async () => {
        for (const point of points) {
          const color = await invoke<ColorInfo | null>('get_pixel_color', {
            x: Number(point.x),
            y: Number(point.y)
          });

          if (color) {
            const hexColor = rgbToHex(color.r, color.g, color.b);
            if (hexColor.toLowerCase() === point.targetColor.toLowerCase()) {
              await invoke('press_keys', { keys: point.keys });
            }
          }
        }
      }, 100);
    }

    return () => {
      if (intervalId !== null) {
        clearInterval(intervalId);
      }
    };
  }, [isRunning, points]);

  const loadConfig = async () => {
    try {
      const content = await readTextFile(CONFIG_FILE, { baseDir: BaseDirectory.Desktop });
      const savedPoints = JSON.parse(content);
      if (Array.isArray(savedPoints)) {
        setPoints(savedPoints);
      }
    } catch (error) {
      console.log('No config file found or invalid format');
    }
  };

  const saveConfig = async () => {
    try {
      await writeTextFile(CONFIG_FILE, JSON.stringify(points, null, 2), {
        baseDir: BaseDirectory.Desktop
      });
    } catch (error) {
      console.error('Failed to save config:', error);
    }
  };

  const registerShortcuts = async () => {
    try {
      await register('F1', e => {
        if (e.state === 'Pressed') {
          setIsRunning(prev => !prev);
        }
      });
    } catch (error) {
      console.error('注册热键失败:', error);
    }
  };

  const cleanup = async () => {
    try {
      await unregister('F1');
    } catch (error) {
      console.error('注销热键失败:', error);
    }
  };

  const rgbToHex = (r: number, g: number, b: number): string => {
    const toHex = (n: number) => {
      const hex = n.toString(16);
      return hex.length === 1 ? '0' + hex : hex;
    };
    return `#${toHex(r)}${toHex(g)}${toHex(b)}`;
  };

  const handlePickColor = async () => {
    setIsPicking(true);
    try {
      await register('F2', async e => {
        if (e.state === 'Pressed') {
          const info = await invoke<PositionColorInfo>('get_current_position_color');
          if (info) {
            const hexColor = rgbToHex(info.color.r, info.color.g, info.color.b);
            setEditingPoint(prev => ({
              ...prev,
              x: info.x,
              y: info.y,
              targetColor: hexColor
            }));
            setIsPicking(false);
            await unregister('F2');
          }
        }
      });
    } catch (error) {
      console.error('注册取色热键失败:', error);
      setIsPicking(false);
    }
  };

  const handleAddPoint = async () => {
    if (editingPoint.id) {
      // 更新现有点位
      setPoints(points.map(p => (p.id === editingPoint.id ? editingPoint : p)));
    } else {
      // 添加新点位
      setPoints([
        ...points,
        {
          ...editingPoint,
          id: Date.now().toString()
        }
      ]);
    }
    // 重置编辑状态
    setEditingPoint({
      id: '',
      x: 0,
      y: 0,
      targetColor: '#000000',
      keys: []
    });
  };

  const handleEditPoint = (point: MonitorPoint) => {
    setEditingPoint(point);
  };

  const handleDeletePoint = async (id: string) => {
    setPoints(points.filter(p => p.id !== id));
  };

  const movePointUp = (index: number) => {
    if (index > 0) {
      const newPoints = [...points];
      [newPoints[index - 1], newPoints[index]] = [newPoints[index], newPoints[index - 1]];
      setPoints(newPoints);
    }
  };

  const movePointDown = (index: number) => {
    if (index < points.length - 1) {
      const newPoints = [...points];
      [newPoints[index], newPoints[index + 1]] = [newPoints[index + 1], newPoints[index]];
      setPoints(newPoints);
    }
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setEditingPoint(prev => ({
      ...prev,
      [name]: name === 'keys' ? [value] : value
    }));
  };

  return (
    <div className={styles.container}>
      {/* 添加/编辑点位表单 */}
      <div className={styles.card}>
        <div className={styles.cardHeader}>
          <h3 className={styles.cardTitle}>{editingPoint.id ? '编辑点位' : '添加点位'}</h3>
          <div className={styles.cardActions}>
            <button className={styles.btnPick} onClick={saveConfig}>
              保存配置
            </button>
            <button className={styles.btnPick} onClick={handlePickColor} disabled={isPicking}>
              {isPicking ? '按F2拾取' : '拾取坐标和色值'}
            </button>

            <button className={styles.btnPrimary} onClick={handleAddPoint}>
              {editingPoint.id ? '更新点位' : '添加点位'}
            </button>
          </div>
        </div>
        <div className={styles.formContent}>
          <div className={styles.formRow}>
            <div className={styles.inputGroup}>
              <label className={styles.label}>X 坐标</label>
              <input
                type='number'
                name='x'
                value={editingPoint.x}
                onChange={handleInputChange}
                className={styles.input}
              />
            </div>
            <div className={styles.inputGroup}>
              <label className={styles.label}>Y 坐标</label>
              <input
                type='number'
                name='y'
                value={editingPoint.y}
                onChange={handleInputChange}
                className={styles.input}
              />
            </div>
          </div>
          <div className={styles.formRow}>
            <div className={styles.inputGroup}>
              <label className={styles.label}>色值</label>
              <div className={styles.colorInputGroup}>
                <input
                  type='color'
                  name='targetColor'
                  value={editingPoint.targetColor}
                  onChange={handleInputChange}
                  className={styles.colorInput}
                />
                <input
                  type='text'
                  name='targetColor'
                  value={editingPoint.targetColor}
                  onChange={handleInputChange}
                  className={styles.input}
                />
              </div>
            </div>
            <div className={styles.inputGroup}>
              <label className={styles.label}>按键</label>
              <input
                type='text'
                name='keys'
                value={editingPoint.keys[0] || ''}
                onChange={handleInputChange}
                className={styles.input}
                placeholder='例如: a'
              />
            </div>
          </div>
        </div>
      </div>

      {/* 点位列表 */}
      <div className={styles.card}>
        <div className={styles.cardHeader}>
          <h3 className={styles.cardTitle}>监控点位</h3>
          <div className={isRunning ? styles.statusRunning : styles.statusPaused}>
            状态: {isRunning ? '运行中' : '已暂停'} (F1切换)
          </div>
        </div>
        <div className={styles.pointsList}>
          {points.length > 0 ? (
            <table className={styles.pointsTable}>
              <thead>
                <tr>
                  <th className={styles.pointsTableHeader}>优先级</th>
                  <th className={styles.pointsTableHeader}>坐标</th>
                  <th className={styles.pointsTableHeader}>色值</th>
                  <th className={styles.pointsTableHeader}>按键</th>
                  <th className={styles.pointsTableHeader}>操作</th>
                </tr>
              </thead>
              <tbody>
                {points.map((point, index) => (
                  <tr key={point.id} className={styles.pointItem}>
                    <td className={styles.pointPriority}>{index + 1}</td>
                    <td className={styles.pointLocation}>
                      {point.x}, {point.y}
                    </td>
                    <td className={styles.pointColorCell}>
                      <div
                        className={styles.pointColor}
                        style={{ backgroundColor: point.targetColor }}
                      >
                        {point.targetColor}
                      </div>
                    </td>
                    <td className={styles.pointKeys}>{point.keys.join(', ')}</td>
                    <td className={styles.pointsTableCell}>
                      <div className={styles.pointActions}>
                        <button
                          className={styles.btnIcon}
                          onClick={() => movePointUp(index)}
                          disabled={index === 0}
                        >
                          ↑
                        </button>
                        <button
                          className={styles.btnIcon}
                          onClick={() => movePointDown(index)}
                          disabled={index === points.length - 1}
                        >
                          ↓
                        </button>
                        <button className={styles.btnIcon} onClick={() => handleEditPoint(point)}>
                          编辑
                        </button>
                        <button
                          className={styles.btnIconDanger}
                          onClick={() => handleDeletePoint(point.id)}
                        >
                          删除
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          ) : (
            <div className={styles.emptyState}>暂无监控点位</div>
          )}
        </div>
      </div>
    </div>
  );
}

export default ZXSJ;
