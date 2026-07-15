# 学术研究场景示例

这个目录使用两份虚构研究摘要，展示 Agent 如何保留研究设计差异，而不是把结果粗暴合并成“有效”或“无效”。材料只用于演示，不是真实论文，也不能作为学术引用。

```text
research-demo/
├── raw/
│   ├── study-a.md
│   └── study-b.md
├── wiki/
│   ├── sources/
│   │   ├── study-a.md
│   │   └── study-b.md
│   ├── concepts/
│   │   └── 延迟测验.md
│   └── synthesis/
│       └── 间隔学习的证据边界.md
├── index.md
└── log.md
```

观察重点：

- 两个 [Source 页](wiki/sources/study-a.md) 分别记录样本、测量时间和局限。
- [延迟测验](wiki/concepts/延迟测验.md) 只解释可跨研究复用的方法概念。
- [综合页](wiki/synthesis/间隔学习的证据边界.md) 没有把 24 小时与 7 天结果当作直接冲突。
