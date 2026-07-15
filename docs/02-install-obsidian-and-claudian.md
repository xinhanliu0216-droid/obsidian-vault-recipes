# 第 2 章：安装 Obsidian 与 Claudian

> 最近核验：2026-07-15。Claudian 当前已进入 Obsidian 社区插件市场；BRAT 仅作为备用安装方式。

## 1. 安装 Obsidian

1. 从 [Obsidian 官网](https://obsidian.md/download) 下载桌面版。
2. 创建一个新 Vault，例如 `D:\Vaults\my-wiki`。
3. 打开 Settings → Files and links，把新附件保存位置设置为 `raw/assets/`。
4. 确认 Vault 不包含密码、Token 或不应发送给模型的资料。

## 2. 安装 Claudian

推荐路径：

1. Settings → Community plugins。
2. 打开社区插件功能。
3. 点击 Browse，搜索 `Claudian`。
4. 安装并启用。
5. 从左侧 Ribbon 图标或命令面板打开聊天侧栏。

Claudian 会把当前 Vault 作为 Agent 工作目录。它支持 Claude Code，也支持 Codex、OpenCode、Pi 等提供方；本仓库以 Claude Code 为主要示例。

## 3. 备用：GitHub Release 或 BRAT

社区市场不可用时，按 [Claudian README](https://github.com/YishenTu/claudian) 的当前说明选择：

- 从 GitHub Release 下载 `main.js`、`manifest.json`、`styles.css`
- 或用 BRAT 安装测试版本

不要从不明网盘下载插件文件。

## 4. 配置提供方

先在终端完成 Claude Code 登录。Claudian 默认尝试自动发现 CLI。

若自动发现失败：

1. 运行 `where.exe claude`。
2. 打开 Claudian Settings → Advanced。
3. 设置 Claude CLI path。
4. 重启 Obsidian 后测试。

设备路径和密钥属于本地配置，不应写入共享 Vault。

## 5. 安装 Obsidian Skills

[kepano/obsidian-skills](https://github.com/kepano/obsidian-skills) 当前包含五个 Skill：Obsidian Markdown、Bases、Canvas、CLI 和网页正文提取。

在 Claude Code 中可使用其 Marketplace：

```text
/plugin marketplace add kepano/obsidian-skills
/plugin install obsidian@obsidian-skills
```

已安装 Node.js 时，也可使用：

```powershell
npx skills add https://github.com/kepano/obsidian-skills
```

安装后按上游 README 验证。不要让 Agent 在未展示来源和目标路径时静默安装未知 Skill。

## 6. 第一次安全测试

在 Vault 新建 `sandbox.md`，然后在 Claudian 输入：

```text
请只读取 sandbox.md，告诉我它的标题。不要修改任何文件。
```

再测试受控写入：

```text
请先说明准备修改哪个文件和修改内容，等我确认后再写入。
```

确认 Agent 能读取当前 Vault，并且修改前会停下来等待。

## 完成标准

- Claudian 侧栏可以打开
- 能调用所选 Agent
- Agent 的工作目录是当前 Vault
- 只读测试没有产生文件变化
