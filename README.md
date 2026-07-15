# Obsidian Vault Recipes

[![Validate repository](https://github.com/xinhanliu0216-droid/obsidian-vault-recipes/actions/workflows/validate.yml/badge.svg)](https://github.com/xinhanliu0216-droid/obsidian-vault-recipes/actions/workflows/validate.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-2ea44f.svg)](LICENSE)
[![Obsidian](https://img.shields.io/badge/Obsidian-7C3AED?logo=obsidian&logoColor=white)](https://obsidian.md/)
[![Agent Skills](https://img.shields.io/badge/Agent_Skills-9-2563eb)](skills/README.md)

**把 Obsidian 变成 AI Agent 能持续维护、结论可追溯的本地 LLM Wiki。**

*A tested Obsidian + Claudian recipe kit for traceable local LLM Wikis, built with CLAUDE.md and Agent Skills.*

这是一套面向中文用户的 Obsidian + Claudian 实践仓库：包含可直接使用的 `CLAUDE.md`、9 个 Agent Skills、6 类场景规则、完整示例和自动测试。它基于 Karpathy 的 LLM Wiki 思路，但不要求你把所有知识库塞进同一份巨型模板。

> `raw/` 永远是只读来源层。批量写入、覆盖、删除和规则变更，都必须先展示计划与目标文件，再由用户确认。

## 先理解这条知识流水线

```text
原始资料 raw/ → Source 来源页 → Concept / Entity / Topic → Synthesis 综合页 → 查询与维护
```

- **Raw** 保存原文，不承担解释职责。
- **Source** 忠实记录一份来源说了什么，并保留定位信息。
- **Concept / Entity / Topic** 把可复用知识从单一来源中分离出来。
- **Synthesis** 比较至少两个独立来源，明确支持证据、冲突和未知。
- **诊断与巡检** 发现断链、孤立页、重复、过期结论和未核实内容。

AI 是受规则约束的知识加工员，不是最终权威。用户负责目标、重要写入和结论判断。页面类型难以判断时，先看 [知识对象与建页决策](docs/knowledge-model.md)。

## 快速开始

### 不想用终端

从 [最新 Release](https://github.com/xinhanliu0216-droid/obsidian-vault-recipes/releases/latest) 下载 `obsidian-vault-recipes-starter.zip`，解压后直接用 Obsidian 打开。压缩包内的 `START-HERE.md` 会带你完成第一次摄取。

Starter Vault 由发布工作流自动生成，已包含页面模板和 `.claude/skills/` 下的 9 个 Skills，不混入测试、贡献指南或仓库维护文件。

### 用脚本选择场景

需要 Obsidian、Claudian 支持的一个本地 Agent，以及 Windows PowerShell 或跨平台 PowerShell 7。第一次安装请先看 [完整安装教程](docs/README.md)。

```powershell
git clone https://github.com/xinhanliu0216-droid/obsidian-vault-recipes.git
cd obsidian-vault-recipes

powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/new-vault.ps1 `
  -Destination "D:\Vaults\my-course" `
  -VaultName "统计学课程库" `
  -Goal "整理课程资料并支持期末复习" `
  -PrimaryOutput "概念解释、主动回忆题和错题复盘" `
  -Scenario course
```

然后用 Obsidian 打开 `D:\Vaults\my-course`，在 Claudian 中让 Agent 检查 Vault 状态。初始化脚本只写入不存在或为空的目录，不会覆盖已有知识库。

生成结果：

```text
my-course/
├── CLAUDE.md          # Agent 的长期规则与权限边界
├── raw/               # 原始资料，只读
├── wiki/
│   ├── sources/       # 来源页
│   ├── entities/      # 人物、组织、对象
│   ├── concepts/      # 概念
│   ├── topics/        # 主题与问题
│   └── synthesis/     # 跨来源综合
├── _templates/        # Obsidian 页面模板
├── index.md           # 内容索引
└── log.md             # 追加式操作记录
```

想先看成品，可以浏览三个不同侧重点的结果：

- [课程示例](examples/course-demo/README.md)：Source、Concept 与主动回忆题
- [研究示例](examples/research-demo/README.md)：两份结果不同的材料如何控制结论强度
- [项目示例](examples/project-demo/README.md)：会议、Decision、Task 与 Risk 如何分开

## 仓库提供什么

| 模块 | 解决的问题 | 入口 |
|---|---|---|
| 安装教程 | 从终端、Obsidian 到 Claudian 的完整配置 | [docs/](docs/README.md) |
| 通用规则 | 规定来源、证据、写入权限和页面职责 | [templates/CLAUDE.md](templates/CLAUDE.md) |
| 场景覆盖层 | 只增加领域差异，避免复制整份规则 | [templates/scenarios/](templates/scenarios/README.md) |
| Agent Skills | 摄取、构建、查询、巡检和诊断等工作流 | [skills/](skills/README.md) |
| 页面模板 | Source、Concept、Entity、Topic、Synthesis | [templates/pages/](templates/pages/) |
| 可运行示例 | 从原始资料到 Wiki 页面、索引和日志 | [examples/](examples/README.md) |
| 测试 | 静态检查、初始化烟雾测试和行为验收案例 | [tests/](tests/README.md) |
| 知识模型 | 判断何时建 Source、Concept、Topic 或 Synthesis | [知识对象与建页决策](docs/knowledge-model.md) |
| 安全实践 | 敏感资料、联网、共享与 Git 提交检查 | [隐私与安全实践](docs/privacy-and-security.md) |
| 失败案例 | 学习如何发现并修复重复、断链和越界综合 | [失败与修复示例](examples/failure-recovery/README.md) |

## 六类场景，一套通用核心

| 场景 | 重点产物 | 教程 |
|---|---|---|
| 课程学习 | 概念、例题、主动回忆题、错题复盘 | [课程](docs/scenarios/3A-course.md) |
| 学术研究 | 文献来源、主张、方法、证据冲突 | [研究](docs/scenarios/3B-research.md) |
| 产品分析 | 用户问题、功能、指标、决策依据 | [产品](docs/scenarios/3C-product.md) |
| 项目管理 | 决策、里程碑、风险、行动项 | [项目](docs/scenarios/3D-project.md) |
| 个人成长 | 目标、习惯、复盘、证据边界 | [个人](docs/scenarios/3E-personal.md) |
| 图书与长材料 | 章节、论点、概念和跨章节综合 | [图书](docs/scenarios/3F-book.md) |

不确定选哪一个时使用 `general`。场景规则只是覆盖层，之后可以替换；原始来源和通用目录不需要迁移。

## 为什么这样设计

普通 Obsidian 模板解决“笔记放在哪里”，这套配方还约束 Agent “何时能写、依据是什么、怎样发现失败”。

- **来源不可变**：Agent 只读 `raw/`，修正通过新增来源或 Wiki 注释完成。
- **结论可追溯**：重要事实链接回 Source 页，Source 页记录原文件位置。
- **规则按需加载**：稳定约束放 `CLAUDE.md`，多步骤流程放 Skill。
- **先建议后写入**：批量操作先给出计划，得到确认再执行。
- **规则可以测试**：每类场景都有可观察的成功标准和反例。

它不是向量数据库或 RAG 服务，也不替代全文搜索。它解决的是更靠前的一层：让本地 Markdown 的结构、证据和维护行为长期保持一致。

## 安装 Agent Skills

```powershell
./skills/install-skills.ps1
```

默认安装到 `~/.claude/skills/`。也可以指定项目目录；完整说明见 [Skills 使用指南](skills/README.md)。

## 文档路线

1. [安装 Claude Code](docs/01-install-claude-code.md)
2. [安装 Obsidian 与 Claudian](docs/02-install-obsidian-and-claudian.md)
3. [创建第一个 Vault 与 CLAUDE.md](docs/03-create-vault-and-claude-md.md)
4. [修改和演化 CLAUDE.md](docs/04-modify-claude-md.md)
5. [测试与维护](docs/05-test-and-maintain.md)
6. [Karpathy LLM Wiki 中文导读](templates/karpathy的wiki方法论.md)

## 兼容性与边界

- 本仓库以 Obsidian、Claudian 和 Claude Code 为主线。
- Claudian 也可连接 Codex、OpenCode、Pi 等提供方；具体能力以各项目当前文档为准。
- `skills/` 遵循标准 Agent Skills 目录结构，可被其他兼容工具复用。
- Windows 可以直接使用系统 PowerShell；macOS/Linux 安装 PowerShell 7 后运行同一脚本，也可以下载 Starter Vault。
- 所有资料默认保留在本地。是否向模型服务发送内容，取决于你选择的 Agent 和提供方。

## 参与项目

发现安装问题、规则漏洞或新的使用场景，欢迎提交 Issue。准备修改前请先阅读 [贡献指南](CONTRIBUTING.md)；涉及安全问题时请按 [安全策略](SECURITY.md) 私下报告。

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/validate-repo.ps1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/test-new-vault.ps1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/test-install-skills.ps1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/test-build-starter.ps1
```

后续会继续补充真实失败案例和多 Agent 行为评测；没有实测证据的兼容性不会提前承诺。完整版本记录见 [CHANGELOG.md](CHANGELOG.md)。

如果这套配方帮你少踩了一个坑，欢迎点一个 Star；更有价值的是把你遇到的失败案例提交回来，让规则能被真正检验。

## 来源、归属与许可

- [Karpathy：LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
- [Obsidian](https://obsidian.md/)
- [Claudian](https://github.com/YishenTu/claudian)
- [Claude Code](https://code.claude.com/docs/)
- [Obsidian Skills](https://github.com/kepano/obsidian-skills)

本仓库是独立的中文实现，不代表上述项目的官方立场。代码与文档采用 [MIT License](LICENSE)。
