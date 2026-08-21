/* =========================================================
 *  配置文件（AI 接口 + Supabase 数据库）
 *  使用方法：
 *  1. 复制本文件为 ai-config.js（不要带 .example）
 *  2. 填入你自己的配置
 *  3. 刷新网页，配置自动生效
 *
 *  ⚠️ ai-config.js 已在 .gitignore 中，不会上传到 Git 仓库
 * ========================================================= */
window.AI_CONFIG = {
  /* ---- AI 接口（OpenAI 兼容格式，用于「AI 匹配」）---- */
  baseUrl: 'https://open.bigmodel.cn/api/paas/v4',
  apiKey:  'your-api-key-here',
  model:   'glm-4-flash',

  /* ---- Supabase 数据库（用于菜谱增删改查）---- */
  /* 在 Supabase Dashboard → Settings → API 中获取 */
  supabaseUrl: 'https://hjibacuptkzibgmlikis.supabase.co',
  supabaseKey: 'your-anon-key-here'  // anon public key，可公开（受 RLS 保护）
};
