# 第 1 章：安装 Claude Code

> 最近核验：2026-07-15。安装命令可能变化，请优先查看 [Claude Code 官方安装文档](https://code.claude.com/docs/en/installation)。

## 目标

在 Windows 上完成 Claude Code 原生安装、登录和诊断。无需预先安装 Node.js。

## 推荐：Windows PowerShell 原生安装

打开 64 位 PowerShell，不需要管理员权限：

```powershell
irm https://claude.ai/install.ps1 | iex
```

关闭并重新打开终端，然后验证：

```powershell
claude --version
claude doctor
```

原生安装会自动更新，也更容易被 Claudian 发现。

## 备选：WinGet

```powershell
winget install Anthropic.ClaudeCode
```

WinGet 版本需要手动更新：

```powershell
winget upgrade Anthropic.ClaudeCode
```

## 登录

进入准备作为 Vault 的文件夹，再启动：

```powershell
Set-Location D:\Vaults\my-wiki
claude
```

按浏览器提示选择适合你的账号：

- Claude Pro、Max、Team 或 Enterprise 订阅
- Anthropic Console 按量计费
- 组织配置的云服务提供商

不要把 API Key 写进 `CLAUDE.md`、笔记、截图或 Git。需要环境变量时，只在系统设置或 Claudian 的本地设置中配置。

## Windows 选择

| 方式 | 适用情况 |
|---|---|
| 原生 Windows | Vault 位于 Windows 磁盘，主要使用 Obsidian/Claudian |
| WSL 2 | 依赖 Linux 工具链或需要 Claude Code 沙箱 |

Claudian 运行在桌面 Obsidian 中，新手优先选择原生 Windows，避免 Windows 与 WSL 路径混用。

## 常见问题

### 找不到 claude

```powershell
where.exe claude
claude doctor
```

重新打开终端；如果同时存在 npm 旧版和原生版，按官方排错文档保留一种安装。

### Claudian 找不到 Claude CLI

先让 Claudian 自动检测。如果失败，在 Claudian 设置的 Advanced 中填写 CLI 路径。原生安装通常是：

```text
C:\Users\你的用户名\.local\bin\claude.exe
```

不要在 Claudian 中填写 `.cmd` 或 `.ps1` 包装器。

### 公司网络或证书错误

先运行 `claude doctor`，再查看 [官方安装排错](https://code.claude.com/docs/en/troubleshoot-install)。不要通过关闭证书校验来“解决”问题。

## 完成标准

- `claude --version` 返回版本号
- `claude doctor` 没有阻断性错误
- 在 Vault 目录启动 `claude` 后可以完成一次对话
