# 数据统计正式版工程实现记录

> 状态：已实现，待真实设备/桌面人工回归<br>
> 记录日期：2026-08-07<br>
> 更新日期：2026-08-07<br>
> 适用版本：`1.0.0-dev.1` / `main`<br>
> 范围：将数据统计页面从 Beta 4 标识正式化；不改变统计逻辑、导出能力或数据来源

## 1. 当前结论

数据统计功能已经具备正式版界面语义。本轮移除简体中文、繁体中文和 English 标题中的 `Beta 4` 标识，并同步更新本地化生成文件与一致性测试。Beta 4 工程记录保留为历史实现记录，本轮没有修改统计业务代码。

## 2. 背景与任务范围

### 2.1 要解决的问题

数据统计页面的功能已经可以投入正式版，但页面标题仍带有 Beta 4 标识。本轮将用户可见标题恢复为正式名称：`数据统计`、`數據統計` 和 `Viewing statistics`。

### 2.2 不解决的问题

- 不修改历史记录加载、活跃日期、连续活跃天数、星期分布或导出逻辑。
- 不改变数据源、可查询记录上限、文件保存策略和截图范围。
- 不删除 `history-statistics-beta4.md` 中的历史事实；该文件仍用于追溯 Beta 4 实现。

## 3. 依据与现状

| 类型 | 结论 | 依据 |
| --- | --- | --- |
| 已确认 | 统计页面使用 `statisticsTitle` 本地化键作为标题。 | `lib/pages/history_stats/view.dart`、`test/l10n/arb_key_consistency_test.dart:95-100` |
| 已确认 | 三份 ARB 原文和生成的 Dart 本地化文件都包含该标题。 | `lib/l10n/app_zh.arb:1698`、`lib/l10n/app_zh_Hant.arb:1402`、`lib/l10n/app_en.arb:1402` |
| 已确认 | 本轮用户决定移除正式版标题中的 Beta 标识。 | 本轮任务要求 |
| 候选方向 | 后续如需在应用商店、README 或发布说明中补充正式版功能介绍，可单独建立发布文案任务。 | 不属于本轮页面标题正式化范围 |
| 待验证 | 各平台实际显示的标题、字体和布局效果。 | Android、iOS、Windows、macOS、Linux 人工打开统计页面核对 |

## 4. 技术路线

本轮仅修改本地化资源及其测试，不改变页面调用链：

```mermaid
flowchart LR
  A[统计页面] --> B[statisticsTitle 本地化键]
  B --> C[三份 ARB]
  C --> D[Flutter gen-l10n]
  D --> E[生成的 Dart 本地化文件]
  E --> F[正式版标题]
```

## 5. 实施记录

### 5.1 变更文件

| 文件 | 变更 | 原因 |
| --- | --- | --- |
| `lib/l10n/app_zh.arb` | 将 `数据统计（Beta 4）` 改为 `数据统计`。 | 移除简体中文正式版标题的 Beta 标识 |
| `lib/l10n/app_zh_Hant.arb` | 将 `數據統計（Beta 4）` 改为 `數據統計`。 | 移除繁体中文正式版标题的 Beta 标识 |
| `lib/l10n/app_en.arb` | 将 `Viewing statistics (Beta 4)` 改为 `Viewing statistics`。 | 移除英文正式版标题的 Beta 标识 |
| `lib/l10n/generated/app_localizations.dart` | 重新生成本地化接口。 | 与 ARB 资源保持同步 |
| `lib/l10n/generated/app_localizations_en.dart` | 重新生成英文标题。 | 与 ARB 资源保持同步 |
| `lib/l10n/generated/app_localizations_zh.dart` | 重新生成简体和繁体中文标题。 | 与 ARB 资源保持同步 |
| `test/l10n/arb_key_consistency_test.dart` | 将测试改为断言三语标题不含 Beta 标识。 | 防止正式版标题回退到 Beta 文案 |
| `docs/engineering/history-statistics-release.md` | 新增本记录。 | 记录正式化范围、依据和验证结果 |

### 5.2 关键决策

- **已确认：** 正式版界面只移除标题中的 `Beta 4`，保留 `statisticsTitle` 本地化键及所有统计功能。
- **已确认：** 生成的本地化 Dart 文件由 `flutter gen-l10n` 更新，不手工维护生成结果。
- **已确认：** Beta 4 工程记录不回写为正式版，保留其历史版本信息。
- **候选方向：** 如未来需要替换“数据统计”这一产品名称，另行确认三语命名后再修改本地化资源。
- **待验证：** 真机和桌面端的标题视觉效果及不同字体/窗口宽度下的布局。

### 5.3 兼容性和风险

- 本轮未改变本地化键名，不影响已有调用方或其他语言回退机制。
- 本轮未改变统计数据结构、导出文件格式或历史数据兼容性。
- 工程记录位于当前项目的本地 `docs/` 文档目录；该目录默认被 `.gitignore` 忽略，本文件需要在提交时显式加入版本控制。

## 6. 验证记录

| 层级 | 命令/平台/输入 | 预期 | 实际 | 结果 |
| --- | --- | --- | --- | --- |
| 本地化生成 | `/Users/husky/Developer/sdk/flutter/bin/flutter gen-l10n` | ARB 与生成的 Dart 文件同步 | 命令退出 0，三语生成标题已移除 Beta 4 | 通过 |
| 定向测试 | `/Users/husky/Developer/sdk/flutter/bin/flutter test test/l10n/arb_key_consistency_test.dart` | 三语标题不含 Beta，其他本地化一致性测试通过 | 11 项测试全部通过 | 通过 |
| 全量测试 | `/Users/husky/Developer/sdk/flutter/bin/flutter test` | 全仓测试通过 | 67 项测试全部通过 | 通过 |
| 静态检查 | `/Users/husky/Developer/sdk/flutter/bin/flutter analyze`；定向分析本轮 4 个本地化/测试文件 | 无新增分析错误 | 全量分析报告 70 条既有 info 并以退出码 1 结束；定向分析无问题 | 通过（有既有 info） |
| 差异检查 | `git diff --check` | 无空白错误 | 无输出 | 通过 |
| 人工回归 | Android、iOS、Windows、macOS、Linux 打开统计页面 | 三语标题正确且布局正常 | 本轮未运行 | 待验证 |

## 7. 遗留问题与下一步

| 问题 | 影响 | 下一步 | 前置条件 |
| --- | --- | --- | --- |
| 尚未在真实设备或桌面运行统计页面 | 无法确认各平台字体和窗口尺寸下的视觉效果 | 在可用平台打开统计页面并切换三种语言核对标题 | 设备或桌面构建环境 |
| `.gitignore` 默认忽略 `docs/` | 工程记录不会被普通 `git add` 纳入提交 | 提交本轮变更时对本文件使用 `git add -f` | 项目负责人同意保留本地工程记录 |

## 8. 更新记录

- 2026-08-07：创建正式版工程记录；移除三语数据统计标题中的 Beta 4 标识，并同步本地化生成文件和一致性测试。
