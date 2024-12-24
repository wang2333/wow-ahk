use screenshots::Screen;
use enigo::{Enigo, KeyboardControllable, Key};
use std::{thread, time::Duration, fs, collections::HashMap, sync::{Arc, Mutex}, io::BufReader};
use serde::{Deserialize, Serialize};
use device_query::{DeviceQuery, DeviceState, Keycode};
use rodio::{Decoder, OutputStream, Sink};

#[derive(Serialize, Deserialize, Debug)]
struct ColorMapping {
    color: String,
    keys: Vec<String>,
}

#[derive(Serialize, Deserialize, Debug)]
struct Config {
    color_mappings: Vec<ColorMapping>,
}

// 监控状态
#[derive(Clone, Copy, PartialEq)]
enum MonitorState {
    Position1,
    Position2,
    Paused,
}

// 预处理的按键组合
#[derive(Clone)]
struct KeyCombination {
    modifiers: Vec<Key>,
    main_key: Key,
}

// 监控点位
struct MonitorPosition {
    x: i32,
    y: i32,
}

// 音频播放器
struct AudioPlayer {
    _stream: OutputStream,
    sink: Sink,
    mode1: Option<Vec<u8>>,
    mode2: Option<Vec<u8>>,
    pause: Option<Vec<u8>>,
}

impl AudioPlayer {
    fn new() -> Self {
        let (_stream, stream_handle) = OutputStream::try_default().expect("无法初始化音频输出");
        let sink = Sink::try_new(&stream_handle).expect("无法创建音频播放器");

        // 加载音频文件
        let mode1 = fs::read("resources/mode1.wav").ok();
        let mode2 = fs::read("resources/mode2.wav").ok();
        let pause = fs::read("resources/pause.wav").ok();

        if mode1.is_none() {
            println!("警告: 无法加载 mode1.wav");
        }
        if mode2.is_none() {
            println!("警告: 无法加载 mode2.wav");
        }
        if pause.is_none() {
            println!("警告: 无法加载 pause.wav");
        }

        AudioPlayer {
            _stream,
            sink,
            mode1,
            mode2,
            pause,
        }
    }

    fn play_sound(&self, data: Option<&Vec<u8>>) {
        if let Some(audio_data) = data {
            // 停止当前播放的音频
            self.sink.stop();

            // 创建新的音频源
            let cursor = std::io::Cursor::new(audio_data.to_vec());
            let reader = BufReader::new(cursor);
            if let Ok(source) = Decoder::new(reader) {
                self.sink.append(source);
                self.sink.play();
            }
        }
    }

    fn play_mode1(&self) {
        self.play_sound(self.mode1.as_ref());
    }

    fn play_mode2(&self) {
        self.play_sound(self.mode2.as_ref());
    }

    fn play_pause(&self) {
        self.play_sound(self.pause.as_ref());
    }
}

fn hex_to_rgb(hex: &str) -> (u8, u8, u8) {
    let hex = hex.trim_start_matches('#');
    let r = u8::from_str_radix(&hex[0..2], 16).unwrap_or(0);
    let g = u8::from_str_radix(&hex[2..4], 16).unwrap_or(0);
    let b = u8::from_str_radix(&hex[4..6], 16).unwrap_or(0);
    (r, g, b)
}

fn rgb_to_key(r: u8, g: u8, b: u8) -> u32 {
    ((r as u32) << 16) | ((g as u32) << 8) | (b as u32)
}

fn parse_key(key: &str) -> Key {
    match key.to_uppercase().as_str() {
        "ALT" => Key::Alt,
        "CTRL" => Key::Control,
        "SHIFT" => Key::Shift,
        "F1" => Key::F1,
        "F2" => Key::F2,
        "F3" => Key::F3,
        "F4" => Key::F4,
        "F5" => Key::F5,
        "F6" => Key::F6,
        "F7" => Key::F7,
        "F8" => Key::F8,
        "F9" => Key::F9,
        "F10" => Key::F10,
        "F11" => Key::F11,
        "F12" => Key::F12,
        "NUM0" => Key::Layout('0'),
        "NUM1" => Key::Layout('1'),
        "NUM2" => Key::Layout('2'),
        "NUM3" => Key::Layout('3'),
        "NUM4" => Key::Layout('4'),
        "NUM5" => Key::Layout('5'),
        "NUM6" => Key::Layout('6'),
        "NUM7" => Key::Layout('7'),
        "NUM8" => Key::Layout('8'),
        "NUM9" => Key::Layout('9'),
        _ => {
            if let Some(c) = key.chars().next() {
                Key::Layout(c.to_ascii_lowercase())
            } else {
                Key::Layout('a')
            }
        }
    }
}

