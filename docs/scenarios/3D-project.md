# 3D：项目管理

项目场景强调状态必须来自明确证据，不能由 Agent 猜测。

## 相对通用模板的变化

- 增加 Meeting、Task、Decision、Risk、Milestone。
- Task 需要动作、owner、due、status 和来源。
- 未明确的负责人或日期标待确认。
- 讨论倾向不等于正式决定。

## 使用

1. 复制 [项目规则](../../templates/scenarios/project.md)。
2. 定义项目负责人和状态枚举。
3. 运行 [项目验收案例](../../tests/cases/project.md)。

## 典型失败

- 自动给任务分配 owner。
- 根据沉默或时间推移判断任务完成。
- 改写过去会议记录来匹配当前状态。
- 把行动建议创建成已承诺任务。
