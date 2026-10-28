# 设计资源清单（Assets）

本目录只存放**必须自绘**的资源。其余图标使用 Material Symbols Rounded，地图使用在线瓦片，不进入仓库。

## 1. 目录

```
assets/
  icons/
    ic_puffin_logo.svg      24×24  品牌标 / 分享卡角标 / 通知
    ic_gps_satellite.svg    24×24  GPS 定位中 / 弱信号
    ic_route_empty.svg      48×48  历史空态 / 无轨迹
    ic_share_card.svg       24×24  分享入口
  README.md
```

## 2. 导出规格

| 资源 | @1x | @2x | @3x | 备注 |
|---|---|---|---|---|
| `ic_puffin_logo` | 24 | 48 | 72 | 另导出单色白 `#FFFFFF` 24px 版用于深色分享卡 |
| `ic_gps_satellite` | 24 | 48 | 72 | 着色 `#1463E6` / 深色 `#6FA6FF` |
| `ic_route_empty` | 48 | 96 | 144 | 着色 `--text3`（浅 `#8494A6` / 深 `#8A9AAB`） |
| `ic_share_card` | 24 | 48 | 72 | 着色随按钮前景色 |

- SVG 使用 `currentColor`、`fill="none"`、线宽 2、圆头圆角；导入 Flutter 后用 `SvgPicture.asset(..., colorFilter: ...)` 着色。
- 导出 PNG 时背景透明，留 0 边距；不使用阴影与渐变。
- 4 个文件同时作为 Figma 组件的源文件，尺寸与上表一致。

## 3. 其他资源

| 资源 | 规格 | 说明 |
|---|---|---|
| 地图瓦片 | 浅色 Carto Positron；深色 Carto Dark | `flutter_map` `TileLayer`，需在地图右下角展示版权与 attribution |
| 底部导航图标 | Material Symbols 24 | `home` / `calendar_month` / `route` / `person` |
| 分享卡背景 | `#071019` 纯色 | Flutter 直接绘制，不切图；品牌角标用 `ic_puffin_logo` 单色版 |
| 空态插画 | 无位图 | 统一用 48px 线性图标，控制包体 |
| App 图标 | 1024×1024 PNG | 品牌蓝 `#1463E6` 底 + 白色海鹦轮廓，后续由品牌方提供；当前用纯色占位 |

## 4. 导出检查

- [ ] 尺寸与上表一致，@2x/@3x 为整数倍
- [ ] 背景透明、无裁切、无投影
- [ ] 深浅色下前景对比度 ≥ 3:1（图标）
- [ ] Flutter 侧不使用图片拉伸，按逻辑像素等比缩放

## 5. 待品牌方输入

App 图标最终稿（1024×1024）与品牌字体授权。**不阻塞本迭代开发**：先用上述纯色占位与系统字体。
