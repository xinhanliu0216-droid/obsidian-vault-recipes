# 课程场景最小示例

这个目录展示 [课程测试案例](../../tests/cases/course.md) 的一种合格结果。它不是唯一正确答案。

```text
course-demo/
├── raw/
│   └── lesson-01.md
├── wiki/
│   ├── sources/
│   │   └── lesson-01.md
│   ├── concepts/
│   │   └── 方差与标准差.md
│   └── topics/
│       └── Q-为什么不同量纲不直接比较标准差.md
├── index.md
└── log.md
```

观察重点：

- [Source 页](wiki/sources/lesson-01.md) 使用相对路径定位 [原始资料](raw/lesson-01.md)。
- [Concept 页](wiki/concepts/方差与标准差.md) 不复制整篇来源，只保留可复用解释与链接。
- [Question 页](wiki/topics/Q-为什么不同量纲不直接比较标准差.md) 支持主动回忆。
- 没有创建 Mistake 页，因为输入中没有用户真实答错记录。

