# 系统架构设计

## 设计原则
- **Feature-first**：按业务模块划分（auth/run/plan/profile 等），高内聚低耦合
- **分层清晰**：core（基础设施）+ features（业务）+ shared（通用组件）
- **可扩展**：预留手表 SDK、AI 能力接入点
- **平台适配**：通过抽象接口封装平台差异（定位、手表、权限）

## 整体分层
```
lib/
├── core/           # 基础设施层（与业务无关）
│   ├── config/     # 环境配置、应用配置
│   ├── network/    # 网络层（Dio封装、拦截器、API定义）
│   ├── storage/    # 本地存储（Isar、SharedPreferences封装）
│   ├── permissions/# 权限管理（定位、后台定位等）
│   ├── routing/    # 路由配置（go_router）
│   └── utils/      # 工具类、常量、扩展
├── features/       # 业务功能层
│   ├── auth/       # 用户认证（Baylor负责）
│   ├── user/       # 用户建档（Baylor负责）
│   ├── run/        # 跑步核心（Frank负责）
│   ├── plan/       # 训练计划
│   └── profile/    # 个人中心
├── shared/         # 共享层
│   ├── widgets/    # 通用组件
│   ├── theme/      # 主题配置
│   └── constants/  # 全局常量
└── main.dart       # 应用入口
```

**与现有 lib/ 对应关系**：当前 `lib/main.dart` 已存在空壳 App，后续需按此结构逐步迁移和扩展。`core/` 目录已预创建，待按模块填充。

## 状态管理（Riverpod）
- **选型**：`flutter_riverpod`
- **使用方式**：Provider/StateNotifierProvider/AsyncNotifierProvider，按需选择
- **原则**：UI 层只消费 Provider，业务逻辑放在 Notifier/Service，数据访问放在 Repository
- **依赖注入**：通过 Riverpod Provider 实现依赖注入，便于测试和替换

## 路由（go_router）
- **选型**：`go_router`
- **配置位置**：`lib/core/routing/`
- **功能**：路由表定义、命名路由、参数传递、路由守卫（登录态等）、深链接预留
- **导航方式**：声明式，统一通过 `context.go`/`context.push`

## 存储（Isar）
- **选型**：`isar` + `isar_flutter_libs`
- **配置位置**：`lib/core/storage/`
- **用途**：跑步记录（轨迹点、里程、时长、配速）、训练计划、用户建档、本地缓存等结构化数据
- **原则**：Repository 封装 Isar 操作，对外暴露领域模型，避免 UI 直接操作 Isar
- **初始化**：应用启动时初始化 Isar 实例，统一管理

**SharedPreferences**：用于轻量配置（首次引导、主题、权限提示状态等），同样通过 `core/storage` 封装。

## 网络层
- **选型**：`Dio`
- **配置位置**：`lib/core/network/`
- **设计**：
  - `dio_client.dart`：Dio 实例配置（超时、基础 URL、日志）
  - `interceptors/`：认证拦截器、错误拦截器、日志拦截器
  - `api/`：API 接口定义（按模块划分）
  - `models/`：网络响应模型（可配合 json_serializable）
- **原则**：统一错误处理、请求/响应日志（开发环境）、Token 管理预留

## 权限管理
- **选型**：`permission_handler`
- **配置位置**：`lib/core/permissions/`
- **需处理权限**：
  - **定位**：`ACCESS_FINE_LOCATION`（Android）、`NSLocationWhenInUseUsageDescription`（iOS）
  - **后台定位**：`ACCESS_BACKGROUND_LOCATION`（Android 10+）、`NSLocationAlwaysAndWhenInUseUsageDescription`（iOS）
  - **前台服务**：`FOREGROUND_SERVICE_LOCATION`（Android，配合后台服务）
- **设计**：权限检查、申请、状态监听，提供权限说明文案和引导逻辑（跑步场景按需申请）

## 后台定位方案
- **Android**：
  - 使用 `flutter_background_service` 创建前台服务，设置通知栏（必需，提升存活率）
  - 配置 `FOREGROUND_SERVICE_TYPE_LOCATION`
  - 申请 `ACCESS_BACKGROUND_LOCATION`（Android 10+），结合 `ACCESS_FINE_LOCATION`
  - 注意 OEM 厂商保活差异，必要时引导用户开启自启动/后台运行权限
