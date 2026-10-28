# 跑步核心功能实现说明

## 功能概述
实现GPS跑步、轨迹、数据记录核心功能。

## 已实现功能
- [x] GPS定位、轨迹记录
- [x] 实时数据（里程、配速、时长）
- [x] 暂停/恢复/结束跑步
- [x] 跑步记录保存（数据模型）
- [x] 权限处理（定位、后台定位）

## 核心模块
- `features/run/domain/entities/` - 跑步记录实体、轨迹点实体
- `features/run/domain/repositories/` - 仓库接口
- `features/run/data/repositories/` - 仓库实现（距离计算、配速计算）
- `features/run/presentation/pages/run_page.dart` - 跑步主界面
- `features/run/presentation/providers/run_provider.dart` - 跑步状态管理
- `core/services/location_service.dart` - 定位服务
- `core/permissions/permission_service.dart` - 权限管理服务

## 验收标准
- ✅ 能发起跑步，正常记录轨迹、里程、时长、配速
- ✅ 暂停恢复正常
- ✅ 跑步结束后能保存记录
