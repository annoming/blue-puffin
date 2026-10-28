# 04 · 交付标注与资源清单（Handoff）

面向 Flutter 开发（Frank / Baylor），目标：**按本文件 + 页面文档即可实现，不再做视觉决策**。

---

## 1. 交付物索引

| 文件 | 内容 |
|---|---|
| `specs/01-foundations.md` | 色彩 / 字体 / 间距 / 圆角 / 图标 / 动效 / 深浅色 token |
| `specs/02-components.md` | 按钮、卡片、标签、banner、图表、导航、弹层、状态组件 |
| `specs/03-interaction-flows.md` | 导航、跑步状态机、中断恢复、权限、GPS、计划与 Coros 流程、状态矩阵 |
| `specs/app_theme.reference.dart` | 可直接落地的 ThemeData / token 参考代码 |
| `screens/01-run-home.md` | 跑步页 6 状态 + 弱信号 / 后台 / 权限 / 恢复 |
| `screens/02-run-result.md` | 结果页、配速图、分段、分享卡、保存失败 |
| `screens/03-training-plan.md` | 首页今日卡、周视图、任务详情、完成 / 部分完成 / 空错载 |
| `screens/04-profile.md` | 我的、用户信息、历史列表、Coros 全状态 |
| `prototype/index.html` | 跑步页 9 状态静态原型（浏览器打开，可切换深浅色） |
| `prototype/result.html` | 结果页、分享卡、待同步原型 |
| `prototype/plan.html` | 首页、周视图、任务详情、空错载、休息日原型 |
| `prototype/profile.html` | 我的、历史、用户信息、Coros 全流程原型 |
| `assets/README.md` | 图标 / 地图 / 分享卡资源清单与导出规格 |

尺寸口径：设计稿 390×844（@1x），开发按逻辑像素直接取用；导出切图按 @2x/@3x。

---

## 2. 页面与路由清单

| # | 页面 | 路由 | 状态数 | 文档 |
|---|---|---|---|---|
| 1 | 首页 | `/` | 正常 / 完成 / 休息 / 无计划 / 加载 / 失败 / 离线 | screens/03 §1 |
| 2 | 周训练计划 | `/training/plan` | 正常 / 部分完成 / 空 / 加载 / 错误 / 离线 / 重新生成 | screens/03 §2 |
| 3 | 今日训练 | `/training/today` | 复用任务详情或首页卡，本期保留路由 | screens/03 §1 |
| 4 | 任务详情 | `/training/task/:taskId` | 正常 / 完成 / 部分完成 / 休息 / 不存在 / 加载 / 错误 | screens/03 §3 |
| 5 | 跑步页 | `/run` | 空闲 / 定位中 / 跑步中 / 暂停 / 结束 / 保存中 / 保存失败 / 弱信号 / 丢失 / 后台 / 权限拒绝 / 草稿恢复 | screens/01 |
| 6 | 结果页 | `/run/result/:runId`（新增） | 正常 / 加载 / 失败 / 无轨迹 / 待同步 / 数据不足 / 分享 | screens/02 |
| 7 | 我的 | `/profile/me`（新增） | 正常 / 未建档 / 加载 / 错误 / 离线 / Coros 7 态 | screens/04 §1 |
| 8 | 个人信息 | `/user/:userId` | 正常 / 缺失字段 / 加载 / 错误 | screens/04 §2 |
| 9 | 历史记录 | `/run/history` | 正常 / 空 / 加载 / 错误 / 离线 / 待同步 / 删除撤销 | screens/04 §3 |
| 10 | Coros 同步 | `/sync/coros` | 未绑定 / 授权中 / 授权失败 / 已连接 / 同步中 / 成功 / 部分成功 / 失败 / 离线 / 解除绑定 | screens/04 §4 |

新增路由：`/run/result/:runId`、`/profile/me`。其余沿用现有 `app_router.dart`。

---

## 3. 资源清单

### 3.1 图标（自绘 SVG，位于 `design/assets/icons/`）

