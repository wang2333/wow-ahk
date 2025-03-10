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
            "ALT" => enigo.key_down(Key::Alt),
            "CTRL" => enigo.key_down(Key::Control),
            "SHIFT" => enigo.key_down(Key::Shift),
            _ => {}
        }
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
            "," => enigo.key_click(Key::Layout(',')),
            "." => enigo.key_click(Key::Layout('.')),
            ";" => enigo.key_click(Key::Layout(';')),
            "[" => enigo.key_click(Key::Layout('[')),
            "]" => enigo.key_click(Key::Layout(']')),
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
            "ALT" => enigo.key_up(Key::Alt),
            "CTRL" => enigo.key_up(Key::Control),
            "SHIFT" => enigo.key_up(Key::Shift),
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
