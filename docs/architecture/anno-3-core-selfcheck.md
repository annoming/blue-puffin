# ANNO-3 核心自检清单

## 静态自检
- [x] 技术选型文档已定稿（docs/architecture/tech-selection.md）
- [x] 架构设计文档已更新（docs/architecture/architecture.md）
- [x] API契约文档已补充（docs/architecture/api-contract.md）
- [x] 依赖与平台配置预检已完成（docs/architecture/dependency-platform-check.md）
- [x] lib/core 基础设施已搭建（config/network/permissions/routing/utils/core.dart）
- [x] 权限服务向后兼容（requestAllRunPermissions 等）
- [x] 存储边界已明确（IsarService vs StorageService）
- [x] 根目录 TECH_SELECTION.md 已删除并迁入 docs/architecture/
- [x] pubspec.yaml 补充 flutter_dotenv
- [x] 无 TODO/占位标记

## 编译验证计划
**环境**：当前本机无 Flutter SDK，无法执行编译验证。

**验证时机**：在有 Flutter SDK 的环境（CI 或开发机）执行：
1. `flutter pub get`
2. `flutter create .`（如缺少 android/ios 目录）
3. `flutter analyze`
4. `flutter build apk --debug`（或 `flutter run` 真机）

**已知风险**：
- 缺少 android/ios 平台目录，需先生成
- flutter_dotenv 依赖已补充，但需确保 .env 文件存在（已在 .gitignore）
- 后台定位需真机测试验证
- Coros 原生 SDK 集成需后续原生适配

<!-- archive: ANNO-3, Arthur, 2026-10-28 -->
