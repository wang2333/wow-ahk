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
            move_mouse_to_point,
            get_hostname,
            get_wow_window_info
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
