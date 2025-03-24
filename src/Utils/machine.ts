import { invoke } from "@tauri-apps/api/core";

/**
 * 获取当前机器的唯一标识码
 *
 * 该函数调用Tauri后端的get_machine_code命令，获取基于硬件信息生成的唯一机器码
 * Windows系统下使用CPU ID和主板序列号
 * macOS系统下使用硬件UUID
 * Linux系统下使用machine-id
 *
 * @returns {Promise<string>} 机器唯一标识码
 * @throws {Error} 如果无法获取机器码则抛出错误
 */
export async function getMachineCode(): Promise<string> {
  try {
    const machineCode = await invoke<string>('get_machine_code');
    return machineCode;
  } catch (error) {
    console.error('获取机器码失败:', error);
    throw new Error('无法获取机器码，请检查系统权限或联系技术支持');
  }
}

/**
 * 获取机器码的同步版本（实际上内部使用了缓存）
 *
 * 该函数会在首次调用时获取机器码并缓存起来，后续调用直接返回缓存值
 * 注意：该函数返回的是上次成功获取的机器码，如果初始未获取成功会返回空字符串
 *
 * @returns {string} 缓存的机器码或空字符串
 */
let cachedMachineCode: string = '';

export function getMachineCodeSync(): string {
  // 如果缓存中没有机器码，则返回空字符串
  // 推荐优先使用异步版本来确保正确获取
  return cachedMachineCode;
}

// 初始化时自动异步获取一次机器码并缓存
getMachineCode().then(code => {
  cachedMachineCode = code;
}).catch(() => {
  // 初始获取失败时，保持缓存为空字符串
});