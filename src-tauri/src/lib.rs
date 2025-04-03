use enigo::{Enigo, Key, KeyboardControllable, MouseControllable};
use screenshots::Screen;
use serde::Serialize;
use std::thread;
use std::time::Duration;
use std::ffi::OsString;
use std::os::windows::ffi::OsStringExt;
use std::fs;
use std::path::Path;
use std::path::PathBuf;
use std::collections::HashMap;
use std::sync::{Arc, Mutex};
use tauri::Manager;
use tauri::Emitter;
use rdev::{listen, Event, EventType, Key as RdevKey};
use windows_sys::Win32::Foundation::{BOOL, HWND, LPARAM, RECT};
use windows_sys::Win32::UI::WindowsAndMessaging::{
    EnumWindows, GetWindowTextW, IsWindowVisible, GetWindowRect, GetForegroundWindow,
    GetSystemMetrics, PostMessageW, WM_KEYDOWN, WM_KEYUP,
};
use windows_sys::Win32::UI::Input::KeyboardAndMouse::{
    VK_F1, VK_F2, VK_F3, VK_F4, VK_F5, VK_F6, VK_F7, VK_F8, VK_F9, VK_F10, VK_F11, VK_F12,
    VK_NUMPAD0, VK_NUMPAD1, VK_NUMPAD2, VK_NUMPAD3, VK_NUMPAD4, VK_NUMPAD5, VK_NUMPAD6, VK_NUMPAD7, VK_NUMPAD8, VK_NUMPAD9,
    VK_DIVIDE, VK_MULTIPLY, VK_SUBTRACT, VK_ADD, VK_DECIMAL,
};

#[derive(Debug, Serialize)]
struct ColorInfo {
    r: u8,
    g: u8,
    b: u8,
}

#[derive(Debug, Serialize)]
struct PositionColorInfo {
    x: i32,
    y: i32,
    color: ColorInfo,
}

#[derive(Debug, Serialize)]
struct WindowInfo {
    title: String,
    x: i32,
    y: i32,
    width: i32,
    height: i32,
    is_foreground: bool,
    is_fullscreen: bool,
}

// 全局热键监听器的状态结构体
#[derive(Clone)]
struct HotkeyListener {
    mode1_key: Option<String>,
    mode2_key: Option<String>,
    pause_key: Option<String>,
    running: bool,
    last_key_time: std::time::Instant, // 添加上次按键时间
}

// 全局静态变量
struct HotkeyState {
    listener: Mutex<Option<Arc<Mutex<HotkeyListener>>>>,
}

// 实现Send + Sync使其可以安全地在线程间共享
unsafe impl Send for HotkeyState {}
unsafe impl Sync for HotkeyState {}

// 全局单例
lazy_static::lazy_static! {
    static ref HOTKEY_STATE: HotkeyState = HotkeyState {
        listener: Mutex::new(None),
    };
}

