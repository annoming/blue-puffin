# API Contract（最小契约）

## 通用约定
- Base URL: 通过环境配置（`core/config/app_config.dart`）
- 鉴权：Bearer Token（预留，后续接入）
- Content-Type: `application/json`
- 错误码：统一错误结构（code/message/data）

## 1. 认证（auth）
| 接口 | 方法 | 路径 | 说明 | 字段 |
|---|---|---|---|---|
| 登录 | POST | `/auth/login` | 手机/邮箱登录（预留） | req: {phone/email, code/password} resp: {token, user} |
| 注册 | POST | `/auth/register` | 用户注册 | req: {phone/email, password} resp: {token, user} |
| 刷新token | POST | `/auth/refresh` | 刷新令牌 | req: {refreshToken} resp: {token} |

## 2. 用户（user）
| 接口 | 方法 | 路径 | 说明 | 字段 |
|---|---|---|---|---|
| 建档 | POST | `/user/profile` | 用户建档信息提交 | req: {name, age, gender, goal, experience, weeklyDays, pb...} resp: {profile} |
| 获取用户信息 | GET | `/user/me` | 获取当前用户信息 | resp: {user, profile} |
| 更新建档 | PUT | `/user/profile` | 更新建档信息 | req: {...} resp: {profile} |

## 3. 跑步（run）
| 接口 | 方法 | 路径 | 说明 | 字段 |
|---|---|---|---|---|
| 创建跑步记录 | POST | `/run/records` | 上传跑步记录 | req: {startTime, endTime, distance, duration, pace, points:[{lat,lng,alt,time}]} resp: {id} |
| 获取跑步记录列表 | GET | `/run/records` | 分页查询 | query: {page,size} resp: {items,total} |
| 获取跑步详情 | GET | `/run/records/:id` | 获取详情含轨迹 | resp: {record, points} |

## 4. 训练计划（plan）
| 接口 | 方法 | 路径 | 说明 | 字段 |
|---|---|---|---|---|
| 生成训练计划 | POST | `/plan/generate` | 基于建档+历史生成计划（规则版） | req: {profileId, historySummary} resp: {planId, weeks:[...]} |
| 获取训练计划 | GET | `/plan/current` | 获取当前周训练计划 | resp: {plan, tasks:[{day,type,distance,pace,target}]} |
| 更新任务状态 | PUT | `/plan/tasks/:id` | 标记完成/跳过 | req: {status} resp: {task} |

## 5. Coros 同步（coros）
| 接口 | 方法 | 路径 | 说明 | 字段 |
|---|---|---|---|---|
| 授权绑定 | POST | `/coros/auth` | 获取授权链接或交换token（预留） | req: {code} resp: {connected:true} |
| 同步历史数据 | POST | `/coros/sync` | 拉取历史跑步记录 | req: {from,to} resp: {syncedCount, records:[...]} |
| 同步状态 | GET | `/coros/status` | 查询绑定状态 | resp: {connected, lastSyncAt} |

## 错误码（最小集）
| code | 说明 |
|---|---|
| 401 | 未授权/Token过期 |
| 403 | 无权限 |
| 400 | 参数错误 |
| 404 | 资源不存在 |
| 500 | 服务器错误 |

<!-- archive: ANNO-3, Arthur, 2026-10-28 -->
