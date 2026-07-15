# 项目管理场景示例

这个目录使用一份虚构会议记录，展示 Agent 如何区分已确认决策、明确任务和仍待确认的风险。材料不对应真实团队。

```text
project-demo/
├── raw/meeting-2026-07-15.md
├── wiki/
│   ├── sources/meeting-2026-07-15.md
│   ├── topics/
│   │   ├── T-完成导入性能基线.md
│   │   └── R-测试数据到位延迟.md
│   └── synthesis/
│       └── D-先建立性能基线再优化.md
├── index.md
└── log.md
```

观察重点：

- [Decision](wiki/synthesis/D-先建立性能基线再优化.md) 只记录会议明确确认的决定。
- [Task](wiki/topics/T-完成导入性能基线.md) 有负责人和截止日期。
- [Risk](wiki/topics/R-测试数据到位延迟.md) 没有猜测负责人或截止日期。
