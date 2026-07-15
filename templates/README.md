# 模板使用说明

推荐使用 [new-vault.ps1](../scripts/new-vault.ps1) 自动复制并合并这些模板。以下步骤用于希望手工控制每个文件的用户。

## 启动文件

| 文件 | 放置位置 | 用途 |
|---|---|---|
| [CLAUDE.md](CLAUDE.md) | Vault 根目录 | 通用目标、结构、证据和权限规则 |
| [START-HERE.md](START-HERE.md) | Starter Vault 根目录 | 第一次使用的五步入口 |
| [karpathy的wiki方法论.md](karpathy的wiki方法论.md) | 阅读材料，可不复制 | 方法论中文导读 |
| [index.md](index.md) | Vault 根目录 | 内容入口 |
| [log.md](log.md) | Vault 根目录 | 追加式操作日志 |

## 页面模板

`pages/` 中的模板使用英文文件名和稳定 frontmatter 字段，正文可使用中文。复制到 Obsidian Templates 文件夹，或让 Agent 按模板创建页面。

## 场景规则

`scenarios/` 是增量规则，不是六份互相复制的完整 CLAUDE.md：

1. 先复制通用 [CLAUDE.md](CLAUDE.md)。
2. 选择一个主要场景。
3. 把对应文件中“可复制规则块”追加到 `CLAUDE.md`。
4. 修改占位符。
5. 运行对应测试案例。

同时使用多个场景时，逐条合并，不要直接拼接整个文件。

## 完整场景样例

如果希望直接查看生成后的完整 `CLAUDE.md`，使用 [六类场景完整样例](../examples/claude-md/README.md)。样例适合复制和学习；正式维护仍以通用模板加场景覆盖层为准。