// 将字符串键名转换为rdev的Key
fn string_to_rdev_key(key_str: &str) -> Option<RdevKey> {
    match key_str {
        "`" => Some(RdevKey::BackQuote),
        "鼠标左键" => Some(RdevKey::Unknown(1)),
        "鼠标中键" => Some(RdevKey::Unknown(2)),
        "鼠标右键" => Some(RdevKey::Unknown(3)),
        "鼠标后退" => Some(RdevKey::Unknown(8)),
        "鼠标前进" => Some(RdevKey::Unknown(9)),
        "F1" => Some(RdevKey::F1),
        "F2" => Some(RdevKey::F2),
        "F3" => Some(RdevKey::F3),
        "F5" => Some(RdevKey::F5),
        "F6" => Some(RdevKey::F6),
        "F7" => Some(RdevKey::F7),
        "F8" => Some(RdevKey::F8),
        "F9" => Some(RdevKey::F9),
        "F10" => Some(RdevKey::F10),
        "F11" => Some(RdevKey::F11),
        "F12" => Some(RdevKey::F12),
        "1" => Some(RdevKey::Num1),
        "2" => Some(RdevKey::Num2),
        "3" => Some(RdevKey::Num3),
        "4" => Some(RdevKey::Num4),
        "5" => Some(RdevKey::Num5),
        "6" => Some(RdevKey::Num6),
        "7" => Some(RdevKey::Num7),
        "8" => Some(RdevKey::Num8),
        "9" => Some(RdevKey::Num9),
        "0" => Some(RdevKey::Num0),
        "Q" => Some(RdevKey::KeyQ),
        "W" => Some(RdevKey::KeyW),
        "E" => Some(RdevKey::KeyE),
        "R" => Some(RdevKey::KeyR),
        "T" => Some(RdevKey::KeyT),
        "Y" => Some(RdevKey::KeyY),
        "U" => Some(RdevKey::KeyU),
        "I" => Some(RdevKey::KeyI),
        "O" => Some(RdevKey::KeyO),
        "P" => Some(RdevKey::KeyP),
        "A" => Some(RdevKey::KeyA),
        "S" => Some(RdevKey::KeyS),
        "D" => Some(RdevKey::KeyD),
        "F" => Some(RdevKey::KeyF),
        "G" => Some(RdevKey::KeyG),
        "H" => Some(RdevKey::KeyH),
        "J" => Some(RdevKey::KeyJ),
        "K" => Some(RdevKey::KeyK),
        "L" => Some(RdevKey::KeyL),
        "Z" => Some(RdevKey::KeyZ),
        "X" => Some(RdevKey::KeyX),
        "C" => Some(RdevKey::KeyC),
        "V" => Some(RdevKey::KeyV),
        "B" => Some(RdevKey::KeyB),
        "N" => Some(RdevKey::KeyN),
        "M" => Some(RdevKey::KeyM),
        _ => None,
    }
}

#[tauri::command]
fn get_pixel_color(x: i32, y: i32) -> Option<ColorInfo> {
    if let Some(screen) = Screen::all().unwrap().first() {
        if let Ok(image) = screen.capture_area(x, y, 1, 1) {
            let pixels = image.into_raw();
            return Some(ColorInfo {
        r: pixels[0],
        g: pixels[1],
        b: pixels[2],
            });
        }
    }
    None
}

#[tauri::command]
fn get_current_position_color() -> Option<PositionColorInfo> {
    let enigo = Enigo::new();
    let (x, y) = enigo.mouse_location();

    if let Some(screen) = Screen::all().unwrap().first() {
        if let Ok(image) = screen.capture_area(x, y, 1, 1) {
            let pixels = image.into_raw();
            return Some(PositionColorInfo {
                x,
                y,
                color: ColorInfo {
                    r: pixels[0],
                    g: pixels[1],
                    b: pixels[2],
                },
            });
        }
    }
    None
}


