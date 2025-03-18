"""
Lua代码解密工具
用于解密和处理加密的Lua文件
"""

import re
import os
import logging
from pathlib import Path
from typing import Union, Optional, Dict, List, Callable

# 配置常量
CONFIG = {
    'LOG': {
        'level': logging.INFO,
        'format': '%(asctime)s - %(levelname)s - %(message)s'
    },
    'FILE': {
        'base_directory': '.',
        'pattern': '*.lua',
        'encoding': 'utf-8'
    },
    'DECRYPT': {
        'dict_size': 256,
        'decompression_key': 'r'
    }
}

# 配置日志
logging.basicConfig(
    level=CONFIG['LOG']['level'],
    format=CONFIG['LOG']['format']
)
logger = logging.getLogger(__name__)

class LuaDecoder:
    """Lua代码解密工具类"""

    def __init__(self):
        """初始化解密器"""
        self.decompressed_key = self.decompress(CONFIG['DECRYPT']['decompression_key'])

    @staticmethod
    def calculate_sum(text: str) -> int:
        """
        计算字符串ASCII值总和

        Args:
            text: 输入字符串

        Returns:
            ASCII值总和
        """
        return sum(ord(c) for c in text)

    def decompress(self, compressed_str: str) -> str:
        """
        LZW解压缩算法

        Args:
            compressed_str: 压缩后的字符串

        Returns:
            解压后的字符串
        """
        if compressed_str == CONFIG['DECRYPT']['decompression_key']:
            return ""

        # 初始化字典
        dict_size = CONFIG['DECRYPT']['dict_size']
        dictionary = {i: chr(i) for i in range(dict_size)}

        # 读取压缩数据
        def read_value(pos: int) -> tuple[int, int]:
            digit_count = int(compressed_str[pos], 36)
            value = int(compressed_str[pos + 1:pos + 1 + digit_count], 36)
            return value, pos + 1 + digit_count

        # 解压缩过程
        result = []
        position = 0

        # 读取第一个字符
        first_value, position = read_value(position)
        current_char = chr(first_value)
        result.append(current_char)

        # 处理剩余数据
        while position < len(compressed_str):
            code, position = read_value(position)

            if code in dictionary:
                next_char = dictionary[code]
            else:
                next_char = current_char + current_char[0]

            result.append(next_char)
            dictionary[dict_size] = current_char + next_char[0]
            current_char = next_char
            dict_size += 1

        return ''.join(result)

    @staticmethod
    def hex_to_string(hex_str: str) -> str:
        """
        十六进制字符串转普通字符串

        Args:
            hex_str: 十六进制字符串

        Returns:
            转换后的字符串
        """
        try:
            bytes_data = bytes.fromhex(hex_str)
            return bytes_data.decode('latin-1')
        except Exception as e:
            logger.error(f"十六进制转换失败: {str(e)}")
            raise

    def decrypt(self, shift: int, encrypted_text: str) -> str:
        """
        解密函数

        Args:
            shift: 偏移量
            encrypted_text: 加密文本

        Returns:
            解密后的文本
        """
        try:
            decrypted_text = self.decompressed_key

            # 字符解密
            for i in range(len(encrypted_text)):
                char_code = ord(encrypted_text[i]) - (shift + i + 1) % 256
                if char_code < 0:
                    char_code += 256
                decrypted_text += chr(char_code)

            # 尝试UTF-8解码
            try:
                bytes_result = decrypted_text.encode('latin-1')
                return bytes_result.decode('utf-8')
            except UnicodeDecodeError:
                return decrypted_text

        except Exception as e:
            logger.error(f"解密失败: {str(e)}")
            raise

    def decrypt_with_key(self, key: str, hex_text: str) -> str:
        """
        使用密钥解密十六进制文本

        Args:
            key: 解密密钥
            hex_text: 十六进制文本

        Returns:
            解密后的文本
        """
        return self.decrypt(self.calculate_sum(key), self.hex_to_string(hex_text))


