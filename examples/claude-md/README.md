# 六类场景的完整 CLAUDE.md 样例

这里的文件是完整、可复制的 `CLAUDE.md`，不是只有场景差异的规则片段。

| 场景 | 完整样例 | 适合的知识库 |
|---|---|---|
| 课程学习 | [course-CLAUDE.md](course-CLAUDE.md) | 教材、课件、课堂记录、作业和错题 |
| 学术研究 | [research-CLAUDE.md](research-CLAUDE.md) | 论文、研究报告、证据比较和综述 |
| 产品分析 | [product-CLAUDE.md](product-CLAUDE.md) | 用户访谈、反馈、竞品、指标和决策 |
| 项目管理 | [project-CLAUDE.md](project-CLAUDE.md) | 会议、计划、任务、风险和里程碑 |
| 个人成长 | [personal-CLAUDE.md](personal-CLAUDE.md) | 日记、目标、习惯、复盘和个人实验 |
| 图书与长材料 | [book-CLAUDE.md](book-CLAUDE.md) | 整本书、长报告、章节和跨章节主题 |

## 怎样使用

1. 选择最接近的一个场景样例，复制到自己的 Vault 根目录并改名为 `CLAUDE.md`。
2. 修改知识库名称、目标、真实材料类型、主要输出和权限边界。
3. 删除不需要的页面类型，补充本领域的创建条件和不创建条件。
4. 调整长文档的分批单位、manifest 字段和允许综合的门槛。
5. 把一个真实失败案例交给 AI，请它提出最小 diff 和测试；确认后再修改。

完整样例用于展示最终形态；需要组合规则时仍建议从 [通用模板](../../templates/CLAUDE.md) 和 [场景覆盖层](../../templates/scenarios/README.md) 生成，避免六份文件长期漂移。