#[tauri::command]
fn press_keys(keys: Vec<String>) {
    let mut enigo = Enigo::new();
    let delay = Duration::from_millis(10);

    // 按下所有修饰键
    for key in &keys {
        match key.as_str() {
            "ALT" => enigo.key_down(Key::Alt),
            "CTRL" => enigo.key_down(Key::Control),
            "SHIFT" => enigo.key_down(Key::Shift),
            _ => {}
        }
        thread::sleep(delay);
    }

    // 按下主键
    for key in &keys {
        match key.as_str() {
            "F1" => enigo.key_click(Key::F1),
            "F2" => enigo.key_click(Key::F2),
            "F3" => enigo.key_click(Key::F3),
            "F4" => enigo.key_click(Key::F4),
            "F5" => enigo.key_click(Key::F5),
            "F6" => enigo.key_click(Key::F6),
            "F7" => enigo.key_click(Key::F7),
            "F8" => enigo.key_click(Key::F8),
            "F9" => enigo.key_click(Key::F9),
            "F10" => enigo.key_click(Key::F10),
            "F11" => enigo.key_click(Key::F11),
            "F12" => enigo.key_click(Key::F12),
            "NUM0" => enigo.key_click(Key::Numpad0),
            "NUM1" => enigo.key_click(Key::Numpad1),
            "NUM2" => enigo.key_click(Key::Numpad2),
            "NUM3" => enigo.key_click(Key::Numpad3),
            "NUM4" => enigo.key_click(Key::Numpad4),
            "NUM5" => enigo.key_click(Key::Numpad5),
            "NUM6" => enigo.key_click(Key::Numpad6),
            "NUM7" => enigo.key_click(Key::Numpad7),
            "NUM8" => enigo.key_click(Key::Numpad8),
            "NUM9" => enigo.key_click(Key::Numpad9),
            "NUMPAD0" => enigo.key_click(Key::Numpad0),
            "NUMPAD1" => enigo.key_click(Key::Numpad1),
            "NUMPAD2" => enigo.key_click(Key::Numpad2),
            "NUMPAD3" => enigo.key_click(Key::Numpad3),
            "NUMPAD4" => enigo.key_click(Key::Numpad4),
            "NUMPAD5" => enigo.key_click(Key::Numpad5),
            "NUMPAD6" => enigo.key_click(Key::Numpad6),
            "NUMPAD7" => enigo.key_click(Key::Numpad7),
            "NUMPAD8" => enigo.key_click(Key::Numpad8),
            "NUMPAD9" => enigo.key_click(Key::Numpad9),
            "0" => enigo.key_click(Key::Raw(48)),
            "1" => enigo.key_click(Key::Raw(49)),
            "2" => enigo.key_click(Key::Raw(50)),
            "3" => enigo.key_click(Key::Raw(51)),
            "4" => enigo.key_click(Key::Raw(52)),
            "5" => enigo.key_click(Key::Raw(53)),
            "6" => enigo.key_click(Key::Raw(54)),
            "7" => enigo.key_click(Key::Raw(55)),
            "8" => enigo.key_click(Key::Raw(56)),
            "9" => enigo.key_click(Key::Raw(57)),
            "A" => enigo.key_click(Key::A),
            "B" => enigo.key_click(Key::B),
            "C" => enigo.key_click(Key::C),
            "D" => enigo.key_click(Key::D),
            "E" => enigo.key_click(Key::E),
            "F" => enigo.key_click(Key::F),
            "G" => enigo.key_click(Key::G),
            "H" => enigo.key_click(Key::H),
            "I" => enigo.key_click(Key::I),
            "J" => enigo.key_click(Key::J),
            "K" => enigo.key_click(Key::K),
            "L" => enigo.key_click(Key::L),
            "M" => enigo.key_click(Key::M),
            "N" => enigo.key_click(Key::N),
            "O" => enigo.key_click(Key::O),
            "P" => enigo.key_click(Key::P),
            "Q" => enigo.key_click(Key::Q),
            "R" => enigo.key_click(Key::R),
            "S" => enigo.key_click(Key::S),
            "T" => enigo.key_click(Key::T),
            "U" => enigo.key_click(Key::U),
            "V" => enigo.key_click(Key::V),
            "W" => enigo.key_click(Key::W),
            "X" => enigo.key_click(Key::X),
            "Y" => enigo.key_click(Key::Y),
            "Z" => enigo.key_click(Key::Z),

            "MOUSEWHEELUP" => enigo.mouse_scroll_y(1),
            "MOUSEWHEELDOWN" => enigo.mouse_scroll_y(-1),
            "TAB" => enigo.key_click(Key::Tab),
            "DELETE" => enigo.key_click(Key::Delete),
            "HOME" => enigo.key_click(Key::Home),
            "END" => enigo.key_click(Key::End),
            "PAGEUP" => enigo.key_click(Key::PageUp),
            "PAGEDOWN" => enigo.key_click(Key::PageDown),
            "UP" => enigo.key_click(Key::UpArrow),
            "DOWN" => enigo.key_click(Key::DownArrow),
            "LEFT" => enigo.key_click(Key::LeftArrow),
            "RIGHT" => enigo.key_click(Key::RightArrow),
            "INSERT" => enigo.key_click(Key::Insert),
            "NUMPADDIVIDE" => enigo.key_click(Key::Raw(111)),
            "NUMPADMULTIPLY" => enigo.key_click(Key::Raw(106)),
            "NUMPADMINUS" => enigo.key_click(Key::Raw(109)),
            "NUMPADPLUS" => enigo.key_click(Key::Raw(107)),
            "NUMPADDECIMAL" => enigo.key_click(Key::Raw(110)),
            "," => enigo.key_click(Key::Layout(',')),
            "." => enigo.key_click(Key::Layout('.')),
            ";" => enigo.key_click(Key::Layout(';')),
            "[" => enigo.key_click(Key::Layout('[')),
            "]" => enigo.key_click(Key::Layout(']')),
            "=" => enigo.key_click(Key::Layout('=')),
            "-" => enigo.key_click(Key::Layout('-')),
            "\\" => enigo.key_click(Key::Layout('\\')),
            key if key.len() == 1 => {
                if let Some(c) = key.chars().next() {
                    enigo.key_click(Key::Layout(c.to_ascii_lowercase()));
                }
            }
            _ => {}
        }
        thread::sleep(delay);
    }

    // 释放所有修饰键
    for key in &keys {
        match key.as_str() {
            "ALT" => enigo.key_up(Key::Alt),
            "CTRL" => enigo.key_up(Key::Control),
            "SHIFT" => enigo.key_up(Key::Shift),
            _ => {}
        }
        // thread::sleep(delay);
    }
}

