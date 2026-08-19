/* =========================================================
 *  AI 接口配置（OpenAI 兼容格式）
 *  使用方法：
 *  1. 复制本文件为 ai-config.js（注意：不要带 .example）
 *  2. 填入你自己的 API 地址、Key、模型名
 *  3. 刷新网页，配置自动生效
 *
 *  ⚠️ ai-config.js 已在 .gitignore 中，不会被上传到 Git 仓库
 *  支持：智谱 GLM / DeepSeek / OpenAI / 通义千问 等兼容接口
 * ========================================================= */
window.AI_CONFIG = {
  baseUrl: 'https://open.bigmodel.cn/api/paas/v4',  // API 地址（不带 /chat/completions）
  apiKey:  'your-api-key-here',                     // 替换为你的 API Key
  model:   'glm-4-flash'                            // 模型名
};