| 文件 | 尺寸 | 用途 | 导出 |
|---|---|---|---|
| `ic_puffin_logo.svg` | 24×24 | 品牌标、分享卡角标、通知小图标 | 24 / 48 / 72 PNG + 单色 24 |
| `ic_gps_satellite.svg` | 24×24 | GPS 定位中 / 弱信号 | 24 / 48 / 72 |
| `ic_route_empty.svg` | 48×48 | 历史空态、无轨迹 | 48 / 96 / 144 |
| `ic_share_card.svg` | 24×24 | 分享入口 | 24 / 48 / 72 |

- 线宽 2，`stroke-linecap/linejoin: round`，`fill: none`，颜色用 `currentColor`（Flutter 用 `SvgPicture` 着色或转 IconData）。
- 其余图标全部使用 **Material Symbols Rounded**（无需切图），Flutter 通过 `MaterialIcons` / `material_symbols_icons` 包；未引入包时按同义 Material 图标替代，形状差异可接受。

### 3.2 位图 / 地图

| 资源 | 规格 | 说明 |
|---|---|---|
| 地图瓦片 | 浅色：Carto Positron；深色：Carto Dark | 通过 `flutter_map` `TileLayer`；需在设置页加地图版权声明 |
| 底部导航图标 | Material Symbols 24 | home / calendar_month / route / person |
| 分享卡背景 | 纯色 `#071019`，无需图片 | 用 Flutter 绘制，不切图 |
| 空态插画 | 无位图，统一线性图标 48 | 保持包体轻量 |
| App 图标 | 1024×1024 PNG（品牌蓝底 + 白色海鹦轮廓） | 由品牌方后续提供；本期先用占位纯色 |

> 本迭代**不需要**任何 JPG/PNG 插画；若设计评审要求，再补 3 张空态插画（路线、手表、计划）。

### 3.3 字体

- 不内嵌字体文件。使用系统字体 + `fontFamilyFallback`；数字开启 tabular figures。
- 若后续需要统一品牌字，建议「HarmonyOS Sans SC」（开源），但本迭代不引入，避免包体增加。

---

## 4. Flutter 落地映射

### 4.1 主题

- `AppTheme.lightTheme()` / `AppTheme.darkTheme()`，`ColorScheme` 使用 `fromSeed(seedColor: Color(0xFF1463E6))` 后再覆盖关键色，保证 Material 组件一致。
- 间距/圆角/字阶用 `ThemeExtension<AppTokens>`（见参考文件）。
- 跑步页用 `RunTheme.data` 包裹（内含 `RunTokens` 的 `run/*` 全量映射）；进入页面调用 `RunTheme.applySystemUi()`，状态栏/导航栏使用 `SystemUiOverlayStyle.light`；地图/分享卡固定深色。

### 4.2 组件映射

| 设计组件 | Flutter 实现 |
|---|---|
| 主按钮 | `FilledButton` + `FilledButton.styleFrom(minimumSize: Size.fromHeight(52), shape: RoundedRectangleBorder(16))` |
| 次按钮 | `OutlinedButton` 同尺寸 |
| 危险按钮 | `FilledButton` + `backgroundColor: danger` |
| 卡片 | `Container` + `BoxDecoration(border: Border.all(borderSubtle), borderRadius: 16)`，不用 `Card` 默认 elevation |
| 状态胶囊 | `Container` + `BoxDecoration(borderRadius: 999)` + `Text` |
| Banner | 自定义 `InlineBanner`（图标 + 文本 + 可选 action），不直接用 `MaterialBanner`（默认样式不符） |
| 底部弹层 | `showModalBottomSheet(isScrollControlled: true, shape: RoundedRectangleBorder(top: 24))` |
| 骨架 | `shimmer` 自绘或 `AnimatedOpacity` 循环；不引入重库 |
| 下划线 tab | 本迭代无；底部导航用 `NavigationBar` 定制高度 56、`labelBehavior: alwaysShow` |
| 图标 | `Icon(Icons.xxx)`；Material Symbols 通过 `material_symbols_icons`（如允许新增依赖） |