#[tauri::command]
fn move_mouse_to_point(x: f64, y: f64) -> Result<(), String> {
    let mut enigo = Enigo::new();
    enigo.mouse_move_to(x as i32, y as i32);
    Ok(())
}

#[tauri::command]
fn get_hostname() -> Result<String, String> {
    match hostname::get() {
        Ok(name) => {
            match name.into_string() {
                Ok(hostname) => Ok(hostname),
                Err(_) => Err("无法将主机名转换为字符串".to_string())
            }
        },
        Err(e) => Err(format!("获取主机名失败: {}", e))
    }
}

#[tauri::command]
fn get_wow_window_info() -> Option<WindowInfo> {
    unsafe {
        // 用于存储找到的WoW窗口信息
        let mut result = None;

        extern "system" fn enum_windows_callback(hwnd: HWND, lparam: LPARAM) -> BOOL {
            unsafe {
                // 检查窗口是否可见
                if IsWindowVisible(hwnd) == 0 {
                    return TRUE;
                }

                // 获取窗口标题
                let mut title: [u16; 512] = [0; 512];
                let len = GetWindowTextW(hwnd, title.as_mut_ptr(), title.len() as i32);

                if len > 0 {
                    let title = OsString::from_wide(&title[..len as usize])
                        .to_string_lossy()
                        .into_owned();

                    // 检查窗口标题是否包含"World of Warcraft"
                    if title.contains("World of Warcraft") || title.contains("魔兽世界") || title.contains("资源管理器") {
                        // 获取窗口位置和大小
                        let mut rect = RECT { left: 0, top: 0, right: 0, bottom: 0 };
                        if GetWindowRect(hwnd, &mut rect) != 0 {
                            // 获取当前前台窗口句柄
                            let foreground_hwnd = GetForegroundWindow();
                            // 判断当前窗口是否为前台窗口
                            let is_foreground = hwnd == foreground_hwnd;

                            // 获取窗口宽高
                            let width = rect.right - rect.left;
                            let height = rect.bottom - rect.top;

                            // 获取屏幕分辨率
                            let screen_width = GetSystemMetrics(0);  // SM_CXSCREEN = 0
                            let screen_height = GetSystemMetrics(1); // SM_CYSCREEN = 1

                            // 判断是否全屏（窗口大小与屏幕分辨率相同或非常接近）
                            let is_fullscreen = rect.left <= 0 && rect.top <= 0 &&
                                               (width >= screen_width ) &&
                                               (height >= screen_height);

                            let window_info = WindowInfo {
                                title,
                                x: rect.left,
                                y: rect.top,
                                width,
                                height,
                                is_foreground,
                                is_fullscreen,

                            };

                            // 将窗口信息存储到lparam指向的位置
                            let result_ptr = lparam as *mut Option<WindowInfo>;
                            *result_ptr = Some(window_info);

                            // 找到了WoW窗口，停止枚举
                            return FALSE;
                        }
                    }
                }

                // 继续枚举下一个窗口
                TRUE
            }
        }

        const TRUE: BOOL = 1;
        const FALSE: BOOL = 0;

        // 使用枚举窗口函数查找WoW窗口
        EnumWindows(Some(enum_windows_callback), &mut result as *mut _ as LPARAM);

        result
    }
}

