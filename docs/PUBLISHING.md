# 发布说明

1. 更新 `CHANGELOG.md`，确认面向使用者的变化和兼容性。
2. 运行静态校验及三个烟雾测试。
3. 使用 `scripts/build-starter.ps1` 构建 Starter Vault，并检查压缩包不含测试和维护文件。
4. 创建版本标签与 GitHub Release，由发布工作流附加 Starter ZIP。
5. 下载发布产物，完成一次新用户路径抽查。

发布前不得包含真实 Vault、凭据、未脱敏资料或本机绝对路径。
