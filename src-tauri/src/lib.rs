use enigo::{Enigo, Key, KeyboardControllable, MouseControllable};
use screenshots::Screen;
use serde::Serialize;

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

    // 按下所有修饰键
    for key in &keys {
        match key.as_str() {
            "alt" => enigo.key_down(Key::Alt),
            "ctrl" => enigo.key_down(Key::Control),
            "shift" => enigo.key_down(Key::Shift),
            _ => {}
        }
    }

    // 按下主键
    for key in &keys {
        match key.as_str() {
            "f1" => enigo.key_click(Key::F1),
            "f2" => enigo.key_click(Key::F2),
            "f3" => enigo.key_click(Key::F3),
            "f4" => enigo.key_click(Key::F4),
            "f5" => enigo.key_click(Key::F5),
            "f6" => enigo.key_click(Key::F6),
            "f7" => enigo.key_click(Key::F7),
            "f8" => enigo.key_click(Key::F8),
            "f9" => enigo.key_click(Key::F9),
            "f10" => enigo.key_click(Key::F10),
            "f11" => enigo.key_click(Key::F11),
            "f12" => enigo.key_click(Key::F12),
            "num0" => enigo.key_click(Key::Numpad0),
            "num1" => enigo.key_click(Key::Numpad1),
            "num2" => enigo.key_click(Key::Numpad2),
            "num3" => enigo.key_click(Key::Numpad3),
            "num4" => enigo.key_click(Key::Numpad4),
            "num5" => enigo.key_click(Key::Numpad5),
            "num6" => enigo.key_click(Key::Numpad6),
            "num7" => enigo.key_click(Key::Numpad7),
            "num8" => enigo.key_click(Key::Numpad8),
            "num9" => enigo.key_click(Key::Numpad9),
            "," => enigo.key_click(Key::Layout(',')),
            "." => enigo.key_click(Key::Layout('.')),
            ";" => enigo.key_click(Key::Layout(';')),
            "-" => enigo.key_click(Key::Layout('-')),
            "=" => enigo.key_click(Key::Layout('=')),
            "/" => enigo.key_click(Key::Layout('/')),
            "[" => enigo.key_click(Key::Layout('[')),
            "]" => enigo.key_click(Key::Layout(']')),
            "`" => enigo.key_click(Key::Layout('`')),
            "numdivide" => enigo.key_click(Key::Raw(0x6F)),
            "pageup" => enigo.key_click(Key::PageUp),
            "home" => enigo.key_click(Key::Home),
            "up" => enigo.key_click(Key::UpArrow),
            "down" => enigo.key_click(Key::DownArrow),
            "left" => enigo.key_click(Key::LeftArrow),
            "right" => enigo.key_click(Key::RightArrow),
            "mousewheelup" => enigo.mouse_scroll_y(1),
            "mousewheeldown" => enigo.mouse_scroll_y(-1),
            "space" => enigo.key_click(Key::Space),
            "tab" => enigo.key_click(Key::Tab),
            "enter" => enigo.key_click(Key::Return),
            "escape" => enigo.key_click(Key::Escape),
            "backspace" => enigo.key_click(Key::Backspace),
            "delete" => enigo.key_click(Key::Delete),
            "insert" => enigo.key_click(Key::Raw(0x2D)),
            "end" => enigo.key_click(Key::End),
            "pagedown" => enigo.key_click(Key::PageDown),
            "capslock" => enigo.key_click(Key::CapsLock),
            "numlock" => enigo.key_click(Key::Raw(0x90)),
            "menu" => enigo.key_click(Key::Meta),

            key if key.len() == 1 => {
                if let Some(c) = key.chars().next() {
                    enigo.key_click(Key::Layout(c.to_ascii_lowercase()));
                }
            }
            _ => {}
        }
    }

    // 释放所有修饰键
    for key in &keys {
        match key.as_str() {
            "alt" => enigo.key_up(Key::Alt),
            "ctrl" => enigo.key_up(Key::Control),
            "shift" => enigo.key_up(Key::Shift),
            _ => {}
        }
    }
}

#[tauri::command]
fn move_mouse_to_point(x: f64, y: f64) -> Result<(), String> {
    let mut enigo = Enigo::new();
    enigo.mouse_move_to(x as i32, y as i32);
    Ok(())
}

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_dialog::init())
        .plugin(tauri_plugin_fs::init())
        .plugin(tauri_plugin_global_shortcut::Builder::new().build())
        .plugin(tauri_plugin_opener::init())
        .invoke_handler(tauri::generate_handler![
            get_pixel_color,
            get_current_position_color,
            press_keys,
            move_mouse_to_point
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