- **iOS**：
  - Info.plist 配置 `NSLocationAlwaysAndWhenInUseUsageDescription`、`NSLocationWhenInUseUsageDescription`
  - 开启 Background Modes：`location updates`
  - 使用 `geolocator` 配合后台定位，注意 iOS 对后台定位的严格限制
- **通用**：
  - 仅在跑步开始时启动后台定位，跑步结束时及时停止，减少电量消耗
  - 定位频率需平衡精度与续航
  - 提供清晰的权限说明，避免过早申请敏感权限

## Coros 接入方式
- **优先级**：Coros API（优先） > Garmin > Apple Watch（HealthKit） > Polar
- **接入策略**：原生桥接优先（Platform Channel）
- **设计思路**：
  - 在 `core/` 或 `features/run/data/datasources/` 定义抽象接口 `WatchDataSource`（授权、历史数据拉取、同步状态等）
  - 实现 `CorosDataSource`（MethodChannel 调用 Android/iOS 原生 SDK）
  - 后续扩展 `GarminDataSource`、`HealthKitDataSource` 等，实现同一接口
- **需关注**：
  - Coros 开发者资质与 API 文档获取
  - OAuth/授权流程
  - 历史跑步数据字段映射（时间、距离、配速、轨迹等）
  - 数据同步时机与去重
  - iOS/Android 原生 SDK 集成细节（依赖、权限）

## 模块职责划分
| 模块 | 职责 | 负责人 |
|---|---|---|
| auth/user | 用户体系、建档、登录注册 | Baylor |
| run | 跑步记录、GPS追踪、轨迹、手表同步入口 | Frank |
| plan | 训练计划生成与展示（规则版） | 待定 |
| core/* | 基础设施全量 | Arthur（架构） |

## 注意事项
- 本机暂无 Flutter SDK，无法执行 `flutter analyze`/`flutter run` 验证，需后续在有 SDK 环境下补充编译验证
- `lib/core` 目前仅有目录结构，需按上述设计逐步填充基础实现
- 手表 SDK 集成需原生代码配合，当前仅做架构设计和接口预留

<!-- archive: ANNO-3, Arthur, 2026-10-28 -->

## 更新：与现有 lib/ 对应关系（真实目录）
当前实际目录结构（已存在）：
```
lib/core/
├── api/           # API相关封装
├── config/        # 应用配置
├── di/            # 依赖注入
├── network/       # 网络层（Dio）
├── permissions/   # 权限管理
├── routing/       # 路由配置
├── services/      # 通用服务
├── storage/       # 本地存储（含 isar_service）
└── utils/         # 工具类
```
上文描述的基础设施已按模块落地，后续按需扩展各子模块实现。


## 更新：与现有 lib/ 对应关系（真实目录）及实现状态
当前实际目录结构（已存在）：
```
lib/core/
├── api/           # API相关封装（待实现）
├── config/        # 应用配置（已实现：app_config.dart）
├── di/            # 依赖注入（预留）
├── network/       # 网络层（已实现：dio_client.dart）
├── permissions/   # 权限管理（已实现：permission_service.dart，含向后兼容）
├── routing/       # 路由配置（已实现：app_router.dart）
├── services/      # 通用服务（预留）
├── storage/       # 本地存储（预留 IsarService，已引入 isar 依赖）
├── theme/         # 主题配置（已存在）
└── utils/         # 工具类（已实现：app_logger.dart）
```

### shared/ 规划
```
lib/shared/
├── widgets/       # 通用组件（预留）
├── theme/         # 主题资源（预留）
└── constants/     # 全局常量（预留）
```

**状态标注**：已实现 = config/network/permissions/routing/utils/core.dart；预留 = api/di/services/storage(细化)/shared/*。`IsarService` 与 `StorageService` 边界见下文。

## 存储边界：IsarService vs StorageService
- **StorageService（轻量配置）**：基于 `SharedPreferences`，用于键值对配置（首次引导、主题、权限提示、简单开关等）。位置：`lib/core/storage/storage_service.dart`（封装）。
- **IsarService（结构化数据）**：基于 `Isar`，用于结构化持久化（跑步记录、轨迹点、训练计划、用户建档等）。位置：`lib/core/storage/isar_service.dart`（预留实现）。
- **原则**：严禁混用。配置类用 StorageService，实体数据用 IsarService。两套 API 各司其职，避免双套存储语义混淆。
