# 迷宫大冒险 🐰🐒🐱

儿童益智迷宫游戏 — 5-7 岁儿童专属，通过划线帮助小动物找到食物！

## 功能

- 3 个难度等级，共 15 个关卡
- 触控划线交互（手机/平板）
- 多用户登录（昵称 + 密码）
- 云端进度同步（Supabase）
- 通关庆祝动画（粒子撒花）
- 本地离线模式（无需后端也能玩）

## 技术栈

- 纯 HTML/CSS/JS，零框架依赖
- Supabase 后端（PostgreSQL）
- GitHub Pages 部署
- Canvas 迷宫渲染

## 快速开始

### 1. 部署前端到 GitHub Pages

1. Fork / Clone 本仓库
2. 修改 `index.html` 中的 Supabase 配置（第 15-16 行附近）：
   ```js
   const SUPABASE_URL = 'https://xxxxx.supabase.co';  // 你的 Supabase URL
   const SUPABASE_KEY = 'eyJhbG...';                    // 你的 anon key
   ```
3. Push 到 GitHub
4. 在仓库 Settings > Pages 中启用 GitHub Pages
5. 选择 `main` 分支，根目录 `/`，保存

### 2. 配置 Supabase 后端

1. [注册 Supabase](https://supabase.com) 并创建项目
2. 进入 SQL Editor
3. 粘贴 `setup.sql` 的内容并执行
4. 在 Settings > API 中获取 Project URL 和 anon key
5. 填入 `index.html` 的 `SUPABASE_URL` 和 `SUPABASE_KEY`

### 3. 本地运行

直接双击 `index.html` 即可在浏览器打开。

如果不配置 Supabase，游戏自动回退到本地模式（进度存储在浏览器本地）。

## 项目结构

```
migong/
├── index.html    # 主游戏文件（自包含）
├── setup.sql     # Supabase 数据库建表脚本
└── README.md     # 本文件
```

## 数据库表结构

### users 表

| 字段 | 类型 | 说明 |
|------|------|------|
| id | UUID | 主键 |
| username | TEXT | 昵称（唯一） |
| password_hash | TEXT | SHA-256 密码哈希 |
| created_at | TIMESTAMPTZ | 注册时间 |

### progress 表

| 字段 | 类型 | 说明 |
|------|------|------|
| id | UUID | 主键 |
| user_id | UUID | 外键 → users.id |
| difficulty | TEXT | 难度（easy/medium/hard） |
| level | INTEGER | 关卡编号（1-5） |
| clear_count | INTEGER | 通关次数 |
| updated_at | TIMESTAMPTZ | 更新时间 |
