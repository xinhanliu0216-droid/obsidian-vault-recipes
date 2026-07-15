# 贡献指南

感谢你愿意改进这套配方。错别字、失效链接和小范围说明可以直接提交 PR；新场景、大幅规则调整或目录变更，请先开 Issue 说明要解决的问题。

## 开始之前

1. Fork 仓库并从 `main` 创建短分支。
2. 一个 PR 只解决一类问题，避免混入无关格式化。
3. 不要提交真实姓名、密钥、绝对路径、未授权资料或私人 Vault 内容。
4. 规则变更需要附上能暴露问题的最小案例。

## 内容放在哪里

| 内容 | 位置 |
|---|---|
| 跨场景、长期有效的约束 | `templates/CLAUDE.md` |
| 某一领域的增量差异 | `templates/scenarios/` |
| 重复、多步骤的操作流程 | `skills/<name>/SKILL.md` |
| 可观察的成功与失败案例 | `tests/cases/` 或 `tests/evals.json` |
| 完整的处理结果 | `examples/` |

新规则必须说明触发条件、允许的写入范围、可观察结果，以及失败时怎样被发现。能由场景覆盖层或 Skill 解决的问题，不继续加长通用 `CLAUDE.md`。

## 本地检查

在仓库根目录运行：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/validate-repo.ps1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/test-new-vault.ps1
```

如果修改了某个场景，同时更新对应的 `tests/cases/`。如果修改了 Skill，检查它的 frontmatter、触发描述和 `tests/evals.json` 中的用例。

## 文档风格

- 面向第一次接触终端的读者解释必要术语。
- 命令注明适用的 Shell，路径不要绑定作者电脑。
- 仓库内使用相对 Markdown 链接，Vault 示例优先使用 Obsidian wikilink。
- 给出可验证的限制，不承诺“永远正确”或“全自动无误”。
- 优先提供一个真实例子，不堆叠同义形容词。

## Pull Request

PR 描述应回答三个问题：原来哪里会失败、这次改了什么、怎样验证。提交即表示你同意按本仓库的 MIT License 发布贡献内容，并遵守 [行为准则](CODE_OF_CONDUCT.md)。
