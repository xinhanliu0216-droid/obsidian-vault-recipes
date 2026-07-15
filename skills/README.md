# LLM Wiki Agent Skills

本目录包含 9 个标准 Agent Skills。每个 Skill 使用 `skills/<name>/SKILL.md` 结构，可被当前 Claude Code 和其他兼容 Agent Skills 的工具发现。

| Skill | 用途 | 默认写入 |
|---|---|---|
| `wiki-butler` | 只读状态检查与路由 | 否 |
| `wiki-init` | 初始化 Vault | 确认后 |
| `wiki-ingest` | 摄取原始来源 | 确认后 |
| `wiki-build` | 构建概念、实体、主题和综合 | 确认后 |
| `wiki-query` | 基于 Wiki 回答并建议写回 | 回答不写，写回需确认 |
| `wiki-specialize` | 修改场景规则 | 确认后 |
| `wiki-formal` | 生成可审查的正式材料 | 确认目标后 |
| `wiki-lint` | 健康巡检 | 报告不写，修复需确认 |
| `wiki-diagnose` | 定位规则或流程根因 | 否 |

## 安装到个人目录

```powershell
./skills/install-skills.ps1
```

或双击 `skills/install-skills.bat`。

默认目标是 `~/.claude/skills/`。PowerShell 脚本也支持指定目录：

```powershell
./skills/install-skills.ps1 -Destination "D:\Vaults\my-wiki\.claude\skills"
```

如果目标中已有同名 Skill，安装器会在复制前停止，不会留下半套结果。检查现有内容后，才能明确使用 `-Force` 更新匹配文件：

```powershell
./skills/install-skills.ps1 -Force
```

## 手动安装

复制 Skill 的整个目录，而不是只复制 `SKILL.md`：

```powershell
Copy-Item ./skills/wiki-* ~/.claude/skills/ -Recurse -Force
```

## 验证

```powershell
Get-ChildItem ~/.claude/skills/wiki-*/SKILL.md
```

在 Claude Code 或 Claudian 中输入 `/skills` 或键入 `/wiki-`，确认命令出现。

## 测试边界

`scripts/validate-repo.ps1` 检查结构和 frontmatter。行为质量需要在临时 Vault 中运行 [tests/evals.json](../tests/evals.json) 的提示词并人工复核。
