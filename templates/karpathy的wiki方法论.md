# Karpathy 的 LLM Wiki：中文导读与实现约定

> [!info] 来源
> 本文是对 Andrej Karpathy [LLM Wiki idea file](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) 的中文导读和本仓库实现，不是逐字原文。原始内容创建于 2026-04-04，请以链接版本为准。

## 核心区别

普通文件问答通常在每次提问时重新检索和拼接片段。LLM Wiki 则让 Agent 持续维护一份可读、可链接、可审查的 Markdown Wiki：

- 新来源进入后，不只建立索引，还会更新相关概念、实体和综合页面。
- 冲突、交叉引用和阶段性综合被保留下来。
- 下一次查询从已经积累的结构继续，而不是从零开始。

## 三层架构

1. **Raw sources**：用户策划的原始来源，是不可变真源。
2. **Wiki**：Agent 创建和维护的 Markdown 页面，用户阅读与复核。
3. **Schema**：`CLAUDE.md` 或其他 Agent 指令文件，规定结构、工作流与权限。

本仓库把它实例化为：

```text
raw/                  # 只读原始资料
wiki/
  sources/            # 每份来源一页
  entities/           # 人物、机构、产品、项目
  concepts/           # 概念与定义
  topics/             # 跨来源主题
  synthesis/          # 比较和阶段性综合
index.md              # 内容目录
log.md                # 追加式操作日志
CLAUDE.md             # Schema
```

## 四个基本操作

### Ingest

读取一份来源，创建 Source 页，更新受影响的 Wiki 页面、索引和日志。建议一次处理一份或一个小批次，并让用户参与取舍。

### Query

先从索引定位页面，再基于 Wiki 和 Source 页回答。长期有价值的比较、分析或新连接可以在确认后写回。

### Lint

检查冲突、陈旧结论、孤立页、缺失链接、重复概念和证据空白。

### Evolve schema

当 Agent 重复犯同一种错误时，修改最小规则并用固定案例测试。不要因为一次偶然输出就持续增加规则。

## 本仓库增加的约定

原始 idea file 刻意保持抽象。本仓库为可重复使用增加了：

- 修改前确认和批量操作边界
- Source 页的相对路径与证据字段
- 通用核心与场景覆盖层
- 标准 Agent Skills
- 静态检查和行为验收案例

这些是本仓库选择，不是 Karpathy 原文要求。使用者可以按领域删改。

## 何时不需要复杂工具

小型 Wiki 用 `index.md`、wikilink 和全文搜索通常足够。只有当页面规模和查询延迟成为真实问题时，再评估本地搜索、MCP 或混合检索。