#[tauri::command]
fn install_addon(app_handle: tauri::AppHandle, plugin_type: &str, target_dir: &str) -> Result<String, String> {
    // 获取资源路径
    let resource_path = app_handle.path().resource_dir()
        .map_err(|e| format!("无法获取资源目录: {}", e))?;

    // 构建可能的插件源目录路径列表
    let possible_paths = vec![
        // 1. 打包后的标准资源路径
        resource_path.join("addOns").join(plugin_type),
        // 2. 直接使用插件名称作为路径
        resource_path.join(plugin_type),
        // 3. 开发环境路径
        PathBuf::from("src-tauri/addOns").join(plugin_type),
        // 4. 当前工作目录
        std::env::current_dir()
            .unwrap_or_else(|_| PathBuf::from("."))
            .join("addOns")
            .join(plugin_type),
    ];

    // 查找第一个存在的路径
    let source_path = possible_paths.iter()
        .find(|path| path.exists())
        .ok_or_else(|| format!(
            "找不到插件目录: {}。尝试了以下路径:\n{}",
            plugin_type,
            possible_paths.iter()
                .map(|p| format!("- {:?}", p))
                .collect::<Vec<_>>()
                .join("\n")
        ))?;


    // 创建一个用于复制目录的函数
    fn copy_dir_all(src: &Path, dst: &Path) -> std::io::Result<()> {
        if !dst.exists() {
            fs::create_dir_all(dst)?;
        }

        for entry in fs::read_dir(src)? {
            let entry = entry?;
            let ty = entry.file_type()?;
            let src_path = entry.path();
            let dst_path = dst.join(entry.file_name());

            if ty.is_dir() {
                copy_dir_all(&src_path, &dst_path)?;
            } else {
                fs::copy(&src_path, &dst_path)?;
            }
        }
        Ok(())
    }
    // 直接将整个插件目录复制到目标位置
    let dst_path = Path::new(target_dir).join(plugin_type);
    // 如果目标目录已存在，先删除
    if dst_path.exists() {
        fs::remove_dir_all(&dst_path).map_err(|e| format!("删除已存在的目录失败: {}", e))?;
    }
    // 复制目录
    copy_dir_all(&source_path, &dst_path).map_err(|e| format!("复制目录失败: {}", e))?;
    Ok(format!("插件安装成功!", ))
}

