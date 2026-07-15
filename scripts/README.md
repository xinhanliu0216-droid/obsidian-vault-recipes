# 脚本

## 初始化 Vault

`new-vault.ps1` 只在目标目录不存在或为空时工作，不覆盖已有内容。

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/new-vault.ps1 `
  -Destination "D:\Vaults\my-course" `
  -VaultName "统计学课程库" `
  -Goal "整理课程资料并支持期末复习" `
  -PrimaryOutput "概念解释、主动回忆题和错题复盘" `
  -Scenario course
```

可选场景：`general`、`course`、`research`、`product`、`project`、`personal`、`book`。

生成后包含通用目录、已合并场景规则的 `CLAUDE.md`、根目录 index/log，以及可配置为 Obsidian Templates 文件夹的 `_templates/`。

脚本在 Windows PowerShell 和 PowerShell 7 中使用同一组参数。macOS/Linux 使用 `pwsh ./scripts/new-vault.ps1 ...`。

## 构建零终端 Starter Vault

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/build-starter.ps1
```

默认生成 `dist/obsidian-vault-recipes-starter.zip`。发布包包含 `.claude/skills/` 下的 9 个 Skills。GitHub Release 工作流会构建并附加压缩包；仓库不提交生成物。

普通初始化时，如需同时加入项目级 Claude Code Skills，增加 `-IncludeSkills`。

## 校验仓库

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/validate-repo.ps1
```

初始化脚本的独立烟雾测试：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/test-new-vault.ps1
```

其他两个独立烟雾测试：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/test-install-skills.ps1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/test-build-starter.ps1
```

它们只写入带随机前缀的系统临时目录，并在结束时清理。
