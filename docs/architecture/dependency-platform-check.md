# 依赖与平台配置预检清单

## pubspec.yaml 依赖确认
| 依赖 | 用途 | 状态 |
|---|---|---|
| flutter_dotenv ^5.1.0 | 环境配置 | 已补充 |
| flutter_background_service ^5.0.5 | 后台服务（Android前台服务） | 已存在 |
| geolocator ^10.1.0 | GPS定位 | 已存在 |
| permission_handler ^11.1.0 | 权限管理 | 已存在 |
| isar ^3.1.0+1 / isar_flutter_libs ^3.1.0+1 / isar_generator ^3.1.0+1 | 本地结构化存储 | 已存在 |
| dio ^5.4.0 | 网络请求 | 已存在 |
| flutter_riverpod ^2.4.9 | 状态管理 | 已存在 |
| go_router ^12.1.3 | 路由 | 已存在 |
| shared_preferences ^2.2.2 | 轻量存储 | 已存在 |

## Android 平台配置预置清单
需在 `android/app/src/main/AndroidManifest.xml` 预置（后续通过 `flutter create .` 生成后补充）：
- [ ] `ACCESS_FINE_LOCATION`
- [ ] `ACCESS_COARSE_LOCATION`
- [ ] `ACCESS_BACKGROUND_LOCATION`（Android 10+）
- [ ] `FOREGROUND_SERVICE`
- [ ] `FOREGROUND_SERVICE_LOCATION`
- [ ] `POST_NOTIFICATIONS`（Android 13+，如需通知栏）

## iOS 平台配置预置清单
需在 `ios/Runner/Info.plist` 预置：
- [ ] `NSLocationWhenInUseUsageDescription`
- [ ] `NSLocationAlwaysAndWhenInUseUsageDescription`
- [ ] `NSLocationAlwaysUsageDescription`（视情况）
- [ ] Background Modes: `location updates`

## 平台目录说明
- 仓库当前缺少 `android/`、`ios/` 平台目录。需使用 `flutter create .` 补齐平台工程文件（会生成必要配置模板）。
- 建议保留 `.gitignore` 中的平台生成文件规则，避免提交冗余构建产物。

<!-- archive: ANNO-3, Arthur, 2026-10-28 -->