### 4.3 关键实现约束

1. **跑步页面禁止每秒整页 setState**：计时/里程用 `ValueNotifier` + `ValueListenableBuilder`。
2. **长按结束 800ms** + 进度环；不得用单击直接结束。
3. **定位权限**只在使用时申请；拒绝后可去设置恢复，不得崩溃或白屏。
4. **本地优先**：跑步记录先写 Isar（含 `syncStatus`），再上传；保存失败不丢数据。
5. **草稿恢复**：启动检查 `run_draft`，24h 内允许继续，超时只允许保存/放弃。
6. **分享卡导出** 1080×1440，`RepaintBoundary` + `pixelRatio = 3`；导出前确保轨迹绘制完成。
7. **深色模式**：所有页面用语义色，禁止业务层写死 hex；分享卡/跑步中例外。
8. **文案** 全部以本设计稿为准，不自行增删感叹号或营销语。

---

## 5. 标注规则（给后续走查用）

- 红色标注线不进入实现；本文档的「距上/距左/高/宽」即为实现值。
- 所有点击热区 ≥ 48×48；视觉尺寸小于 48 的（如 20 图标）用 `InkWell` + `padding` 扩大。
- 列表分割线统一「左侧缩进 56」；卡片内分割线缩进 16。
- 页面左右边距固定 16，任何新模块不得改成 20/24。
- 所有数字格式遵循 01 §3.3；异常值 `--`。
- 新增状态必须先补本目录文档，再实现。

---

## 6. 可访问性与性能

| 项 | 要求 |
|---|---|
| 对比度 | 正文 ≥ 4.5:1，大数字 ≥ 3:1；warning/danger 文字不叠加在图片上 |
| 动态字号 | 支持 1.3×；跑步中数字上限 1.15× |
| Semantics | 所有图标按钮、状态点、图表有语义标签（如「暂停跑步」「GPS 信号弱」） |
| 触觉 | 开始/暂停/结束/同步成功 mediumImpact；GPS 丢失 heavyImpact 一次 |
| 帧率 | 跑步页 ≥ 50fps；轨迹抽稀 ≤ 2000 点；地图不随数字刷新重建 |
| 启动 | 冷启动到首页 ≤ 2s（有缓存）；骨架不超过 1 个网络往返 |
| 电量 | 跑步中定位 `LocationAccuracy.high`，距离过滤 5m，后台使用前台服务 |

---

## 7. 验收清单（设计交付）

- [x] 色彩 / 字体 / 间距 / 圆角 / 图标 / 深浅色规则成套，并映射到 Flutter token
- [x] 跑步页：空闲、定位中、跑步中、暂停、结束、保存失败、GPS 弱/丢失、后台、权限拒绝、草稿恢复
- [x] 结果页：轨迹、配速曲线、分段、分享卡、无轨迹、待同步、加载失败
- [x] 训练计划：今日卡、周视图、任务详情、完成 / 部分完成、休息日、空 / 错 / 载 / 离线
- [x] 我的：用户信息、历史列表、Coros 未绑定 / 授权中 / 授权失败 / 已连接 / 同步中 / 失败 / 解绑
- [x] 交互：跳转返回、中断恢复、权限、空态/错误态/加载态
- [x] 切图与标注：尺寸、资源、导出规格、Flutter 映射
- [ ] 设计评审（ANNO-11）：待评审
- [ ] Ray 确认设计冻结：待确认

---

## 8. 评审需确认的 5 个决策

1. **恒暗运动模式**：跑步中固定深色（强光可读 + 省电），不跟随系统浅色。
2. **4 tab 导航**：首页 / 训练 / 记录 / 我的；跑步流程全屏，不占 tab。
3. **结束需长按 800ms**，防误触；单手可达。
4. **今日卡点击进详情，不直接开跑**；开始跑步由卡片下方主 CTA 承担，避免误触。
5. **不做手动编辑计划**、不做 AI 调整入口（本迭代范围外）。
