use enigo::{Enigo, Key, KeyboardControllable, MouseControllable};
use screenshots::Screen;
use serde::Serialize;
use std::thread;
use std::time::Duration;
use windows_sys::Win32::Foundation::{BOOL, HWND, LPARAM, RECT};
use windows_sys::Win32::UI::WindowsAndMessaging::{
    EnumWindows, GetWindowTextW, IsWindowVisible, GetWindowRect, GetForegroundWindow,
    GetSystemMetrics,
};
use std::ffi::OsString;
use std::os::windows::ffi::OsStringExt;
use std::fs;
use std::path::Path;
use std::path::PathBuf;
use tauri::Manager;
use windows_sys::Win32::UI::Input::KeyboardAndMouse::{
    VK_LMENU, VK_LCONTROL, VK_LSHIFT,
    VK_F1, VK_F2, VK_F3, VK_F4, VK_F5, VK_F6, VK_F7, VK_F8, VK_F9, VK_F10, VK_F11, VK_F12,
    VK_NUMPAD0, VK_NUMPAD1, VK_NUMPAD2, VK_NUMPAD3, VK_NUMPAD4, VK_NUMPAD5, VK_NUMPAD6, VK_NUMPAD7, VK_NUMPAD8, VK_NUMPAD9,
    VK_TAB, VK_DELETE, VK_HOME, VK_END, VK_PRIOR, VK_NEXT, VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT, VK_INSERT,
    VK_DIVIDE, VK_MULTIPLY, VK_SUBTRACT, VK_ADD, VK_DECIMAL,
    KEYEVENTF_KEYUP,
    SendInput, INPUT, INPUT_KEYBOARD, KEYBDINPUT,
};
use std::collections::HashMap;

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
fn press_keys2(keys: Vec<String>) {
    // 创建键名到虚拟键码的映射
    let mut key_map: HashMap<&'static str, u16> = HashMap::new();
    key_map.insert("ALT", VK_LMENU as u16);
    key_map.insert("CTRL", VK_LCONTROL as u16);
    key_map.insert("SHIFT", VK_LSHIFT as u16);
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
    key_map.insert("TAB", VK_TAB as u16);
    key_map.insert("DELETE", VK_DELETE as u16);
    key_map.insert("HOME", VK_HOME as u16);
    key_map.insert("END", VK_END as u16);
    key_map.insert("PAGEUP", VK_PRIOR as u16);
    key_map.insert("PAGEDOWN", VK_NEXT as u16);
    key_map.insert("UP", VK_UP as u16);
    key_map.insert("DOWN", VK_DOWN as u16);
    key_map.insert("LEFT", VK_LEFT as u16);
    key_map.insert("RIGHT", VK_RIGHT as u16);
    key_map.insert("INSERT", VK_INSERT as u16);
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

    // 添加字母键的虚拟键码映射
    key_map.insert("A", 0x41);
    key_map.insert("B", 0x42);
    key_map.insert("C", 0x43);
    key_map.insert("D", 0x44);
    key_map.insert("E", 0x45);
    key_map.insert("F", 0x46);
    key_map.insert("G", 0x47);
    key_map.insert("H", 0x48);
    key_map.insert("I", 0x49);
    key_map.insert("J", 0x4A);
    key_map.insert("K", 0x4B);
    key_map.insert("L", 0x4C);
    key_map.insert("M", 0x4D);
    key_map.insert("N", 0x4E);
    key_map.insert("O", 0x4F);
    key_map.insert("P", 0x50);
    key_map.insert("Q", 0x51);
    key_map.insert("R", 0x52);
    key_map.insert("S", 0x53);
    key_map.insert("T", 0x54);
    key_map.insert("U", 0x55);
    key_map.insert("V", 0x56);
    key_map.insert("W", 0x57);
    key_map.insert("X", 0x58);
    key_map.insert("Y", 0x59);
    key_map.insert("Z", 0x5A);

    key_map.insert("a", 0x41);
    key_map.insert("b", 0x42);
    key_map.insert("c", 0x43);
    key_map.insert("d", 0x44);
    key_map.insert("e", 0x45);
    key_map.insert("f", 0x46);
    key_map.insert("g", 0x47);
    key_map.insert("h", 0x48);
    key_map.insert("i", 0x49);
    key_map.insert("j", 0x4A);
    key_map.insert("k", 0x4B);
    key_map.insert("l", 0x4C);
    key_map.insert("m", 0x4D);
    key_map.insert("n", 0x4E);
    key_map.insert("o", 0x4F);
    key_map.insert("p", 0x50);
    key_map.insert("q", 0x51);
    key_map.insert("r", 0x52);
    key_map.insert("s", 0x53);
    key_map.insert("t", 0x54);
    key_map.insert("u", 0x55);
    key_map.insert("v", 0x56);
    key_map.insert("w", 0x57);
    key_map.insert("x", 0x58);
    key_map.insert("y", 0x59);
    key_map.insert("z", 0x5A);

    // 添加一些特殊字符的映射
    key_map.insert(",", 0xBC);
    key_map.insert(".", 0xBE);
    key_map.insert(";", 0xBA);
    key_map.insert("[", 0xDB);
    key_map.insert("]", 0xDD);
    key_map.insert("=", 0xBB);
    key_map.insert("-", 0xBD);

    // 记录需要按下的修饰键
    let mut modifier_keys = Vec::new();
    for key in &keys {
        if key == "ALT" || key == "CTRL" || key == "SHIFT" {
            modifier_keys.push(key.clone());
        }
    }

    let delay = Duration::from_millis(10);

    unsafe {
        // 按下所有修饰键
        for key in &modifier_keys {
            if let Some(&vk) = key_map.get(key.as_str()) {
                let mut input = INPUT {
                    r#type: INPUT_KEYBOARD,
                    Anonymous: std::mem::zeroed(),
                };
                // 直接设置ki字段
                input.Anonymous.ki = KEYBDINPUT {
                    wVk: vk,
                    wScan: 0,
                    dwFlags: 0,
                    time: 0,
                    dwExtraInfo: 0,
                };
                SendInput(1, &input, std::mem::size_of::<INPUT>() as i32);
                thread::sleep(delay);
            }
        }

        // 处理所有非修饰键
        for key in &keys {
            if !modifier_keys.contains(key) {
                if key == "MOUSEWHEELUP" {
                    // 处理鼠标滚轮向上
                    // 这里需要使用鼠标输入，暂不实现
                } else if key == "MOUSEWHEELDOWN" {
                    // 处理鼠标滚轮向下
                    // 这里需要使用鼠标输入，暂不实现
                } else if let Some(&vk) = key_map.get(key.as_str()) {
                    // 按下并释放非修饰键
                    let mut input = INPUT {
                        r#type: INPUT_KEYBOARD,
                        Anonymous: std::mem::zeroed(),
                    };
                    // 直接设置ki字段
                    input.Anonymous.ki = KEYBDINPUT {
                        wVk: vk,
                        wScan: 0,
                        dwFlags: 0,
                        time: 0,
                        dwExtraInfo: 0,
                    };
                    SendInput(1, &input, std::mem::size_of::<INPUT>() as i32);
                    thread::sleep(delay);

                    // 释放非修饰键
                    input.Anonymous.ki = KEYBDINPUT {
                        wVk: vk,
                        wScan: 0,
                        dwFlags: KEYEVENTF_KEYUP,
                        time: 0,
                        dwExtraInfo: 0,
                    };
                    SendInput(1, &input, std::mem::size_of::<INPUT>() as i32);
                    thread::sleep(delay);
                }
            }
        }

        // 释放所有修饰键（从后往前，与按下顺序相反）
        for key in modifier_keys.iter().rev() {
            if let Some(&vk) = key_map.get(key.as_str()) {
                let mut input = INPUT {
                    r#type: INPUT_KEYBOARD,
                    Anonymous: std::mem::zeroed(),
                };
                // 直接设置ki字段
                input.Anonymous.ki = KEYBDINPUT {
                    wVk: vk,
                    wScan: 0,
                    dwFlags: KEYEVENTF_KEYUP,
                    time: 0,
                    dwExtraInfo: 0,
                };
                SendInput(1, &input, std::mem::size_of::<INPUT>() as i32);
                thread::sleep(delay);
            }
        }
    }
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
            "6" => enigo.key_click(Key::Raw(54)),
            "7" => enigo.key_click(Key::Raw(55)),
            "8" => enigo.key_click(Key::Raw(56)),
            "9" => enigo.key_click(Key::Raw(57)),
            "0" => enigo.key_click(Key::Raw(48)),

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
        thread::sleep(delay);
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
                                               (width >= screen_width - 10) &&
                                               (height >= screen_height - 10);

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

    println!("找到源目录: {:?}", source_path);
    println!("目标目录: {:?}", target_dir);

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

            println!("复制: {:?} -> {:?}", src_path, dst_path);

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
    println!("安装插件: {:?} -> {:?}", source_path, dst_path);

    // 如果目标目录已存在，先删除
    if dst_path.exists() {
        fs::remove_dir_all(&dst_path).map_err(|e| format!("删除已存在的目录失败: {}", e))?;
    }

    // 复制目录
    copy_dir_all(&source_path, &dst_path).map_err(|e| format!("复制目录失败: {}", e))?;

    Ok(format!("插件安装成功!", ))
}

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_store::Builder::default().build())
        .plugin(tauri_plugin_global_shortcut::Builder::default().build())
        .plugin(tauri_plugin_fs::init())
        .plugin(tauri_plugin_dialog::init())
        .plugin(tauri_plugin_opener::init())
        .invoke_handler(tauri::generate_handler![
            get_pixel_color,
            get_current_position_color,
            press_keys,
            press_keys2,
            move_mouse_to_point,
            get_hostname,
            get_wow_window_info,
            install_addon
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
