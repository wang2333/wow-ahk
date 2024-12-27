import { useEffect, useState } from 'react';

import { invoke } from '@tauri-apps/api/core';
import { message } from '@tauri-apps/plugin-dialog';
import {
  BaseDirectory,
  create,
  exists,
  mkdir,
  readTextFile,
  writeTextFile
} from '@tauri-apps/plugin-fs';
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
  type: 'key' | 'buff';
  relatedBuffId?: string;
  buffName?: string;
}

const CONFIG_FILE = 'autokeyBox\\autoboxzxsj-config.json';

function ZXSJ() {
  const [isRunning, setIsRunning] = useState(false);
  const [keyPoints, setKeyPoints] = useState<MonitorPoint[]>([]);
  const [buffPoints, setBuffPoints] = useState<MonitorPoint[]>([]);
  const [editingPoint, setEditingPoint] = useState<MonitorPoint>({
    id: '',
    x: 0,
    y: 0,
    targetColor: '#000000',
    keys: [],
    type: 'key'
  });
  const [isPicking, setIsPicking] = useState(false);

  useEffect(() => {
    loadConfig();
    registerShortcuts();
    return () => {
      cleanup();
    };
  }, []);

  // 监控点位颜色
  useEffect(() => {
    let intervalId: number | null = null;

    if (isRunning && keyPoints.length > 0) {
      intervalId = window.setInterval(async () => {
        // 处理按键点位
        for (const point of keyPoints) {
          // 检查按键点位颜色
          const pointColor = await invoke<ColorInfo>('get_pixel_color', {
            x: Number(point.x),
            y: Number(point.y)
          });

          const pointHexColor = rgbToHex(pointColor.r, pointColor.g, pointColor.b);
          const pointColorMatched = pointHexColor.toLowerCase() === point.targetColor.toLowerCase();

          // 如果点位颜色匹配且有关联buff，则检查buff状态
          if (pointColorMatched) {
            if (point.relatedBuffId) {
              const relatedBuff = buffPoints.find(b => b.id === point.relatedBuffId);
              if (relatedBuff) {
                // 检查关联buff的颜色
                const buffColor = await invoke<ColorInfo>('get_pixel_color', {
                  x: Number(relatedBuff.x),
                  y: Number(relatedBuff.y)
                });
                const buffHexColor = rgbToHex(buffColor.r, buffColor.g, buffColor.b);
                const buffActive =
                  buffHexColor.toLowerCase() === relatedBuff.targetColor.toLowerCase();

                if (buffActive) {
                  await invoke('press_keys', { keys: point.keys });
                }
              }
            } else {
              // 没有关联buff，直接执行按键
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
  }, [isRunning, keyPoints, buffPoints]);

  const loadConfig = async () => {
    try {
      const content = await readTextFile(CONFIG_FILE, { baseDir: BaseDirectory.Desktop });
      const savedPoints = JSON.parse(content);
      if (Array.isArray(savedPoints)) {
        // 分离按键点位和buff点位
        const keys = savedPoints.filter(p => p.type === 'key' || !p.type);
        const buffs = savedPoints.filter(p => p.type === 'buff');
        setKeyPoints(keys);
        setBuffPoints(buffs);
      }
    } catch (error) {
      console.log('No config file found or invalid format');
    }
  };

  const saveConfig = async () => {
    try {
      // 合并两种点位保存
      const allPoints = [...keyPoints, ...buffPoints];
      const hasConfigFile = await exists(CONFIG_FILE, { baseDir: BaseDirectory.Desktop });
      if (!hasConfigFile) {
        await mkdir('autokeyBox', { baseDir: BaseDirectory.Desktop });
      }
      await writeTextFile(CONFIG_FILE, JSON.stringify(allPoints, null, 2), {
        baseDir: BaseDirectory.Desktop
      });
      await message('保存成功', { title: '提示', kind: 'info' });
    } catch (error) {
      console.error('Failed to save config:', error);
      await message('保存失败: ' + error, { title: '错误', kind: 'info' });
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
    const newPoint = {
      ...editingPoint,
      id: editingPoint.id || Date.now().toString()
    };

    if (editingPoint.id) {
      // 更新现有点位
      if (editingPoint.type === 'key') {
        setKeyPoints(points => points.map(p => (p.id === editingPoint.id ? newPoint : p)));
      } else {
        setBuffPoints(points => points.map(p => (p.id === editingPoint.id ? newPoint : p)));
      }
    } else {
      // 添加新点位
      if (newPoint.type === 'key') {
        setKeyPoints(points => [...points, newPoint]);
      } else {
        setBuffPoints(points => [...points, newPoint]);
      }
    }

    // 重置编辑状态
    setEditingPoint({
      id: '',
      x: 0,
      y: 0,
      targetColor: '#000000',
      keys: [],
      type: 'key'
    });
  };

  const handleEditPoint = (point: MonitorPoint) => {
    setEditingPoint(point);
  };

  const handleDeletePoint = async (id: string, type: 'key' | 'buff') => {
    if (type === 'key') {
      setKeyPoints(points => points.filter(p => p.id !== id));
    } else {
      setBuffPoints(points => points.filter(p => p.id !== id));
    }
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    const { name, value } = e.target;
    setEditingPoint(prev => ({
      ...prev,
      [name]: name === 'keys' ? [value] : value
    }));
  };

  const movePointUp = (index: number) => {
    if (index > 0) {
      const newPoints = [...keyPoints];
      [newPoints[index - 1], newPoints[index]] = [newPoints[index], newPoints[index - 1]];
      setKeyPoints(newPoints);
    }
  };

  const movePointDown = (index: number) => {
    if (index < keyPoints.length - 1) {
      const newPoints = [...keyPoints];
      [newPoints[index], newPoints[index + 1]] = [newPoints[index + 1], newPoints[index]];
      setKeyPoints(newPoints);
    }
  };

  const handleRelatedBuffChange = (pointId: string, buffId: string) => {
    setKeyPoints(points =>
      points.map(p =>
        p.id === pointId
          ? {
              ...p,
              relatedBuffId: buffId || undefined
            }
          : p
      )
    );
  };

  return (
    <div className={styles.container}>
      {/* 添加/编辑点位表�� */}
      <div className={styles.card}>
        <div className={styles.cardHeader}>
          <h3 className={styles.cardTitle}>{editingPoint.id ? '编辑点位' : '添加点位'}</h3>
          <div className={styles.cardActions}>
            <div className={isRunning ? styles.statusRunning : styles.statusPaused}>
              状态: {isRunning ? '运行中' : '已暂停'} (F1切换)
            </div>
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
              <label className={styles.label}>点位类型</label>
              <select
                name='type'
                value={editingPoint.type}
                onChange={e =>
                  setEditingPoint(prev => ({ ...prev, type: e.target.value as 'key' | 'buff' }))
                }
                className={styles.input}
              >
                <option value='key'>按键点位</option>
                <option value='buff'>Buff点位</option>
              </select>
            </div>
          </div>
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
              <label className={styles.label}>目标颜色</label>
              <input
                type='text'
                name='targetColor'
                value={editingPoint.targetColor}
                onChange={handleInputChange}
                className={styles.input}
              />
            </div>
            {editingPoint.type === 'key' ? (
              <div className={styles.inputGroup}>
                <label className={styles.label}>触发按键</label>
                <input
                  type='text'
                  name='keys'
                  value={editingPoint.keys[0] || ''}
                  onChange={handleInputChange}
                  className={styles.input}
                  placeholder='例如: 1, F1'
                />
              </div>
            ) : (
              <div className={styles.inputGroup}>
                <label className={styles.label}>Buff名称</label>
                <input
                  type='text'
                  name='buffName'
                  value={editingPoint.buffName || ''}
                  onChange={handleInputChange}
                  className={styles.input}
                  placeholder='例如: 嗜血'
                />
              </div>
            )}
          </div>
        </div>
      </div>

      {/* Buff点位列表 */}
      <div className={styles.card}>
        <div className={styles.cardHeader}>
          <h3 className={styles.cardTitle}>监控点位</h3>
        </div>
        <div className={styles.pointsList}>
          {buffPoints.length > 0 ? (
            <table className={styles.pointsTable}>
              <thead>
                <tr>
                  <th>Buff名称</th>
                  <th>坐标</th>
                  <th>颜色</th>
                  <th>操作</th>
                </tr>
              </thead>
              <tbody>
                {buffPoints.map(point => (
                  <tr key={point.id} className={styles.pointItem}>
                    <td>{point.buffName || '-'}</td>
                    <td>
                      {point.x}, {point.y}
                    </td>
                    <td>
                      <div
                        className={styles.colorBox}
                        style={{ backgroundColor: point.targetColor }}
                      ></div>
                    </td>
                    <td className={styles.pointActions}>
                      <button className={styles.btnIcon} onClick={() => handleEditPoint(point)}>
                        编辑
                      </button>
                      <button
                        className={styles.btnIconDanger}
                        onClick={() => handleDeletePoint(point.id, 'buff')}
                      >
                        删除
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          ) : (
            <div className={styles.emptyText}>暂无Buff点位</div>
          )}
        </div>
      </div>

      {/* 按键点位列表 */}
      <div className={styles.card}>
        <div className={styles.cardHeader}>
          <h3 className={styles.cardTitle}>按键点位列表</h3>
        </div>
        <div className={styles.pointsList}>
          {keyPoints.length > 0 ? (
            <table className={styles.pointsTable}>
              <thead>
                <tr>
                  <th>按键</th>
                  <th>坐标</th>
                  <th>颜色</th>
                  <th>关联Buff</th>
                  <th>操作</th>
                </tr>
              </thead>
              <tbody>
                {keyPoints.map((point, index) => (
                  <tr key={point.id} className={styles.pointItem}>
                    <td>{point.keys.join(', ')}</td>
                    <td>
                      {point.x}, {point.y}
                    </td>
                    <td>
                      <div
                        className={styles.colorBox}
                        style={{ backgroundColor: point.targetColor }}
                      ></div>
                    </td>
                    <td>
                      <select
                        value={point.relatedBuffId || ''}
                        onChange={e => handleRelatedBuffChange(point.id, e.target.value)}
                        className={styles.input}
                      >
                        <option value=''>无</option>
                        {buffPoints.map(buff => (
                          <option key={buff.id} value={buff.id}>
                            {buff.buffName || `Buff点位 (${buff.x}, ${buff.y})`}
                          </option>
                        ))}
                      </select>
                    </td>

                    <td className={styles.pointActions}>
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
                        disabled={index === keyPoints.length - 1}
                      >
                        ↓
                      </button>
                      <button className={styles.btnIcon} onClick={() => handleEditPoint(point)}>
                        编辑
                      </button>
                      <button
                        className={styles.btnIconDanger}
                        onClick={() => handleDeletePoint(point.id, 'key')}
                      >
                        删除
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          ) : (
            <div className={styles.emptyText}>暂无按键点位</div>
          )}
        </div>
      </div>
    </div>
  );
}

export default ZXSJ;
