# 🍳 今日吃什么 — 家常菜单随机器

一个纯前端的「午餐该吃啥」决策工具：荤素分开随机，按份量生成一周菜谱，换一道菜自动同步所有对应天。零依赖、零后端、单文件部署。

> 解决每天中午"吃啥"的灵魂拷问 🤔

---

## ✨ 核心功能

### 🎲 随机点餐
- **荤素分开随机**：互不干扰，可只换一个
- **品类多选下拉**：按鸡肉 / 猪肉 / 牛肉 / 鱼虾、绿叶菜 / 瓜果等品类筛选
- **减脂筛选三档**：不限 / 优先减脂 / 只看减脂
- **菜谱详情**：确认后展示完整食材清单 + 做法步骤

### 📅 一周菜谱（5 天）
- 按"一份菜做 2 顿"的逻辑，采用 **2-2-1 分配**：
  - 周一 / 周二 = 荤0 + 素0
  - 周三 / 周四 = 荤1 + 素1
  - 周五 = 荤2 + 素2（余量）
- 抽 3 道不重复荤菜 + 3 道不重复素菜覆盖整周
- **顶部菜品集**：直观展示本周荤菜 / 素菜集合及每道菜出现的天数
- **按菜品换菜**：点一道菜的"换菜"按钮，自动替换本周所有用到它的天（而非单天换菜）

### 📚 菜谱维护
- 增删改查所有荤菜 / 素菜
- 搜索（菜名 / 食材 / 做法）、按品类筛选
- **恢复默认菜谱库**：一键还原内置数据

### 💾 数据持久化
- 全部菜谱保存在浏览器 `localStorage`（key: `caipu_db_v1`）
- 新增 / 修改 / 删除即时生效并同步到随机池
- 刷新页面、重启浏览器都不会丢失

---

## 📦 内置菜谱库

共 **79 道家常菜**（42 荤 + 37 素），每道菜均含：
- 菜名、品类、是否减脂
- 完整食材清单（含份量）
- 分步骤做法

> **菜谱来源**：下厨房、美食杰 等主流菜谱平台常见家常菜的简化整合，仅供个人日常使用。

---

## 🚀 部署 / 使用

### 方式一：本地直接打开
下载 `index.html`，双击用浏览器打开即可。

### 方式二：GitHub Pages 公网访问
1. Fork / 上传本仓库到 GitHub
2. 仓库 **Settings → Pages**
3. Source 选 `Deploy from a branch`，Branch 选 `main` / `(root)`
4. 保存后 1~2 分钟访问：

   ```
   https://<你的用户名>.github.io/menu/
   ```

---

## 🛠 技术栈

- 原生 HTML / CSS / JavaScript（无框架、无构建工具）
- 单文件 SPA，localStorage 持久化
- 响应式布局，移动端可用

---

## 📁 项目结构

```
menu/
├── index.html             # 网页主体（HTML + CSS + JS 逻辑）
├── data.js                # 菜谱数据层（DEFAULT_DB，79道家常菜，可单独维护）
├── ai-config.example.js   # AI 接口配置模板（参考用，可上传）
├── ai-config.js           # AI 接口配置实际文件（⚠️ 本地保存，.gitignore 忽略）
├── .gitignore             # Git 忽略规则（含 ai-config.js）
└── README.md
```

### 🔐 配置（AI 接口 + Supabase 数据库）

所有配置存在本地 `ai-config.js` 文件中（已在 `.gitignore`，不会上传 Git）。

#### 1. Supabase 数据库（必选，用于菜谱增删改查）

1. 创建 Supabase 项目 → [supabase.com](https://supabase.com)
2. 在 **SQL Editor** 执行 [supabase-schema.sql](supabase-schema.sql)（建表 + 权限）
3. 在 **Settings → API** 复制 `Project URL` 和 `anon public` key
4. 复制 `ai-config.example.js` 为 `ai-config.js`，填入 `supabaseUrl` 和 `supabaseKey`
5. 刷新网页，首次加载自动导入 79 道默认菜谱

#### 2. AI 接口（可选，用于「AI 匹配」自动填充菜谱）

在 `ai-config.js` 中填入兼容 OpenAI 格式的 API（智谱 GLM / DeepSeek / OpenAI 等）。

**安全性**：
- Supabase anon key 设计为公开（受 RLS 保护），但仍存在本地文件，不上传 Git
- AI API Key 完全本地，不进 localStorage
- 如未配置 AI，自动降级为本地关键词匹配

---

## 📁 项目结构

```
menu/
├── index.html             # 网页主体（HTML + CSS + JS 逻辑）
├── data.js                # 菜谱数据层（DEFAULT_DB，79道家常菜，首次导入用）
├── ai-config.example.js   # 配置模板（AI + Supabase，可上传）
├── ai-config.js           # 实际配置（⚠️ 本地保存，.gitignore 忽略）
├── supabase-schema.sql    # Supabase 建表 SQL
├── .gitignore             # Git 忽略规则
└── README.md
```

---

## 📝 使用提示

- 至少需 3 荤 3 素才能生成一周菜谱，筛选太严会提示调整
- 换菜时只会换成与当前不同的菜（避免随机出同一道）
- 菜谱增删改直接写入 Supabase，刷新页面数据保持一致
- 点「⬇️ 下载备份」可导出当前菜谱为 JS 文件备份
