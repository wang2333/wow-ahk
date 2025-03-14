def calculate_sum(s):
    """计算字符串中所有字符ASCII值的总和"""
    return sum(ord(c) for c in s)

def decompress(compressed_str):
    """LZW解压缩算法"""
    key = "r"
    if compressed_str == key:
        return ""

    # 初始化字典
    dict_size = 256
    dictionary = {i: chr(i) for i in range(dict_size)}

    # 读取压缩数据的函数
    position = 0
    def read_value():
        nonlocal position
        digit_count = int(compressed_str[position], 36)
        position += 1
        value = int(compressed_str[position:position+digit_count], 36)
        position += digit_count
        return value

    # 解压缩过程
    result = []
    current_char = chr(read_value())
    result.append(current_char)

    while position < len(compressed_str):
        code = read_value()
        if code in dictionary:
            next_char = dictionary[code]
        else:
            next_char = current_char + current_char[0]

        dictionary[dict_size] = current_char + next_char[0]
        result.append(next_char)
        current_char = next_char
        dict_size += 1

    return ''.join(result)

def hex_to_string(hex_str):
    """将十六进制字符串转换为普通字符串"""
    bytes_data = bytes.fromhex(hex_str)
    return bytes_data.decode('latin-1')  # 使用latin-1编码保持字节值不变

def decrypt(shift, encrypted_text):
    """解密函数"""
    decompressed_key = decompress("r")  # 这里使用key的值
    decrypted_text = decompressed_key

    for i in range(len(encrypted_text)):
        char_code = ord(encrypted_text[i]) - (shift + i + 1) % 256
        if char_code < 0:
            char_code += 256
        decrypted_text += chr(char_code)

    # 尝试将结果转换为UTF-8编码
    try:
        # 假设结果是UTF-8编码的字节
        bytes_result = decrypted_text.encode('latin-1')
        return bytes_result.decode('utf-8')
    except UnicodeDecodeError:
        # 如果UTF-8解码失败，返回原始结果
        return decrypted_text

def a28(a_, aX):
    """对应Lua中的a[28]函数"""
    return decrypt(calculate_sum(a_), hex_to_string(aX))

# 测试代码
print(a28('F413BF59', "283B4B2B425440"))