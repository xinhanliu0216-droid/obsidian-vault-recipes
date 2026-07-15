# 第 3 章：创建第一个 Vault 与 CLAUDE.md

## 1. 不使用终端：下载 Starter Vault

从 [GitHub Releases](https://github.com/xinhanliu0216-droid/obsidian-vault-recipes/releases/latest) 下载 `obsidian-vault-recipes-starter.zip`。解压后直接用 Obsidian 打开，按 `START-HERE.md` 操作。

发布包已经包含页面模板和 `.claude/skills/`，适合 Claude Code 主线。使用其他 Agent 时，按对应工具的项目级 Skills 路径复制这些目录。

## 2. 用脚本生成

在本仓库根目录运行：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/new-vault.ps1 `
  -Destination "D:\Vaults\my-wiki" `
  -VaultName "我的知识库" `
  -Goal "持续整理某个主题的可靠资料" `
  -PrimaryOutput "可追溯的问答与阶段性综合" `
  -Scenario general `
  -IncludeSkills
```

脚本只接受不存在或空的目标目录，不会覆盖已有 Vault。它会生成目录、根 index/log、页面模板，并把所选场景规则合并进 `CLAUDE.md`。不需要项目级 Skills 时省略 `-IncludeSkills`。

## 3. 备选：手工复制

把 [templates/CLAUDE.md](../templates/CLAUDE.md) 复制到 Vault 根目录，并替换三个占位符：

- `{{VAULT_NAME}}`
- `{{VAULT_GOAL}}`
- `{{PRIMARY_OUTPUT}}`
- `{{SCENARIO_RULES}}`

不要先把所有场景规则都塞进去。选择一个主要场景，再从 [场景模板](../templates/scenarios/README.md) 追加差异规则。

## 4. 最小结构

```text
Vault/
├── CLAUDE.md
├── raw/
├── wiki/
│   ├── sources/
│   ├── entities/
│   ├── concepts/
│   ├── topics/
│   └── synthesis/
├── _templates/         ← 可配置为 Obsidian Templates 文件夹
├── index.md
└── log.md
```

`index.md` 和 `log.md` 统一位于 Vault 根目录。场景可以新增目录，但不改变这两个入口的位置。

## 5. 为什么分三层

| 层 | 谁维护 | 是否允许改写 |
|---|---|---|
| `raw/` | 用户提供 | Agent 只读 |
| `wiki/` | Agent 维护、用户复核 | 允许演化 |
| `CLAUDE.md` | 用户与 Agent 共同演化 | 修改前确认 |

## 6. 第一次摄取

先只放一份小资料进 `raw/`，然后输入：

```text
请先读取 CLAUDE.md 和 index.md，再分析 raw/ 中这份资料。
先给我摄取计划：准备创建或更新哪些文件、每个文件的用途是什么。
不要修改文件，等我确认。
```

确认计划后再执行。第一次摄取建议控制在 1–3 个 Wiki 页面，方便观察规则是否合适。

## 7. 摄取完成后检查

- `raw/` 文件没有变化
- Source 页能定位回原文件
- 事实、推断和未知被明确区分
- 新页面至少有一个有意义的 wikilink
- `index.md` 已增加条目
- `log.md` 只追加了一条结构化记录

## 8. 手工添加场景规则

阅读对应场景说明，复制增量规则到 `CLAUDE.md` 的“场景规则”部分：

- [课程](scenarios/3A-course.md)
- [研究](scenarios/3B-research.md)
- [产品](scenarios/3C-product.md)
- [项目](scenarios/3D-project.md)
- [个人](scenarios/3E-personal.md)
- [图书](scenarios/3F-book.md)

跨场景时只选择真正需要的页面类型，并明确冲突规则谁优先。
