import './index.css';
import { useEffect, useState } from 'react';
import { invoke } from '@tauri-apps/api/core';
import { register, unregister } from '@tauri-apps/plugin-global-shortcut';
import { BaseDirectory, readTextFile, writeTextFile } from '@tauri-apps/plugin-fs';

interface ColorInfo {
  r: number;
  g: number;
  b: number;
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

  // 加载配置
  useEffect(() => {
    loadConfig();
  }, []);

  // 保存配置
  useEffect(() => {
    if (points.length > 0) {
      saveConfig();
    }
  }, [points]);

  // 注册热键
  useEffect(() => {
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
      console.log('👻 ~ content:', content);
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

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setEditingPoint(prev => ({
      ...prev,
      [name]: name === 'keys' ? [value] : value
    }));
  };

  return (
    <div className='zxsj-container'>
      {/* 添加/编辑点位表单 */}
      <div className='card'>
        <div className='card-header'>
          <h3 className='card-title'>{editingPoint.id ? '编辑点位' : '添加点位'}</h3>
          <div className='card-actions'>
            <button className='btn-icon' onClick={saveConfig}>
              保存配置
            </button>
          </div>
        </div>
        <div className='form-content'>
          <div className='form-row'>
            <div className='input-group'>
              <label>X 坐标</label>
              <input type='number' name='x' value={editingPoint.x} onChange={handleInputChange} />
            </div>
            <div className='input-group'>
              <label>Y 坐标</label>
              <input type='number' name='y' value={editingPoint.y} onChange={handleInputChange} />
            </div>
          </div>
          <div className='form-row'>
            <div className='input-group'>
              <label>目标色值</label>
              <div className='color-input-group'>
                <input
                  type='color'
                  name='targetColor'
                  value={editingPoint.targetColor}
                  onChange={handleInputChange}
                />
                <input
                  type='text'
                  name='targetColor'
                  value={editingPoint.targetColor}
                  onChange={handleInputChange}
                />
              </div>
            </div>
            <div className='input-group'>
              <label>按键</label>
              <input
                type='text'
                name='keys'
                value={editingPoint.keys[0] || ''}
                onChange={handleInputChange}
                placeholder='例如: a'
              />
            </div>
          </div>
          <button className='btn-primary' onClick={handleAddPoint}>
            {editingPoint.id ? '更新' : '添加'}
          </button>
        </div>
      </div>

      {/* 点位列表 */}
      <div className='card'>
        <div className='card-header'>
          <h3 className='card-title'>监控点位</h3>
          <div className='card-actions'>
            <label className='status-label'>状态: {isRunning ? '运行中' : '已停止'}</label>
            <div className={`status-dot ${isRunning ? 'active' : ''}`} />
          </div>
        </div>
        <div className='points-list'>
          {points.map(point => (
            <div key={point.id} className='point-item'>
              <div className='point-info'>
                <div className='point-location'>
                  坐标: ({point.x}, {point.y})
                </div>
                <div className='point-color' style={{ backgroundColor: point.targetColor }}>
                  {point.targetColor}
                </div>
                <div className='point-keys'>按键: {point.keys[0]}</div>
              </div>
              <div className='point-actions'>
                <button className='btn-icon' onClick={() => handleEditPoint(point)}>
                  编辑
                </button>
                <button className='btn-icon danger' onClick={() => handleDeletePoint(point.id)}>
                  删除
                </button>
              </div>
            </div>
          ))}
          {points.length === 0 && <div className='empty-state'>暂无监控点位，请添加新的点位</div>}
        </div>
      </div>
    </div>
  );
}

export default ZXSJ;
