# 步凡 · 迭代 1 设计交付

本目录是 ANNO-10 的完整设计交付：规范、逐页标注、可交互静态原型与切图。所有尺寸以 **390×844（@1x）** 为基准，Android 360×800 等比适配。

## 快速入口

| 内容 | 路径 |
|---|---|
| 设计基础（色彩 / 字阶 / 间距 / 圆角 / 图标 / 深浅色） | `specs/01-foundations.md` |
| 组件规范与状态 | `specs/02-components.md` |
| 交互流程、状态机、异常与权限 | `specs/03-interaction-flows.md` |
| 交付索引、路由、资源与 Flutter 映射 | `specs/04-handoff.md` |
| Flutter 主题参考实现 | `specs/app_theme.reference.dart` |
| 跑步页标注 | `screens/01-run-home.md` |
| 跑步结果标注 | `screens/02-run-result.md` |
| 训练计划标注 | `screens/03-training-plan.md` |
| 我的 / 历史 / Coros 标注 | `screens/04-profile.md` |
| 静态原型（浏览器打开） | `prototype/index.html` |
| 原型样式与脚本 | `prototype/styles.css`、`prototype/app.js` |
| 切图与资源清单 | `assets/README.md`、`assets/icons/` |

## 原型

直接用浏览器打开 `prototype/index.html`，右上角可切换深浅色（记忆在 localStorage）。页面间通过顶部导航切换：

- `index.html` — 跑步页 9 个状态
- `result.html` — 结果 / 分享卡 / 待同步
- `plan.html` — 首页 / 周视图 / 任务详情 / 空错载 / 休息日
- `profile.html` — 我的 / 历史 / 用户信息 / Coros 全流程

原型为纯静态 HTML/CSS，不含业务逻辑；交互以 `specs/03-interaction-flows.md` 为准。

## 设计决策（需评审确认）

1. 跑步中恒用暗色运动模式，不跟随系统主题。
2. 结束跑步需长按 800ms，避免误触。
3. 首页今日任务卡点击进入详情，不在卡片内直接开跑；主 CTA 为「开始跑步」。
4. 本迭代计划只读：不做手动编辑、不做 AI 调整入口。
5. 新增路由 `/run/result/:runId` 与 `/profile/me`。

## 范围

对齐 PRD 与迭代 1 排期：跑步记录与 Coros 同步、规则版训练计划、训练执行关联、用户建档。不包含 AI 伙伴、营养、社交、虚拟赛事等后续功能。