#[tauri::command]
fn send_keys_to_wow(keys: Vec<String>) -> Result<String, String> {
    // 创建键名到虚拟键码的映射
    let mut key_map: HashMap<&'static str, u16> = HashMap::new();
    key_map.insert("F1", VK_F1 as u16);
    key_map.insert("F2", VK_F2 as u16);
    key_map.insert("F3", VK_F3 as u16);
    key_map.insert("F4", VK_F4 as u16);
    key_map.insert("F5", VK_F5 as u16);
    key_map.insert("F6", VK_F6 as u16);
    key_map.insert("F7", VK_F7 as u16);
    key_map.insert("F8", VK_F8 as u16);
    key_map.insert("F9", VK_F9 as u16);
    key_map.insert("F10", VK_F10 as u16);
    key_map.insert("F11", VK_F11 as u16);
    key_map.insert("F12", VK_F12 as u16);
    key_map.insert("NUM0", VK_NUMPAD0 as u16);
    key_map.insert("NUM1", VK_NUMPAD1 as u16);
    key_map.insert("NUM2", VK_NUMPAD2 as u16);
    key_map.insert("NUM3", VK_NUMPAD3 as u16);
    key_map.insert("NUM4", VK_NUMPAD4 as u16);
    key_map.insert("NUM5", VK_NUMPAD5 as u16);
    key_map.insert("NUM6", VK_NUMPAD6 as u16);
    key_map.insert("NUM7", VK_NUMPAD7 as u16);
    key_map.insert("NUM8", VK_NUMPAD8 as u16);
    key_map.insert("NUM9", VK_NUMPAD9 as u16);
    key_map.insert("NUMPAD0", VK_NUMPAD0 as u16);
    key_map.insert("NUMPAD1", VK_NUMPAD1 as u16);
    key_map.insert("NUMPAD2", VK_NUMPAD2 as u16);
    key_map.insert("NUMPAD3", VK_NUMPAD3 as u16);
    key_map.insert("NUMPAD4", VK_NUMPAD4 as u16);
    key_map.insert("NUMPAD5", VK_NUMPAD5 as u16);
    key_map.insert("NUMPAD6", VK_NUMPAD6 as u16);
    key_map.insert("NUMPAD7", VK_NUMPAD7 as u16);
    key_map.insert("NUMPAD8", VK_NUMPAD8 as u16);
    key_map.insert("NUMPAD9", VK_NUMPAD9 as u16);
    key_map.insert("NUMPADDIVIDE", VK_DIVIDE as u16);
    key_map.insert("NUMPADMULTIPLY", VK_MULTIPLY as u16);
    key_map.insert("NUMPADMINUS", VK_SUBTRACT as u16);
    key_map.insert("NUMPADPLUS", VK_ADD as u16);
    key_map.insert("NUMPADDECIMAL", VK_DECIMAL as u16);

    // 添加数字键的虚拟键码映射
    key_map.insert("0", 0x30);
    key_map.insert("1", 0x31);
    key_map.insert("2", 0x32);
    key_map.insert("3", 0x33);
    key_map.insert("4", 0x34);
    key_map.insert("5", 0x35);
    key_map.insert("6", 0x36);
    key_map.insert("7", 0x37);
    key_map.insert("8", 0x38);
    key_map.insert("9", 0x39);

    // 直接在函数内查找魔兽世界窗口
    let mut wow_hwnd: HWND = 0;

    unsafe {
        extern "system" fn enum_windows_callback(hwnd: HWND, lparam: LPARAM) -> BOOL {
            unsafe {
                if IsWindowVisible(hwnd) == 0 {
                    return 1; // 继续枚举
                }

                let mut title: [u16; 512] = [0; 512];
                let len = GetWindowTextW(hwnd, title.as_mut_ptr(), title.len() as i32);

                if len > 0 {
                    let title = OsString::from_wide(&title[..len as usize])
                        .to_string_lossy()
                        .into_owned();

                    if title.contains("World of Warcraft") || title.contains("魔兽世界") {
                        let result_ptr = lparam as *mut HWND;
                        *result_ptr = hwnd;
                        return 0; // 停止枚举
                    }
                }
                1 // 继续枚举
            }
        }

        EnumWindows(Some(enum_windows_callback), &mut wow_hwnd as *mut _ as LPARAM);

        if wow_hwnd == 0 {
            return Err("未找到魔兽世界窗口".to_string());
        }

        // 发送按键到魔兽世界窗口
        // let delay = Duration::from_millis(10);

        for key in &keys {
            if let Some(&vk) = key_map.get(key.as_str()) {
                PostMessageW(wow_hwnd, WM_KEYDOWN, vk as usize, 0);
                // thread::sleep(delay);
                PostMessageW(wow_hwnd, WM_KEYUP, vk as usize, 0);
                // thread::sleep(delay);
            }
        }
    }

    Ok("按键已发送到魔兽世界窗口".to_string())
}

