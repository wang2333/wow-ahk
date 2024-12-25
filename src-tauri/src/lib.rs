use enigo::{Enigo, Key, KeyboardControllable, MouseControllable};
use screenshots::Screen;
use serde::Serialize;

#[derive(Debug, Serialize)]
struct ColorInfo {
    r: u8,
    g: u8,
    b: u8,
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
            "NUM0" => enigo.key_click(Key::Layout('0')),
            "NUM1" => enigo.key_click(Key::Layout('1')),
            "NUM2" => enigo.key_click(Key::Layout('2')),
            "NUM3" => enigo.key_click(Key::Layout('3')),
            "NUM4" => enigo.key_click(Key::Layout('4')),
            "NUM5" => enigo.key_click(Key::Layout('5')),
            "NUM6" => enigo.key_click(Key::Layout('6')),
            "NUM7" => enigo.key_click(Key::Layout('7')),
            "NUM8" => enigo.key_click(Key::Layout('8')),
            "NUM9" => enigo.key_click(Key::Layout('9')),
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
        .plugin(tauri_plugin_fs::init())
        .plugin(tauri_plugin_global_shortcut::Builder::new().build())
        .plugin(tauri_plugin_opener::init())
        .invoke_handler(tauri::generate_handler![
            get_pixel_color,
            press_keys,
            move_mouse_to_point
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