class LuaFileProcessor:
    """Lua文件处理类"""

    def __init__(self):
        """初始化文件处理器"""
        self.decoder = LuaDecoder()
        self.success_count = 0
        self.fail_count = 0
        self.total_files = 0

    def _process_a21(self, content: str, key: str) -> str:
        """
        处理a21函数调用

        Args:
            content: 文件内容
            key: 解密密钥

        Returns:
            处理后的内容
        """
        def replace_a21(match: re.Match) -> str:
            hex_str = match.group(1)
            result = self.decoder.decrypt_with_key(key, hex_str)
            return f'{result}' + ' '

        # 处理双引号和单引号的情况
        content = re.sub(
            r'a\[21\]\(a\[27\],\s*"([0-9A-F]+)"?\)',
            replace_a21,
            content,
            flags=re.MULTILINE | re.DOTALL | re.IGNORECASE
        )
        content = re.sub(
            r'a\[21\]\(a\[27\],\'([0-9A-F]+)\'?\)',
            replace_a21,
            content,
            flags=re.MULTILINE | re.DOTALL | re.IGNORECASE
        )
        return content

    def _process_a22(self, content: str) -> str:
        """
        处理a22函数调用

        Args:
            content: 文件内容

        Returns:
            处理后的内容
        """
        # 处理双引号和单引号的情况
        content = re.sub(
            r'a\[22\]\(a\[27\],\s*"[0-9A-F]*"?\)',
            f'"{self.decoder.decompressed_key}" ',
            content,
            flags=re.MULTILINE | re.DOTALL | re.IGNORECASE
        )
        content = re.sub(
            r'a\[22\]\(a\[27\],\'[0-9A-F]*\'?\)',
            f'"{self.decoder.decompressed_key}" ',
            content,
            flags=re.MULTILINE | re.DOTALL | re.IGNORECASE
        )
        return content

    def _process_a28(self, content: str, key: str) -> str:
        """
        处理a28函数调用

        Args:
            content: 文件内容
            key: 解密密钥

        Returns:
            处理后的内容
        """
        def replace_a28(match: re.Match) -> str:
            hex_str = match.group(1)
            result = self.decoder.decrypt_with_key(key, hex_str)
            result = result.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n').replace('\r', '\\r').replace('\t', '\\t')
            return f'"{result}"' + ' '

        # 处理双引号的情况
        content = re.sub(
            r'a\[28\]\(a\[27\],\s*"([^"]+)"\)',
            replace_a28,
            content,
            flags=re.MULTILINE | re.DOTALL
        )

        # 处理单引号的情况
        content = re.sub(
            r'a\[28\]\(a\[27\],\s*\'([^\']+)\'\)',
            replace_a28,
            content,
            flags=re.MULTILINE | re.DOTALL
        )

        return content

    def _create_replacements(self) -> List[tuple[str, str]]:
        """
        创建基础替换规则

        Returns:
            替换规则列表
        """
        return [
            (r'a\[24\]\(a\[27\],\s*"[0-9A-F]+"?\)', 'true '),
            (r'a\[24\]\(a\[27\],\'[0-9A-F]+\'?\)', 'true '),
            (r'a\[25\]\(a\[27\],\s*"[0-9A-F]+"?\)', 'false '),
            (r'a\[25\]\(a\[27\],\'[0-9A-F]+\'?\)', 'false '),
            (r'a\[29\]\(a\[27\],\s*"[0-9A-F]+"?\)', 'nil '),
            (r'a\[29\]\(a\[27\],\'[0-9A-F]+\'?\)', 'nil ')
        ]

    def process_file(self, file_path: Path) -> bool:
        """
        处理单个Lua文件

        Args:
            file_path: 文件路径

        Returns:
            处理是否成功
        """
        try:
            logger.info(f"开始处理文件: {file_path}")

            # 读取文件内容
            with open(file_path, 'r', encoding=CONFIG['FILE']['encoding']) as file:
                content = file.read()

            # 提取密钥
            key_match = re.search(r'a\[27\]=a\[8\]\[a\[10\]\.\.a\[7\]\]\([\'"](.*?)[\'"]\)', content.replace(' ', ''))
            if not key_match:
                logger.warning(f"文件 {file_path} 中未找到密钥，跳过处理")
                return False

            key = key_match.group(1)
            logger.debug(f"提取到的密钥: {key}")

            # 替换操作
            content = content.replace('a[23]', '_G')

            # 处理a21、a22和a28
            content = self._process_a21(content, key)
            content = self._process_a22(content)
            content = self._process_a28(content, key)

            # 应用其他替换规则
            for pattern, replacement in self._create_replacements():
                content = re.sub(pattern, replacement, content, flags=re.MULTILINE | re.DOTALL | re.IGNORECASE)

            # 写回文件
            with open(file_path, 'w', encoding=CONFIG['FILE']['encoding']) as file:
                file.write(content)

            logger.info(f"成功处理文件: {file_path}")
            return True

        except Exception as e:
            logger.error(f"处理文件 {file_path} 时出错: {str(e)}")
            return False

    def process_directory(self, directory_path: str) -> None:
        """
        处理目录下的所有Lua文件

        Args:
            directory_path: 目录路径
        """
        try:
            directory = Path(directory_path)
            self.success_count = 0
            self.fail_count = 0
            self.total_files = 0

            logger.info(f"开始处理目录: {directory}")

            # 处理所有Lua文件
            for lua_file in directory.rglob(CONFIG['FILE']['pattern']):
                self.total_files += 1
                if self.process_file(lua_file):
                    self.success_count += 1
                else:
                    self.fail_count += 1

            # 输出统计信息
            self._print_statistics()

        except Exception as e:
            logger.error(f"处理目录时出错: {str(e)}")

    def _print_statistics(self) -> None:
        """输出处理统计信息"""
        logger.info(f"""
处理完成！统计信息：
- 总文件数: {self.total_files}
- 成功处理: {self.success_count}
- 处理失败: {self.fail_count}
""")

def main():
    """主程序入口"""
    processor = LuaFileProcessor()
    processor.process_directory(CONFIG['FILE']['base_directory'])

if __name__ == "__main__":
    main()