// 添加用于设置全局热键并发送事件到前端的函数
#[tauri::command]
fn setup_global_shortcuts(app: tauri::AppHandle, mode1_key: Option<String>, mode2_key: Option<String>, pause_key: Option<String>) -> Result<(), String> {
    // 停止现有的监听器
    let _ = clear_global_shortcuts();

    // 转换热键为rdev Key类型并提前检查有效性
    let mode1_rdev_key = mode1_key.as_ref().and_then(|k| string_to_rdev_key(k));
    let mode2_rdev_key = mode2_key.as_ref().and_then(|k| string_to_rdev_key(k));
    let pause_rdev_key = pause_key.as_ref().and_then(|k| string_to_rdev_key(k));

    // 如果没有有效的热键，就不启动监听
    if mode1_rdev_key.is_none() && mode2_rdev_key.is_none() && pause_rdev_key.is_none() {
        return Ok(());
    }

    // 初始化新的监听器，添加当前时间
    let listener = Arc::new(Mutex::new(HotkeyListener {
        mode1_key,
        mode2_key,
        pause_key,
        running: true,
        last_key_time: std::time::Instant::now(),
    }));

    // 保存监听器状态到全局变量
    {
        let mut hotkey_lock = HOTKEY_STATE.listener.lock().map_err(|e| e.to_string())?;
        *hotkey_lock = Some(listener.clone());
    }

    // 启动键盘监听线程
    let app_handle = app.clone();
    std::thread::spawn(move || {
        // 键盘和鼠标事件处理函数
        let callback = move |event: Event| {
            // 获取当前键或按钮
            match event.event_type {
                EventType::ButtonPress(button) => {
                    // 转换为RdevKey，特殊处理前进和后退按钮
                    let key = match button {
                        rdev::Button::Left => RdevKey::Unknown(1),
                        rdev::Button::Middle => RdevKey::Unknown(2),
                        rdev::Button::Right => RdevKey::Unknown(3),
                        rdev::Button::Unknown(val) => {
                            // 特殊处理前进和后退按钮
                            match val {
                                1 => RdevKey::Unknown(8), // 鼠标前进键
                                2 => RdevKey::Unknown(9), // 鼠标后退键
                                _ => RdevKey::Unknown(val.into()),
                            }
                        },
                    };

                    // 检查是否匹配设置的热键，如果匹配则触发事件
                    process_key(key, &app_handle);
                },
                EventType::KeyPress(key) => {
                    // 检查是否匹配设置的热键，如果匹配则触发事件
                    process_key(key, &app_handle);
                },
                _ => {
                    // 其他事件类型不处理
                }
            }
        };

        // 处理按键函数
        fn process_key(key: RdevKey, app_handle: &tauri::AppHandle) {
            // 获取热键设置并检查是否需要处理
            let hotkey_lock = match HOTKEY_STATE.listener.lock() {
                Ok(lock) => lock,
                Err(_) => return,
            };

            let listener_arc = match hotkey_lock.as_ref() {
                Some(arc) => arc,
                None => return,
            };

            let mut listener = match listener_arc.lock() {
                Ok(l) => l,
                Err(_) => return,
            };

            // 防抖处理
            let now = std::time::Instant::now();
            let duration = now.duration_since(listener.last_key_time);
            if duration.as_millis() < 200 || !listener.running {
                return;
            }

            // 更新上次按键时间
            listener.last_key_time = now;

            // 检查并发送事件
            let check_and_emit = |config_key: &Option<String>, event_name: &str| {
                if let Some(k) = config_key.as_ref().and_then(|k| string_to_rdev_key(k)) {
                    if key == k {
                        let _ = app_handle.emit("hotkey-event", event_name);
                        return true;
                    }
                }
                false
            };

            // 依次检查各种热键
            if check_and_emit(&listener.mode1_key, "mode1")
                || check_and_emit(&listener.mode2_key, "mode2")
                || check_and_emit(&listener.pause_key, "pause") {
                return;
            }
        }

        // 启动键盘监听
        let _ = listen(callback);
    });

    Ok(())
}

// 清除全局热键函数
#[tauri::command]
fn clear_global_shortcuts() -> Result<(), String> {
    // 获取锁并设置running为false，终止监听
    let mut hotkey_lock = HOTKEY_STATE.listener.lock().map_err(|e| e.to_string())?;
    if let Some(listener_arc) = hotkey_lock.as_ref() {
        if let Ok(mut listener) = listener_arc.lock() {
            listener.running = false;
        }
    }

    // 清除监听器
    *hotkey_lock = None;

    Ok(())
}

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_store::Builder::default().build())
        .plugin(tauri_plugin_fs::init())
        .plugin(tauri_plugin_dialog::init())
        .plugin(tauri_plugin_opener::init())
        .invoke_handler(tauri::generate_handler![
            get_pixel_color,
            get_current_position_color,
            press_keys,
            send_keys_to_wow,
            move_mouse_to_point,
            get_hostname,
            get_wow_window_info,
            install_addon,
            setup_global_shortcuts,
            clear_global_shortcuts
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
