# 测试说明

本仓库使用两层测试。

## 1. 静态校验

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/validate-repo.ps1
```

检查：

- 必需文档和模板是否存在
- `CLAUDE.md` 是否超过 200 行
- 每个 Skill 是否使用 `<name>/SKILL.md` 和有效 frontmatter
- 本地 Markdown 链接是否指向存在的文件
- 是否重新出现已知的过时或领域残留文本
- 六个场景是否都有规则与案例

初始化脚本另有端到端烟雾测试：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/test-new-vault.ps1
```

它在系统临时目录创建 Vault，检查场景合并和防覆盖行为，然后只清理带随机测试前缀的临时目录。

Skills 安装和 Starter ZIP 也有独立测试：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/test-install-skills.ps1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/test-build-starter.ps1
```

前者检查 9 个 Skills、拒绝覆盖与显式 `-Force`；后者解压发布包，检查目录、模板标记和场景规则。

## 2. 行为验收

`cases/` 中每个案例包含：

- 最小原始输入
- 运行提示词
- 预期计划
- 写入后的可观察结果
- 不应发生的行为

请在临时 Vault 中人工运行。由于模型输出具有非确定性，判断重点是结构和证据边界，不要求逐字相同。

## Skill 评测集

[evals.json](evals.json) 提供覆盖 9 个 Skill 的真实提示词和预期结果。它可作为后续自动或人工基准的输入；本仓库不声称这些提示词已经在所有模型和提供方上得到同样结果。
