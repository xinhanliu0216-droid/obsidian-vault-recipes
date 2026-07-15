# 第 3 章：建立第一个 Obsidian LLM Wiki

前两章已经完成 Claude Code、Obsidian 和 Claudian 安装。本章不再重复工具配置，而是把一个普通 Obsidian Vault 建成能由 Agent 持续摄取、查询和维护的 LLM Wiki。

## 1. LLM Wiki 不等于“让 AI 总结文件”

普通资料库只保存文件；LLM Wiki 还需要一套稳定规则，告诉 Agent：

- 原始资料放在哪里，能不能修改；
- 每份来源怎样保留出处；
- 什么内容值得形成概念、实体或主题页；
- 什么时候才能跨来源形成综合结论；
- 查询时怎样区分事实、推断、冲突和未知；
- 长文档怎样分批，并在中断后继续；
- 一次工作怎样验收。

这套规则写在 Vault 根目录的 `CLAUDE.md` 中。Obsidian 负责存储、链接和浏览，Claudian/Claude Code 负责在规则约束下读取和维护 Markdown。

## 2. 先定义知识库，而不是先建文件夹

建立 Vault 前先写下五件事：

1. **知识库目标**：它最终帮助你复习、研究、做产品决策、管理项目、个人复盘，还是阅读长材料？
2. **材料类型**：教材、论文、访谈、会议记录、日记、整本书，是否有页码、章节、时间戳和版本？
3. **主要输出**：你最常问什么，期望得到什么页面或回答？
4. **权限边界**：`raw/` 是否只读，是否允许联网，哪些内容不能共享？
5. **完成标准**：怎样证明一次摄取没有漏范围、编造来源或制造重复页面？

不知道怎样回答时，可以先选一个场景样例，再让 AI 提问完善；不要让 AI 自行决定权限和证据门槛。

## 3. LLM Wiki 的知识流水线

```text
raw 原始材料
  ↓
Source 来源页：这份材料具体说了什么
  ↓
Concept / Entity / Topic：哪些知识值得跨来源复用
  ↓
Synthesis：多个来源共同支持什么、冲突在哪里、还不知道什么
  ↓
index / query / maintenance：导航、查询和持续维护
```

各层职责：

| 层 | 作用 | Agent 权限 |
|---|---|---|
| `raw/` | 保存用户提供的原始材料 | 只读 |
| `_staging/` | 长文档解析、manifest、分块和恢复点 | 可重建，清理前确认 |
| `wiki/sources/` | 忠实记录单份来源或明确范围 | 可维护 |
| `wiki/concepts/` | 稳定、可复用的概念 | 可维护 |
| `wiki/entities/` | 多页面复用的人物、组织或对象 | 可维护 |
| `wiki/topics/` | 问题、条件、争议和变化过程 | 可维护 |
| `wiki/synthesis/` | 多来源综合和阶段性判断 | 可维护、必须保留证据边界 |
| `index.md` | 知识库入口和待整理区 | 可维护 |
| `log.md` | 追加式操作与规则变更记录 | 只追加 |

## 4. 选择一个场景和完整 CLAUDE.md 样例

不要一次混入六个场景。先选择主要用途：

| 目标 | 场景说明 | 完整 CLAUDE.md 样例 |
|---|---|---|
| 学习、备考 | [课程学习](scenarios/3A-course.md) | [课程样例](../examples/claude-md/course-CLAUDE.md) |
| 论文、综述 | [学术研究](scenarios/3B-research.md) | [研究样例](../examples/claude-md/research-CLAUDE.md) |
| 反馈、机会、决策 | [产品分析](scenarios/3C-product.md) | [产品样例](../examples/claude-md/product-CLAUDE.md) |
| 会议、任务、风险 | [项目管理](scenarios/3D-project.md) | [项目样例](../examples/claude-md/project-CLAUDE.md) |
| 日记、目标、复盘 | [个人成长](scenarios/3E-personal.md) | [个人样例](../examples/claude-md/personal-CLAUDE.md) |
| 整本书、长报告 | [图书与长材料](scenarios/3F-book.md) | [图书样例](../examples/claude-md/book-CLAUDE.md) |

完整样例展示最终文件应包含什么；实际使用前必须修改目标、输入、输出、权限和完成标准。

## 5. 创建 Vault

### 方法 A：下载 Starter Vault

从 [GitHub Releases](https://github.com/xinhanliu0216-droid/obsidian-vault-recipes/releases/latest) 下载 Starter ZIP，解压后用 Obsidian 打开，再把选择的完整样例复制为根目录 `CLAUDE.md`。

### 方法 B：使用初始化脚本

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./scripts/new-vault.ps1 `
  -Destination "D:\Vaults\my-course" `
  -VaultName "统计学课程库" `
  -Goal "把课程资料整理成可理解、可练习、可复习的知识库" `
  -PrimaryOutput "概念解释、主动回忆题和错题复盘" `
  -Scenario course `
  -IncludeSkills
```

脚本会把通用规则与场景覆盖层合并成完整 `CLAUDE.md`，并创建目录、页面模板、index 和 log。脚本只是自动创建方式，不改变 LLM Wiki 的知识模型。

### 方法 C：手工建立

1. 创建最小目录结构；
2. 从 [完整样例](../examples/claude-md/README.md) 复制一个 `CLAUDE.md`；
3. 配置 Obsidian Templates 文件夹；
4. 在 Claudian 中打开当前 Vault；
5. 要求 Agent 先只读检查规则和目录。

## 6. 第一次只摄取一份小资料

第一次不要处理整本书或几十篇论文。把一份短材料放入 `raw/`，然后输入：

```text
请先读取 CLAUDE.md 和 index.md，再检查 raw/ 中的新资料。
暂时不要写文件。请告诉我：
1. 这份材料的范围和可定位信息；
2. 是否已经摄取；
3. 准备创建或更新哪些页面；
4. 哪些内容只留在 Source，哪些值得形成知识页；
5. 完成后怎样验证。
```

确认计划后再让 Agent 执行。

## 7. 观察知识怎样形成

第一次摄取至少检查：

- 是否创建一个能回到原文件的 Source；
- 是否把作者原话、事实、推断和未知分开；
- 是否先搜索现有页面再新建；
- 是否避免为每个名词建孤立页；
- 是否更新 index 并追加 log；
- 是否完全没有改动 `raw/`。

如果只有一份材料，不要急着创建 Synthesis。综合意味着跨来源比较，不是把摘要写得更漂亮。

## 8. 第一次处理长文档

长材料先做盘点，不先做全文总结：

1. 读取目录、页数、版本、附件和可解析情况；
2. 在 `_staging/manifest.md` 建立章节与批次清单；
3. 优先按章、节、日期等语义边界切分；
4. 每批先建立 Source，再更新知识页；
5. 记录已处理范围、遗漏和下一起点；
6. 关键范围未覆盖前，不生成全书或全集最终结论。

具体规则已经写入通用模板和图书场景样例。

## 9. 验证 CLAUDE.md 是否适合你的知识库

用真实任务测试，而不是问 AI“你理解了吗”：

- 摄取一份短材料，看是否保留来源；
- 提供一个近义概念，看是否先搜索再建页；
- 提出一个证据不足的问题，看是否承认未知；
- 要求处理整本书，看是否先建立 manifest；
- 要求批量修改，看是否先展示计划并等待确认。

发现问题后，进入下一章：[修改和演化 CLAUDE.md](04-modify-claude-md.md)。规则应从真实失败中演化，而不是一次写得无限长。