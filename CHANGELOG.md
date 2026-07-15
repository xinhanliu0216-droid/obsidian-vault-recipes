# Changelog

本文件记录面向使用者的主要变化，格式参考 Keep a Changelog。

## 1.0.0 - 2026-07-15

### Added

- 增加通用 `CLAUDE.md`、页面模板与 Karpathy LLM Wiki 中文导读。
- 增加课程、研究、产品、项目、个人和图书六类场景覆盖层。
- 增加 9 个标准 Agent Skills，覆盖初始化、摄取、构建、查询、巡检和诊断。
- 增加安全的 PowerShell Vault 初始化脚本、烟雾测试和 GitHub Actions 校验。
- 增加课程、研究和项目管理三套完整处理示例与行为验收案例。
- 增加可自动附加到 GitHub Release、内含项目级 Skills 的零终端 Starter Vault。
- 增加 Skills 安装与 Starter ZIP 的独立烟雾测试。
- 增加 GitHub Actions 依赖更新配置。

### Changed

- 将仓库重构为可组合、可测试的通用 LLM Wiki 配方，而不是单一领域模板。
- 统一根目录 `index.md`、`log.md` 和来源追溯约定。
- 更新 Claude Code、Obsidian 与 Claudian 的安装路线。
- Skills 安装器默认拒绝覆盖同名目录，只有显式 `-Force` 才更新文件。
- GitHub Actions 升级到 `actions/checkout@v6`、限制默认权限，并自动构建 Release 下载包。
- 补充 macOS/Linux 通过 PowerShell 7 使用初始化脚本的路径。

### Removed

- 删除与模块化教程重复的单文件培训手册。
