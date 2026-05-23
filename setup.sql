-- ========================================
-- 迷宫大冒险 — Supabase 数据库建表脚本
-- 在 Supabase SQL Editor 中粘贴执行
-- ========================================

-- 1. 用户表 — 存储昵称和密码哈希
CREATE TABLE IF NOT EXISTS users (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. 进度表 — 存储每个用户每个关卡的通关次数
CREATE TABLE IF NOT EXISTS progress (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  difficulty TEXT NOT NULL CHECK (difficulty IN ('easy', 'medium', 'hard')),
  level INTEGER NOT NULL CHECK (level BETWEEN 1 AND 5),
  clear_count INTEGER DEFAULT 0,
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, difficulty, level)
);

-- 3. 创建索引加速查询
CREATE INDEX IF NOT EXISTS idx_progress_user_id ON progress(user_id);
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);

-- 4. 启用 Row Level Security
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE progress ENABLE ROW LEVEL SECURITY;

-- 5. users 表策略 — 允许公开注册和查询（儿童游戏，非金融应用）
CREATE POLICY "allow_select_users" ON users FOR SELECT USING (true);
CREATE POLICY "allow_insert_users" ON users FOR INSERT WITH CHECK (true);

-- 6. progress 表策略 — 允许公开读写
CREATE POLICY "allow_select_progress" ON progress FOR SELECT USING (true);
CREATE POLICY "allow_insert_progress" ON progress FOR INSERT WITH CHECK (true);
CREATE POLICY "allow_update_progress" ON progress FOR UPDATE USING (true);
