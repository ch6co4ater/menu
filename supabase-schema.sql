-- =========================================================
--  菜谱应用 - Supabase 建表 + 权限配置
--  执行位置：Supabase Dashboard → SQL Editor → 粘贴执行
-- =========================================================

-- 1. 创建 dishes 表
CREATE TABLE IF NOT EXISTS dishes (
  id          SERIAL PRIMARY KEY,
  type        TEXT NOT NULL CHECK (type IN ('meat', 'veg')),
  name        TEXT NOT NULL,
  category    TEXT NOT NULL,
  "lowFat"    BOOLEAN DEFAULT FALSE,
  "singleUse" BOOLEAN DEFAULT FALSE,
  ingredients JSONB DEFAULT '[]'::jsonb,
  steps       JSONB DEFAULT '[]'::jsonb,
  created_at  TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. 索引：按荤/素分类查询
CREATE INDEX IF NOT EXISTS idx_dishes_type ON dishes(type);
CREATE INDEX IF NOT EXISTS idx_dishes_category ON dishes(category);

-- 3. 启用 Row Level Security
ALTER TABLE dishes ENABLE ROW LEVEL SECURITY;

-- 4. 权限策略（公开菜谱库，anon 和 authenticated 都可读写）
--    个人小项目可直接放开；如需更严格权限，可改为只允许 authenticated
DROP POLICY IF EXISTS "dishes_public_read" ON dishes;
DROP POLICY IF EXISTS "dishes_public_insert" ON dishes;
DROP POLICY IF EXISTS "dishes_public_update" ON dishes;
DROP POLICY IF EXISTS "dishes_public_delete" ON dishes;

CREATE POLICY "dishes_public_read"   ON dishes FOR SELECT TO anon, authenticated USING (true);
CREATE POLICY "dishes_public_insert" ON dishes FOR INSERT  TO anon, authenticated WITH CHECK (true);
CREATE POLICY "dishes_public_update" ON dishes FOR UPDATE  TO anon, authenticated USING (true) WITH CHECK (true);
CREATE POLICY "dishes_public_delete" ON dishes FOR DELETE  TO anon, authenticated USING (true);

-- 5. 注释
COMMENT ON TABLE dishes IS '菜谱数据表（meat=荤菜, veg=素菜）';
COMMENT ON COLUMN dishes.type        IS '荤素类型：meat 或 veg';
COMMENT ON COLUMN dishes."lowFat"   IS '是否减脂菜';
COMMENT ON COLUMN dishes."singleUse" IS '是否单次菜（鱼类只能吃1天）';
COMMENT ON COLUMN dishes.ingredients IS '食材数组，JSON 格式';
COMMENT ON COLUMN dishes.steps       IS '做法步骤数组，JSON 格式';

-- =========================================================
--  执行完后，打开网页，首次加载会自动导入 79 道默认菜谱
-- =========================================================
