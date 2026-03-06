# 步凡 Blue Puffin — AI 智能跑步助手

基于 [Blue Puffin 品牌草案](./blue-puffin-品牌草案.md) 的跨平台跑步助手 APP 框架，支持 **Android** 与 **iPhone**，AI 当前接入智谱 **GLM-4-Flash**，后续可扩展其他大模型。

## 品牌与定位

- **Slogan**：步凡，与你同行 / Run with Blue Puffin  
- **定位**：AI 智能跑步助手，小海鹦拟人化陪跑  
- **核心功能（规划）**：AI 配速与训练指导、语音跑步提醒、成就徽章、跑步排行榜  

## 技术栈

- **框架**：React Native + **Expo SDK 54**（支持 Android / iOS，与 Expo Go 54 匹配）
- **路由**：Expo Router（文件式路由）
- **AI**：智谱 GLM-4-Flash（免费），接口抽象便于后续接入 OpenAI、通义等

## 项目结构

```
blue-puffin/
├── app/                    # Expo Router 页面
│   ├── _layout.tsx         # 根布局
│   ├── (tabs)/             # 底部 Tab
│   │   ├── index.tsx       # 首页
│   │   ├── run.tsx         # 跑步
│   │   ├── achievements.tsx# 成就
│   │   └── profile.tsx     # 我的
│   └── settings.tsx        # 设置（含后续 AI 配置）
├── src/
│   ├── theme/              # 品牌主题（蓝 #1DA1F2 / 橙 #FF9F00）
│   ├── components/         # 通用组件（如 PuffinAvatar）
│   ├── services/
│   │   └── ai/             # AI 服务：类型、智谱实现、工厂（可扩展）
│   └── config/             # 环境与配置
├── assets/                 # 图标、启动图（需自行添加 icon.png / splash.png）
├── .env.example
└── package.json
```

## 快速开始

### 1. 安装依赖

```bash
cd blue-puffin
npm install
```

### 2. 配置智谱 API Key

- 在 [智谱开放平台](https://open.bigmodel.cn) 注册并创建 API Key（GLM-4-Flash 有免费额度）。
- 复制 `.env.example` 为 `.env`，填写：

```bash
cp .env.example .env
# 编辑 .env，填入 EXPO_PUBLIC_ZHIPU_API_KEY=你的key
```

或通过 `app.config.js` 的 `extra` 注入（勿将 key 提交到仓库）。

### 3. 运行

```bash
# 开发服务器
npm start

# Android 模拟器/真机
npm run android

# iOS 模拟器（需 macOS + Xcode）
npm run ios
```

### 4. 资源文件

在 `assets/` 下放置：

- `icon.png` — 应用图标（建议 1024×1024）
- `splash.png` — 启动图
- `adaptive-icon.png` — Android 自适应图标前景

未放置时构建可能报错，可先用任意同尺寸图片占位。

## AI 模块说明

- **当前**：`src/services/ai/zhipuGLMService.ts` 调用智谱 `glm-4-flash`。
- **接口**：`IAIService`（`chat(options)`），便于后续换模型或加流式输出。
- **扩展**：在 `AIServiceFactory.ts` 中增加 `openai` 等分支，实现对应 Service 即可。

## 后续可开发功能

- 跑步页：GPS 轨迹、配速、AI 语音提醒与配速建议  
- 成就页：徽章、排行榜、分享  
- 设置页：API Key 配置、切换大模型  
- 小海鹦 IP：Lottie/动效、不同情绪与庆祝动效  

## 许可证

Private / 按项目约定。
