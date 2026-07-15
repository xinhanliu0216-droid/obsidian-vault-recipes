# GitHub 发布清单

这份清单记录不能只靠仓库文件完成的 GitHub 设置。首发前逐项检查，完成后不必从仓库删除。

## Repository settings

建议的 **About description**：

> Obsidian + Claudian 的 LLM Wiki 模板、Agent Skills 与测试配方，让 Claude Code / Codex 持续维护可追溯的本地 Markdown 知识库。

建议的 **Topics**（GitHub 最多允许 20 个）：

```text
obsidian
claudian
claude-code
codex
llm
llm-wiki
knowledge-base
personal-knowledge-management
agent-skills
markdown
second-brain
karpathy
ai-agents
chinese
obsidian-vault-template
```

同时检查：

- About 中勾选 Releases。
- 启用 Issues；准备维护讨论区时再启用 Discussions。
- 在 Settings → Code security 中启用 Private vulnerability reporting。
- 确认 Actions 的 `Validate repository` 工作流通过。
- 不需要 Packages、Wiki 或 Projects 时保持关闭，减少空入口。

## 社交预览

在 Settings → General → Social preview 上传一张 `1280 × 640`、小于 1 MB 的 PNG/JPG。图片只保留三层信息：

1. `Obsidian Vault Recipes`
2. `Obsidian + Claudian + LLM Wiki`
3. `CLAUDE.md · 9 Skills · 6 Scenarios · Tests`

避免把完整目录树塞进图片；移动端分享卡片会缩小。

## 首个 Release

1. 合并并确认 `main` 上的 Actions 通过。
2. 创建标签 `v1.0.0`。
3. Release 标题使用 `v1.0.0 — 通用 LLM Wiki 配方`。
4. 以 [CHANGELOG.md](../CHANGELOG.md) 的 `1.0.0` 为正文基础。
5. 在正文中突出快速开始、课程示例、9 个 Skills 和安全边界。
6. 发布后等待 `Attach Starter Vault` 工作流上传 `obsidian-vault-recipes-starter.zip`。
7. 不重复上传源码压缩包；GitHub 会自动生成 ZIP 和 tar.gz。

## 发布后传播

- 在个人 GitHub 主页置顶仓库。
- 分享时链接到一个具体结果，例如课程示例，而不是只说“发布了新项目”。
- 首批反馈优先收集无法完成安装、规则没有被触发、来源无法追溯三类失败。
- 把有效反馈写成最小测试案例，再修改规则；不要用增加宣传文字代替产品改进。

GitHub 官方参考：[仓库社区文件](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/about-community-profiles-for-public-repositories)、[Topics](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/classifying-your-repository-with-topics)、[社交预览](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/customizing-your-repositorys-social-media-preview)、[Releases](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases)。
