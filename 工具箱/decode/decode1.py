import re
import os
import shutil
from pathlib import Path

def decode_ascii_string(match):
    try:
        # 将连续的ASCII码转换为字节序列
        ascii_codes = match.group(0).split('\\')[1:]
        bytes_data = bytes([int(code) for code in ascii_codes if code])
        # 尝试用UTF-8解码
        decoded_string = bytes_data.decode('utf-8')
        return decoded_string.replace('\n', '\\n')  # 保留换行符
    except:
        # 如果解码失败，返回原始匹配
        return match.group(0)

def decode_lua_file(input_file, output_file):
    try:
        # 读取输入文件
        with open(input_file, 'r', encoding='utf-8') as f:
            content = f.read()

        # 使用正则表达式匹配连续的ASCII码
        pattern = r'\\(?:\d+\\)*\d+'
        decoded_content = re.sub(pattern, decode_ascii_string, content)

        # 创建备份文件
        # backup_file = str(input_file) + '.bak'
        # if not os.path.exists(backup_file):
        #     shutil.copy2(input_file, backup_file)
        #     print(f"已创建备份文件：{backup_file}")

        # 写入解密后的内容到原文件
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(decoded_content)

        print(f"解密完成：{output_file}")
        return True

    except Exception as e:
        print(f"处理文件 {input_file} 时出错：{str(e)}")
        return False

def process_directory(directory_path):
    try:
        # 转换为Path对象
        base_path = Path(directory_path)

        # 确保目录存在
        if not base_path.exists():
            print(f"错误：目录 {directory_path} 不存在")
            return

        # 统计信息
        total_files = 0
        processed_files = 0
        failed_files = 0

        # 递归查找所有.lua文件
        print(f"\n开始处理目录：{directory_path}")
        print("="*50)

        for lua_file in base_path.rglob("*.lua"):
            total_files += 1
            print(f"\n处理文件 ({total_files}): {lua_file}")

            if decode_lua_file(lua_file, lua_file):
                processed_files += 1
            else:
                failed_files += 1

        # 打印统计信息
        print("\n" + "="*50)
        print(f"处理完成！总计：")
        print(f"- 发现的Lua文件：{total_files}")
        print(f"- 成功处理：{processed_files}")
        print(f"- 处理失败：{failed_files}")

    except Exception as e:
        print(f"处理目录时出错：{str(e)}")

if __name__ == "__main__":
    # 指定要处理的根目录
    root_directory = "."  # 当前目录
    process_directory(root_directory)
