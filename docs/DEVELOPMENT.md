# 开发规范

## 代码规范
- 遵循 [Effective Dart](https://dart.dev/guides/language/effective-dart) 规范
- 使用 `flutter_lints` 进行静态检查
- 文件命名使用 snake_case
- 类名使用 PascalCase
- 变量、方法使用 camelCase

## 目录规范
- `core/` - 与业务无关的基础设施（网络、存储、路由、权限、工具等）
- `features/` - 按业务功能划分，每个feature包含 `data/`、`domain/`、`presentation/`
- `shared/` - 可复用的UI组件、主题、常量等

## Git规范
- 分支命名：`feature/xxx`、`fix/xxx`、`refactor/xxx`
- 提交信息简洁明了，描述做了什么

## 权限说明
- iOS: `NSLocationWhenInUseUsageDescription`, `NSLocationAlwaysAndWhenInUseUsageDescription`
- Android: `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`, `ACCESS_BACKGROUND_LOCATION`, `FOREGROUND_SERVICE_LOCATION`

## 环境配置
使用 `.env` 文件管理环境变量，不要提交到仓库。
