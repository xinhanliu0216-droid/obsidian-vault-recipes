# 第 5 章：测试与维护

规则写得漂亮不代表 Agent 会稳定执行。测试应该观察文件结果，而不是只问“你理解了吗”。

## 1. 三类测试

### 静态检查

检查仓库文件、链接、Skill frontmatter 和模板长度：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/validate-repo.ps1
```

### 脚本烟雾测试

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/test-new-vault.ps1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/test-install-skills.ps1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/test-build-starter.ps1
```

三项测试分别检查 Vault 初始化与防覆盖、9 个 Skills 的安全安装，以及 Release 压缩包能否独立解压使用。它们只操作随机临时目录。

### 场景验收

[tests/cases/](../tests/cases/) 为六类场景提供输入、提示词和可观察结果。把案例复制到临时 Vault 运行，不要直接在真实知识库实验。

### 行为回归

每次修改规则后，重复同一个提示词并比较：

- 计划涉及的文件是否更少、更准确
- `raw/` 是否保持不变
- 证据链接是否完整
- index 和 log 是否同步
- 场景专属字段是否出现

## 2. 最小测试循环

1. 保存一个能复现问题的小输入。
2. 记录修改前结果。
3. 只改一条规则或一个 Skill。
4. 在全新临时 Vault 重跑。
5. 比较文件树与关键字段。
6. 有改善才保留规则。

## 3. Lint 频率

| 时机 | 检查 |
|---|---|
| 每次摄取后 | raw 未变、来源链接、index、log |
| 每周 | 断链、孤立页、重复概念、待确认项 |
| 每月 | 冲突结论、陈旧总结、无效规则 |
| 结构变化后 | 全部场景案例和静态检查 |

## 4. 规模增长后的策略

- 数十页：`index.md` 和全文搜索通常足够。
- 数百页：按主题拆分索引，保持根索引只做导航。
- 查询变慢：再评估本地搜索或 MCP，不要一开始就引入向量数据库。
- 规则变长：把流程移到 Skill，把领域规则放到路径级规则。

## 5. 人工复核重点

- 新结论是否真的由来源支持
- Agent 是否把推断升级成事实
- 新页面是否帮助未来检索
- 同一概念是否被不同名称重复创建
- 私密资料是否进入了模型可读取范围

自动校验只能检查结构，不能替代内容判断。
