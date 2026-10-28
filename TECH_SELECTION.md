# 技术选型文档 - Blue Puffin（步凡）AI跑步助手

## 项目需求分析
- 跨平台：iOS 和 Android
- GPS 跑步记录
- 后台定位（跑步时应用在后台继续记录轨迹）
- 手表数据接入：Coros API（优先），Garmin、Apple Watch（HealthKit）、Polar
- 网络层、存储、本地数据、权限管理
- 路由导航
- AI 能力集成（后续）

## 候选方案对比

| 评估维度 | Flutter | React Native (Bare/Expo) | 原生 (Swift/Kotlin) |
|---|---|---|---|
| 跨平台开发效率 | ★★★★★ 一套代码多平台 | ★★★★☆ 一套代码，部分原生模块需处理 | ★★☆☆☆ 双平台需分别开发 |
| GPS/定位能力 | ★★★★★ geolocator、location等成熟插件，支持后台定位配置完善 | ★★★★☆ react-native-geolocation-service等可用，后台配置需原生适配 | ★★★★★ 完全掌控 |
| 后台定位 | ★★★★★ flutter_background_location等插件支持，需配置权限和前台服务 | ★★★★☆ 需要配置Foreground Service（Android）和Background Modes（iOS），Expo较受限 | ★★★★★ 最佳支持 |
| 手表SDK集成 | ★★★★☆ 可通过MethodChannel集成原生SDK（Coros/Garmin/HealthKit），需原生桥接 | ★★★★☆ 同样需Native Module桥接 | ★★★★★ 直接集成最简单 |
| 性能（地图/GPS追踪） | ★★★★☆ 接近原生，适合长时间后台跑步记录 | ★★★★☆ 中等，复杂场景可能有性能开销 | ★★★★★ 最佳 |
| 社区生态 | ★★★★★ 活跃，插件丰富 | ★★★★★ 非常活跃 | N/A |
| 开发体验 | ★★★★☆ 热重载好，UI一致性强 | ★★★★☆ 热重载好，JS生态熟悉 | ★★★☆☆ 开发效率较低 |
| 学习曲线 | 中等（Dart） | 中等（JS/TS+React） | 较高（双语言） |
| 包体积 | 中等偏大 | 中等 | 较小 |

## 推荐方案：Flutter

### 理由
1. **统一跨平台**：iOS和Android一套代码，符合"跨平台"需求，开发和维护效率高
2. **定位能力成熟**：`geolocator`、`flutter_background_service` 等插件成熟，能满足GPS记录和后台定位需求
3. **原生扩展性强**：通过Platform Channel可轻松集成Coros/Garmin原生SDK，满足手表数据接入需求
4. **性能足够**：对于跑步记录这类长时后台定位场景，Flutter性能足够满足MVP需求
5. **UI一致性好**：能快速搭建统一的用户体验
6. **适合迭代**：团队协作和后续功能扩展都较为顺滑

### 注意事项
- 后台定位需在Android配置`FOREGROUND_SERVICE_LOCATION`和前台服务，iOS需配置`NSLocationAlwaysAndWhenInUseUsageDescription`及Background Modes
- 手表SDK（尤其是Coros）如无Flutter插件需走原生桥接，这是预期工作
- 包体积需关注，但对MVP影响不大

## 技术栈规划
| 模块 | 技术选型 | 说明 |
|---|---|---|
| 框架 | Flutter 3.x (Dart 3.x) | 跨平台UI框架 |
| 状态管理 | Riverpod / Bloc | 推荐Riverpod，简洁且适合中小型应用 |
| 路由 | go_router | 声明式路由，支持深链接 |
| 网络请求 | Dio | 功能完善，拦截器、错误处理等 |
| 本地存储 | Isar / Drift / SharedPreferences | Isar适合结构化数据存储（跑步记录等）；SharedPreferences存储配置 |
| 权限管理 | permission_handler | 统一处理定位、传感器等权限 |
| 定位/GPS | geolocator + flutter_background_service | GPS追踪和后台定位 |
| 地图（可选） | flutter_map / google_maps_flutter | 跑步轨迹展示，MVP可先用轨迹数据展示 |
| 环境配置 | flutter_dotenv | 多环境配置管理 |
| 代码规范 | flutter_lints, very_good_analysis | 统一代码风格 |

## 项目结构设计
```
lib/
├── core/           # 核心基础设施（网络、存储、权限、常量、工具类）
├── features/       # 功能模块（按业务划分：auth, run, plan, profile等）
├── shared/         # 共享组件、主题、通用widget
└── main.dart       # 应用入口
```

## 验收
- [x] 技术选型文档输出并确认（本文档）
