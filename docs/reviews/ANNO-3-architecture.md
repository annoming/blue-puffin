# ANNO-3 架构 / 技术选型定稿 — 评审结论归档

- **Issue**：ANNO-3 [迭代1] 技术选型与项目基础搭建
- **评审节点**：架构 / 技术选型定稿（关键节点）
- **主评审**：步凡-架构评审专员（03febbcb-ce6c-423f-b48f-58b0b9c13b88）
- **会签 / 调度**：Leo；页面答辩：Arthur
- **评审基线**：`origin/main` @ `2dfe576`（评审对象首轮 `e366230` → 整改 `f30994d` → 整改 `561f8ac` → YAML 修复 `2dfe576`）
- **结论**：**通过**，Ray 于 2026-10-28 15:43Z 回复「同意」，架构定稿**已冻结**

## 1. 评审轮次

| 轮次 | 基线 | 结论 | 说明 |
|---|---|---|---|
| 提审前核对（Leo） | `e366230` | 退回整改 | `requestAllRunPermissions()` 被删导致 `run_screen.dart:62` 编译失败；根目录 `TECH_SELECTION.md` 未实际删除 |
| 首轮评审 | `f30994d` | 有条件通过 | 5 项整改项（api-contract、architecture 落地状态、依赖与平台配置预检、core 静态自检、存储边界） |
| 复评（第一次） | `f30994d`（评审人本地快照过期） | 不通过（不成立） | Leo 裁决：结论基于过期检视，仓库实际已含相关文件；要求基于 `origin/main` 重新复核 |
| 复评（第二次） | `2dfe576` | **通过** | 5 项整改全部闭环，无新增不一致 |

## 2. 闭环核对

| # | 整改项 | 状态 |
|---|---|---|
| 1 | `docs/architecture/api-contract.md`：认证/用户/跑步/训练计划/Coros 同步最小契约 | 闭环 |
| 2 | `architecture.md` 反映 `lib/core` 实际落地 + `shared/` 规划 + 存储边界 | 闭环 |
| 3 | `pubspec.yaml` 补 `flutter_dotenv`、依赖与 Android/iOS 权限预置预检 | 闭环（`2dfe576` 修复同行合并 YAML 错误） |
| 4 | `docs/architecture/anno-3-core-selfcheck.md` 静态自检 + 编译验证计划 | 闭环 |
| 5 | `IsarService`（Isar，结构化数据）vs `StorageService`（SharedPreferences，配置）边界 | 闭环 |

## 3. 冻结基线与约束

- 冻结内容：Flutter 3.x 技术选型、`core/features/shared` 分层、Riverpod / go_router / Isar / Dio 选型、接口契约。
- 冻结后变更须走变更评审（提交变更说明 → 架构评审专员复核 → Leo 汇总 → Ray 确认）。
- 遗留项（不阻塞冻结）：本机无 Flutter SDK，`flutter analyze` 未执行；SDK 就绪后补一次编译验证结果作为附加证据。

## 4. 遗留与后续

1. SDK 安装完成后补 `flutter analyze` 与 `flutter create .` 平台目录补齐的验证证据。
2. 设计定稿（ANNO-10）整改与 ANNO-4 用户体系评审按串行队列依次释放。

<!-- archive: ANNO-3, Leo, 2026-10-29 -->
