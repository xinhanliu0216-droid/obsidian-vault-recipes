# 场景规则

这些文件是相对通用 `CLAUDE.md` 的领域覆盖层，不是可以脱离通用规则单独使用的完整文件。

| 场景 | 规则 | 测试 |
|---|---|---|
| 通用 | [general.md](general.md) | 使用静态检查和通用 Skill 评测 |
| 课程学习 | [course.md](course.md) | [course.md](../../tests/cases/course.md) |
| 学术研究 | [research.md](research.md) | [research.md](../../tests/cases/research.md) |
| 产品分析 | [product.md](product.md) | [product.md](../../tests/cases/product.md) |
| 项目管理 | [project.md](project.md) | [project.md](../../tests/cases/project.md) |
| 个人成长 | [personal.md](personal.md) | [personal.md](../../tests/cases/personal.md) |
| 图书与长材料 | [book.md](book.md) | [book.md](../../tests/cases/book.md) |

## 怎样选择和修改

1. 先写清知识库目标、真实输入、主要输出、权限边界和一个失败案例。
2. 选择最接近的主场景，不要一次加入全部场景。
3. 保留场景文件的“输入与处理单位、页面类型、摄取规则、查询输出、完成标准”。
4. 删除不适用的页面类型，补充本领域的创建和不创建条件。
5. 如果材料很长，明确语义批次、manifest、恢复点、遗漏清单和综合门槛。
6. 让 AI 先提出最小 diff 和测试，确认后再修改 `CLAUDE.md`。

详细方法见 [如何设计和修改知识库的 CLAUDE.md](../../docs/design-your-claude-md.md)。

## 跨场景组合

选择一个主场景，再从次场景复制少量真正需要的差异。例如“研究型课程”以课程为主，只加入研究场景的证据比较规则。若创建条件、状态或权威来源冲突，在 `CLAUDE.md` 明确写出优先级，不直接拼接整份文件。

## 何时交给 AI

目标、隐私边界、权威来源和证据门槛由用户决定；具体规则措辞、目录映射、最小 diff 和测试提示可以交给 AI 完善。AI 必须先展示方案，不能自行扩大权限或改变知识库目标。