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

## 语义质量人工评分

结构检查通过不代表内容可靠。行为验收还应按以下维度评分：

| 维度 | 通过标准 |
|---|---|
| 忠实性 | 重要表述能在来源中定位，不把作者解释写成事实 |
| 完整性 | 未遗漏影响结论的条件、反例与限制 |
| 可追溯性 | 重要主张链接 Source，综合页使用至少两个独立来源 |
| 原子性 | 页面职责单一，但不过度拆分一次性细节 |
| 去重性 | 建页前搜索标题和别名，近义页面得到合并 |
| 边界意识 | 明确区分事实、推断、冲突和未知 |
| 可检索性 | 标题、别名、索引和链接支持后续查询 |

建议每项使用 0（失败）、1（部分满足）、2（满足）评分；出现隐私泄露、修改 `raw/` 或伪造来源时直接判定失败。