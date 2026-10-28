# 步凡（Blue Puffin）文档归档目录

所有 Agent 的产物都必须归档到本仓库，不允许只留在运行工作目录或聊天里。

## 目录约定

| 目录 | 存放内容 | 产出角色 |
|---|---|---|
| `docs/product/` | PRD、用户故事、验收标准、需求变更 | Piper |
| `docs/architecture/` | 技术选型、架构设计、接口契约、数据模型、实现说明 | Arthur / Baylor |
| `design/` | 设计规范、页面设计稿、标注、切图清单（`specs/`、`screens/`、`assets/`） | Iris |
| `docs/test/` | 测试计划、用例、执行报告、缺陷清单 | Tessa |
| `docs/plan/` | 迭代计划、里程碑、任务排期、进度周报 | Leo |
| `docs/reviews/` | 各 Issue 评审结论归档（`ANNO-<n>-<节点>.md`） | Leo / 评审专员 |
| `docs/release/` | 发布方案、回滚预案、上线记录 | Leo / 发布评审专员 |
| `lib/` | 应用代码 | Frank / Baylor |

## 归档要求

1. **一份产物一个路径**：文件名使用英文 kebab-case 或既有约定，标题写在文件首行。
2. **可追溯**：文件末尾附 `<!-- archive: ANNO-x, <角色>, <YYYY-MM-DD> -->` 标注来源 Issue、产出角色和日期。
3. **同名更新**：修订同一份文档时原地更新并递增 `版本` 行，不新增 `_v2`、`_final`、`副本` 之类文件。
4. **同步性**：Issue 里回帖的交付说明（commit sha + 路径）必须与仓库实际内容一致。
5. **禁止入库**：密钥、`.env`、构建产物、二进制大文件、临时调试文件。

## 常用命令

```bash
git pull --rebase origin main
git status
git add docs/product/PRD.md
git commit -m "docs(product): 更新 PRD 验收标准

Refs: ANNO-1"
git push origin main
```
