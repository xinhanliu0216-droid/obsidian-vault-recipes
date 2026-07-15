## 场景规则：产品分析

### 目标

把用户反馈、问题、机会、实验和决策连接起来，保留证据与不确定性。

### 页面类型

- `feedback`：带日期和来源的用户原话或忠实转述。
- `problem`：多条证据支持的用户问题。
- `opportunity`：待验证机会，默认 `status: hypothesis`。
- `experiment`：假设、方法、指标和结果。
- `decision`：选择、替代方案、证据和反对意见。

目录映射：Feedback 放 `wiki/sources/`，Problem 和 Opportunity 放 `wiki/topics/`，Experiment 和 Decision 放 `wiki/synthesis/`。

### 创建条件

- 单条反馈不升级为普遍需求。
- Opportunity 可提前记录，但必须列出验证方法。
- Problem 需要多条独立反馈或量化数据；不足时标为弱信号。
- Decision 只有在责任人确认选择后才标记为 decided。

### 查询输出

- 分开报告频率、严重度和商业价值。
- 竞品观察记录来源日期，避免把营销文案当事实。
- 建议明确假设、风险和最小验证方式。

### 额外检查

- Problem 能回链到 Feedback。
- 实验结论没有超出样本范围。
- Decision 保留替代方案与反对证据。
