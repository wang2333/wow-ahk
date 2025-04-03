import re
import sys
import os
import time

def simplify_ll1I_expressions(lua_content):
    """
    查找并简化lua文件中的ll1I函数调用参数
    例如：将ll1I(- 237594 - (- 216423))转换为ll1I(-21171)
    """
    # 正则表达式匹配ll1I函数及其参数，使用非贪婪模式并处理括号嵌套
    def find_matching_parenthesis(s, start_pos):
        """查找匹配的括号"""
        count = 1
        for i in range(start_pos + 1, len(s)):
            if s[i] == '(':
                count += 1
            elif s[i] == ')':
                count -= 1
                if count == 0:
                    return i
        return -1

    # 替换函数，针对每一个ll1I调用进行处理
    def replace_ll1I(lua_content):
        result = ""
        i = 0
        simplified_count = 0
        total_count = 0
        error_count = 0

        while i < len(lua_content):
            # 查找ll1I函数调用
            match = lua_content.find("ll1I(", i)
            if match == -1:
                result += lua_content[i:]
                break

            result += lua_content[i:match + 5]  # 添加"ll1I("
            total_count += 1

            # 找到匹配的右括号
            end_pos = find_matching_parenthesis(lua_content, match + 4)
            if end_pos == -1:
                result += lua_content[match + 5:]
                break

            # 提取表达式
            expr = lua_content[match + 5:end_pos]
            original_expr = expr

            try:
                # 尝试转换Lua表达式为Python表达式
                # 替换Lua特定语法
                expr = expr.replace('--', '#')  # 注释
                expr = expr.replace('~=', '!=')  # 不等于

                # 移除可能的Lua注释
                expr = re.sub(r'#.*$', '', expr)

                # 处理括号内的负数，如(- 123)转换为(-123)
                expr = re.sub(r'\(\s*-\s*(\d+)\s*\)', r'(-\1)', expr)

                # 处理减去负数的情况，如 - (- 123) 转换为 + 123
                expr = re.sub(r'-\s*\(\s*-\s*(\d+)\s*\)', r'+ \1', expr)

                # 处理加上负数的情况，如 + (- 123) 转换为 - 123
                expr = re.sub(r'\+\s*\(\s*-\s*(\d+)\s*\)', r'- \1', expr)

                # 处理其他可能的Lua特定语法
                expr = expr.strip()

                # 使用Python的eval安全地计算表达式
                simplified_value = eval(expr)
                result += str(simplified_value)
                simplified_count += 1
            except Exception as e:
                # 如果无法简化，保留原始表达式
                result += original_expr
                error_count += 1
                print(f"警告: 无法简化表达式: {original_expr}. 错误: {e}")

            result += ")"
            i = end_pos + 1

        return result, simplified_count, total_count, error_count

    # 执行替换
    start_time = time.time()
    simplified_content, simplified_count, total_count, error_count = replace_ll1I(lua_content)
    end_time = time.time()

    stats = {
        'simplified_count': simplified_count,
        'total_count': total_count,
        'error_count': error_count,
        'execution_time': end_time - start_time
    }

    return simplified_content, stats

def process_lua_file(input_file, output_file=None):
    """
    处理单个Lua文件
    """
    # 如果没有指定输出文件，生成默认输出文件名
    if output_file is None:
        filename, ext = os.path.splitext(input_file)
        output_file = f"{filename}_simplified{ext}"

    try:
        # 读取输入文件
        file_size = os.path.getsize(input_file) / (1024 * 1024)  # 文件大小(MB)
        print(f"正在读取文件: {input_file} (大小: {file_size:.2f} MB)")

        with open(input_file, 'r', encoding='utf-8') as f:
            lua_content = f.read()

        print(f"文件读取完成，开始处理...")

        # 简化ll1I表达式
        simplified_content, stats = simplify_ll1I_expressions(lua_content)

        # 写入输出文件
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(simplified_content)

        # 输出统计信息
        print(f"\n处理完成: {input_file} -> {output_file}")
        print(f"文件大小: {file_size:.2f} MB")
        print(f"处理时间: {stats['execution_time']:.2f} 秒")
        print(f"发现的ll1I调用总数: {stats['total_count']}")

        if stats['total_count'] > 0:
            success_percent = stats['simplified_count'] / stats['total_count'] * 100
            error_percent = stats['error_count'] / stats['total_count'] * 100
            print(f"成功简化的调用数: {stats['simplified_count']} ({success_percent:.2f}%)")
            print(f"无法简化的调用数: {stats['error_count']} ({error_percent:.2f}%)")
        else:
            print("此文件中未发现ll1I函数调用")

    except Exception as e:
        print(f"处理文件 {input_file} 时出错: {e}")
        raise

def main():
    """
    主函数，处理命令行参数
    """
    if len(sys.argv) < 2:
        print("\n用法: python simplify_ll1I.py <lua文件> [输出文件]")
        print("示例: python simplify_ll1I.py input.lua output.lua")
        print("\n说明: 此脚本用于简化Lua文件中的ll1I函数调用参数")
        print("      例如将ll1I(- 237594 - (- 216423))转换为ll1I(-21171)")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2] if len(sys.argv) > 2 else None

    process_lua_file(input_file, output_file)

if __name__ == "__main__":
    main()