fn process_config(config: &Config) -> HashMap<u32, KeyCombination> {
    let mut key_map = HashMap::new();

    for mapping in &config.color_mappings {
        let (r, g, b) = hex_to_rgb(&mapping.color);
        let color_key = rgb_to_key(r, g, b);

        let keys = &mapping.keys;
        let (modifiers, main_key) = if !keys.is_empty() {
            let main = parse_key(keys.last().unwrap());
            let mods = keys[..keys.len()-1].iter()
                .map(|k| parse_key(k))
                .collect();
            (mods, main)
        } else {
            (Vec::new(), Key::Layout('a'))
        };

        key_map.insert(color_key, KeyCombination {
            modifiers,
            main_key,
        });
    }

    key_map
}

fn press_key_combination(enigo: &mut Enigo, combination: &KeyCombination) {
    // 按下所有修饰键
    for modifier in &combination.modifiers {
        enigo.key_down(*modifier);
    }

    // 按下主键
    enigo.key_click(combination.main_key);

    // 释放所有修饰键（反序释放）
    for modifier in combination.modifiers.iter().rev() {
        enigo.key_up(*modifier);
    }
}

fn monitor_position(screen: &Screen, pos: &MonitorPosition, key_map: &HashMap<u32, KeyCombination>, enigo: &mut Enigo) {
    if let Ok(image) = screen.capture_area(pos.x, pos.y, 1, 1) {
        let pixel = image.get_pixel(0, 0);
        let color_key = rgb_to_key(pixel[0], pixel[1], pixel[2]);

        if let Some(combination) = key_map.get(&color_key) {
            press_key_combination(enigo, combination);
        }
    }
}

fn main() {
    // 读取并预处理配置
    let config_str = fs::read_to_string("config.json").expect("无法读取配置文件");
    let config: Config = serde_json::from_str(&config_str).expect("无法解析配置文件");
    let key_map = process_config(&config);

    println!("已加载 {} 个颜色映射", key_map.len());

    // 创建实例
    let screens = Screen::all().unwrap();
    let screen = screens[0];
    let mut enigo = Enigo::new();

    // 定义监控点位
    let position1 = MonitorPosition { x: 0, y: 0 };    // 点位1
    let position2 = MonitorPosition { x: 100, y: 100 }; // 点位2

    // 创建状态监控
    let state = Arc::new(Mutex::new(MonitorState::Paused));
    let device_state = DeviceState::new();

    // 创建音频播放器
    let audio_player = AudioPlayer::new();

    println!("程序已启动:");
    println!("- 按F1切换到点位1监控 (0, 0)");
    println!("- 按F2切换到点位2监控 (100, 100)");
    println!("- 按F3暂停监控");
    println!("当前状态: 已暂停");

    // 播放启动音效
    audio_player.play_pause();

    loop {
        // 检查热键
        let keys: Vec<Keycode> = device_state.get_keys();

        // 更新状态
        let mut current_state = state.lock().unwrap();
        if keys.contains(&Keycode::F1) {
            if *current_state != MonitorState::Position1 {
                *current_state = MonitorState::Position1;
                println!("切换到点位1监控");
                audio_player.play_mode1();
            }
        } else if keys.contains(&Keycode::F2) {
            if *current_state != MonitorState::Position2 {
                *current_state = MonitorState::Position2;
                println!("切换到点位2监控");
                audio_player.play_mode2();
            }
        } else if keys.contains(&Keycode::F3) {
            if *current_state != MonitorState::Paused {
                *current_state = MonitorState::Paused;
                println!("暂停监控");
                audio_player.play_pause();
            }
        }

        // 根据状态执行监控
        match *current_state {
            MonitorState::Position1 => {
                monitor_position(&screen, &position1, &key_map, &mut enigo);
            },
            MonitorState::Position2 => {
                monitor_position(&screen, &position2, &key_map, &mut enigo);
            },
            MonitorState::Paused => {
                // 暂停状态，不执行监控
            }
        }

        // 释放锁
        drop(current_state);

        thread::sleep(Duration::from_millis(100));
    }
}
