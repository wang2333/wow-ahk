import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

// 获取当前文件的目录
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// 定义路径
const sourceDir = path.join(__dirname, 'src', 'addOns');
const targetDir = path.join(__dirname, '..', 'src', 'addOns');

// 递归复制目录函数
function copyDirSync(src, dest) {
  // 创建目标目录
  if (!fs.existsSync(dest)) {
    fs.mkdirSync(dest, { recursive: true });
  }

  // 获取源目录中的所有文件和子目录
  const entries = fs.readdirSync(src, { withFileTypes: true });

  // 遍历所有条目
  for (const entry of entries) {
    const srcPath = path.join(src, entry.name);
    const destPath = path.join(dest, entry.name);

    // 如果是目录，递归复制
    if (entry.isDirectory()) {
      copyDirSync(srcPath, destPath);
    } else {
      // 如果是文件，直接复制
      fs.copyFileSync(srcPath, destPath);
    }
  }
}

// 确保源目录存在
if (!fs.existsSync(sourceDir)) {
  console.error(`源目录不存在: ${sourceDir}`);
  process.exit(1);
}

// 复制插件目录
console.log(`复制插件目录: ${sourceDir} -> ${targetDir}`);
try {
  copyDirSync(sourceDir, targetDir);
  console.log('插件目录复制成功!');
} catch (error) {
  console.error('复制插件目录失败:', error);
  process.exit(1);
}