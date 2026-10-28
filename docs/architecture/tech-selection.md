# 技术选型 - 决策、理由、风险与备选

## 决策
采用 **Flutter 3.x（Dart 3.x）** 作为跨平台框架，用于实现 iOS 和 Android 双平台应用。

## 理由
| 考量点 | 分析 | 结论 |
|---|---|---|
| 跨平台效率 | 一套代码覆盖双平台，减少人力成本，便于统一迭代 | 符合要求 |
| GPS/定位 | `geolocator`、`flutter_background_service` 等插件成熟，支持前后台定位 | 满足跑步场景 |
| 后台定位 | 可配置 Android 前台服务（FOREGROUND_SERVICE_LOCATION）和 iOS Background Modes（Location updates） | 满足长时间跑步记录 |
| 手表SDK集成 | 通过 MethodChannel 可桥接 Coros/Garmin/HealthKit 原生 SDK，扩展性强 | 满足手表数据接入（优先 Coros） |
| 性能 | 对 GPS 追踪、轨迹记录这类场景性能足够，接近原生体验 | 满足 MVP 需求 |
| 生态与维护 | 插件丰富、文档完善、社区活跃，适合快速迭代 | 利于团队协作 |
| UI 一致性 | Material 3 支持，跨平台视觉体验统一 | 符合产品预期 |

## 风险
| 风险项 | 影响 | 缓解措施 |
|---|---|---|
| 手表原生 SDK 无 Flutter 插件（Coros 首选） | 中高 | 优先评估现有插件，必要时通过 Platform Channel 封装最小可用接口，按需暴露授权、历史数据、实时数据能力 |
| 后台定位合规与体验 | 中高 | 严格遵循平台权限指引，提供清晰权限说明文案，仅在跑步场景申请必要权限，测试真机后台场景 |
| 包体积较大 | 中 | MVP 阶段可接受，后续按需精简资源、使用按需加载等方式优化 |
| 长时间后台服务稳定性（Android OEM 差异） | 中 | 使用成熟的后台服务方案，必要时提供保活说明和用户引导，重点关注主流机型 |
| 真机调试依赖较重 | 中 | 提前准备真机测试环境，优先覆盖定位、后台、手表联动等核心场景 |

## 备选方案
| 方案 | 评估 | 结论 |
|---|---|---|
| React Native（Bare/Expo） | JS 生态熟悉但后台定位、原生 SDK 桥接复杂度较高，Expo 对后台定位限制较多 | 不推荐（MVP 阶段不够顺滑） |
| 原生（Swift/Kotlin） | 性能最优但双平台开发成本翻倍，迭代效率低 | 不推荐（跨平台需求优先） |
| Kotlin Multiplatform / Flutter + Rust（极少数场景） | 成本过高，生态不够成熟，超出 MVP 范围 | 不采用 |

## 技术栈
| 模块 | 选型 | 说明 |
|---|---|---|
| 框架 | Flutter 3.x / Dart 3.x | 跨平台 UI |
| 状态管理 | Riverpod | 类型安全、依赖注入、易于测试 |
| 路由 | go_router | 声明式路由、深链接、守卫 |
| 网络 | Dio | 拦截器、错误处理、请求封装 |
| 本地存储 | Isar + SharedPreferences | Isar 存储结构化数据（跑步记录、计划等），SharedPreferences 存储配置 |
| 权限 | permission_handler | 统一权限申请与状态检查 |
| 定位/GPS | geolocator | GPS 定位、轨迹采集 |
| 后台服务 | flutter_background_service | Android 前台服务 / iOS 后台任务配合定位 |
| 环境配置 | flutter_dotenv | 多环境配置 |
| 代码规范 | flutter_lints / very_good_analysis | 静态检查 |

<!-- archive: ANNO-3, Arthur, 2026-10-28 -->
