# 权限说明

## iOS
在 `ios/Runner/Info.plist` 中需要添加以下权限说明：
- `NSLocationWhenInUseUsageDescription` - 使用应用期间访问位置信息，用于记录跑步轨迹
- `NSLocationAlwaysAndWhenInUseUsageDescription` - 始终访问位置信息，用于后台记录跑步轨迹
- `UIBackgroundModes` 添加 `location` - 支持后台定位

## Android
在 `android/app/src/main/AndroidManifest.xml` 中需要添加以下权限：
- `ACCESS_FINE_LOCATION` - 精确定位
- `ACCESS_COARSE_LOCATION` - 粗略定位
- `ACCESS_BACKGROUND_LOCATION` - 后台定位（Android 10+）
- `FOREGROUND_SERVICE` - 前台服务
- `FOREGROUND_SERVICE_LOCATION` - 前台服务定位（Android 14+）

## 权限处理
应用会在首次开始跑步时请求定位权限，并提示用户授予"始终允许"以获得最佳跑步体验（后台记录轨迹）。
