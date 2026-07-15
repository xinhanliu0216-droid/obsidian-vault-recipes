## 场景规则：项目管理

### 目标

从会议、邮件和文档中提取已确认的决策、任务、风险和里程碑。

### 页面类型

- `meeting`：会议来源、参会者、议题和记录。
- `decision`：背景、选项、决定、负责人和日期。
- `task`：动作、owner、due、status 和来源。
- `risk`：触发条件、概率、影响和应对。
- `milestone`：可验收的阶段结果。

目录映射：Meeting 放 `wiki/sources/`，Task、Risk、Milestone 放 `wiki/topics/`，Decision 放 `wiki/synthesis/`。

### 创建条件

- 只有明确承诺的行动才创建 Task；讨论中的建议标为 proposal。
- 不猜测 owner、截止时间或完成状态，缺失字段标待确认。
- Decision 必须来自明确决定，而不是讨论倾向。
- 状态变化应有会议、消息或用户确认作为依据。

### 查询输出

- 状态报告区分已完成、进行中、阻塞和未知。
- 每项任务显示 owner、due 和证据来源。
- 冲突的会议记录并列展示，等待负责人确认。

### 额外检查

- 逾期任务不会被自动改成完成。
- 决策链接回会议或来源。
- 日志不替代正式 Task/Decision 页面。
