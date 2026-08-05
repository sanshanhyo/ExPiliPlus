# 数据统计 Beta 3 工程实现记录

> 状态：已实现待验证<br>
> 记录日期：2026-08-05<br>
> 更新日期：2026-08-05<br>
> 适用版本：`1.0.0-dev.1`<br>
> 范围：历史记录统计页标题和活跃日期日历的可见日期范围；不包含历史接口、分页策略、统计口径、持久化、路由和平台配置

## 1. 当前结论

数据统计 Beta 3 已完成代码和定向自动化验证。本轮将三种语言的统计页标题更新为 Beta 3，并将活跃日期日历裁剪为第一天到最后一天存在可统计活动的日期；活动范围内部的空白日期仍保留，用于表达中间没有记录的日期。本轮未进行设备或桌面平台人工回归。

本轮修改了业务页面、ARB 本地化源文件和对应测试；没有修改统计数据模型、历史接口或持久化格式。

## 2. 背景与任务范围

### 2.1 要解决的问题

- 将统计页标题从 Beta 2 更新为 Beta 3。
- 活跃日期不再按“最早记录日期到当前时间”显示两端无活动的空白日期。
- 保留第一天和最后一天之间的连续月份日历结构，以及范围内部的无活动日期。

### 2.2 不解决的问题

- 不改变历史记录的加载、分页、去重和 1200 条查询上限。
- 不改变 `HistoryStatistics.periodStart` 与 `periodEnd` 的数据含义；统计概览仍显示当前可查询记录的覆盖范围。
- 不新增日期筛选器、统计口径、接口字段、持久化值、依赖或平台配置。

## 3. 依据与现状

| 类型 | 结论 | 依据 |
| --- | --- | --- |
| 已确认 | 统计页标题通过 `statisticsTitle` 本地化键显示，存在简体中文、繁体中文和英文三份 ARB 源文件。 | `lib/pages/history_stats/view.dart:43`、`lib/l10n/app_zh.arb:1698`、`lib/l10n/app_zh_Hant.arb:1402`、`lib/l10n/app_en.arb:1402` |
| 已确认 | Beta 2 日历原先由 `periodStart` 到 `periodEnd` 生成月份，并将每月完整日期网格渲染出来。 | `lib/pages/history_stats/view.dart:538-553`、`lib/pages/history_stats/view.dart:605-610`（修改前） |
| 已确认 | `activityByDay` 的键是有观看记录的日期，统计计算层只在有效 `viewAt` 记录上累计日期活动。 | `lib/pages/history_stats/statistics.dart:169-172`、`lib/pages/history_stats/statistics.dart:211-216` |
| 已确认 | Beta 3 只调整日历的可见边界，数据模型的 `periodStart`/`periodEnd` 和统计概览没有改动。 | `lib/pages/history_stats/view.dart:231-234`、`lib/pages/history_stats/view.dart:534-553` |
| 候选方向 | 如果未来需要展示无记录但仍属于查询覆盖范围的边界，可以另行增加范围切换或说明，不在本轮实现。 | 本轮产品要求仅指定去掉头尾空白日期 |
| 待验证 | 不同真实历史跨度、字体和窗口尺寸下，裁剪后的首尾月份网格视觉密度是否符合预期。 | 需要 Android、iOS 或桌面运行时人工回归 |

## 4. 技术路线

1. `HistoryStatisticsCalculator` 继续生成原有 `activityByDay`，不改变数据统计口径。
2. `_ActivityCalendar` 对 `activityByDay` 的日期键排序，取最早和最晚活动日期作为日历可见边界。
3. 月份列表只覆盖活动边界所在月份之间的月份。
4. `_ActivityMonthBlock` 在首月从最早活动日开始、在末月截止到最晚活动日；边界月份内部仍使用星期列对齐，范围中间的空白日期仍渲染为低色阶单元格。
5. 标题由三份 ARB 源文件更新后，通过现有 `flutter gen-l10n` 生成本地化 Dart 输出。

```mermaid
flowchart LR
  A[activityByDay] --> B[日期排序]
  B --> C[最早/最晚活动日期]
  C --> D[生成边界月份]
  D --> E[裁剪首尾月份日期]
  E --> F[保留范围内部空白日期]
```

## 5. 实施记录

### 5.1 变更文件

| 文件 | 变更 | 原因 |
| --- | --- | --- |
| `lib/pages/history_stats/view.dart` | 活跃日期日历从 `activityByDay` 计算首尾活动日期，并裁剪首月和末月的范围外日期。 | 实现 Beta 3 的活跃日期边界要求 |
| `lib/l10n/app_zh.arb` | 统计标题改为“数据统计（Beta 3）”。 | 更新简体中文标题 |
| `lib/l10n/app_zh_Hant.arb` | 统计标题改为“數據統計（Beta 3）”。 | 更新繁体中文标题 |
| `lib/l10n/app_en.arb` | 统计标题改为“Viewing statistics (Beta 3)”。 | 更新英文标题 |
| `lib/l10n/generated/app_localizations_*.dart` | 使用 `flutter gen-l10n` 重新生成 Beta 3 文案。 | 保持生成输出与 ARB 同步 |
| `test/pages/history_stats/view_test.dart` | 更新多月份日历测试，验证首尾范围外日期不显示且活动日期仍显示。 | 防止日历回退到完整月份范围 |
| `test/l10n/arb_key_consistency_test.dart` | 将标题版本断言更新为 Beta 3。 | 覆盖三种语言标题版本 |
| `docs/engineering/history-statistics-beta3.md` | 新建 Beta 3 工程实现记录。 | 记录范围、依据、实现和验证 |

### 5.2 关键决策

- **已确认：** 活跃日历的可见边界取 `activityByDay` 中最早和最晚的日期，而不是修改统计概览使用的 `periodStart`/`periodEnd`。
- **已确认：** 首尾活动日期之间的空白日期继续保留；只略去首尾之外的日期。
- **已确认：** 不增加依赖，不改变历史记录和统计数据结构。
- **候选方向：** 未来如需让用户在“完整查询范围”和“实际活动范围”之间切换，应先确认产品文案和交互方案。
- **待验证：** 真实账号数据下，长跨度首尾月份和动态字体的布局效果。

### 5.3 兼容性和风险

- 统计概览中的记录覆盖日期仍使用原有 `periodStart` 到 `periodEnd`，因此日历视觉范围与概览覆盖范围可能不同；这是本轮按“活跃日期处”限定修改后的预期行为。
- `activityByDay` 正常由有效 `viewAt` 记录构成；空统计状态不会渲染活跃日期日历。构造异常数据或未来改变统计模型时，需要重新确认空日期键的处理。
- 边界月份仍保留星期列对齐占位，不会把日历变成无日期序列；这可能导致首尾边界仍存在布局占位，但不会显示范围外日期单元格。
- `docs/` 当前受项目 `.gitignore` 规则影响，本轮未调整忽略策略。

## 6. 验证记录

| 层级 | 命令/平台/输入 | 预期 | 实际 | 结果 |
| --- | --- | --- | --- | --- |
| 本地化生成 | `/Users/husky/Developer/sdk/flutter/bin/flutter gen-l10n` | 生成输出包含 Beta 3 标题 | 命令退出 0，三份生成输出已更新 | 通过 |
| 定向测试 | `/Users/husky/Developer/sdk/flutter/bin/flutter test test/pages/history_stats/view_test.dart test/l10n/arb_key_consistency_test.dart` | 日历边界与三语标题断言通过 | 15 项通过 | 通过 |
| 统计测试 | `/Users/husky/Developer/sdk/flutter/bin/flutter test test/pages/history_stats/statistics_test.dart test/pages/history_stats/controller_test.dart` | 原有统计计算和控制器行为不回归 | 9 项通过 | 通过 |
| 全量测试 | `/Users/husky/Developer/sdk/flutter/bin/flutter test` | 全仓测试通过 | 58 项通过 | 通过 |
| 静态检查 | `/Users/husky/Developer/sdk/flutter/bin/flutter analyze` | 无新增分析错误 | 退出 0；70 条仓库既有 info 级提示，无 error | 通过 |
| 差异检查 | `git diff --check` | 无空白错误 | 无输出 | 通过 |
| 人工回归 | Android、iOS、Windows/macOS/Linux 统计页 | 核对标题、首尾边界、长跨度和字体布局 | 未运行 | 待验证 |

## 7. 遗留问题与下一步

| 问题 | 影响 | 下一步 | 前置条件 |
| --- | --- | --- | --- |
| 未进行设备/桌面人工回归 | 无法确认真实窗口尺寸、动态主题和字体下的最终视觉效果 | 在目标平台打开统计页，准备首尾有空档和跨月数据，检查标题及日历边界 | 可用设备或桌面构建环境 |
| 统计概览覆盖范围与活跃日历可见范围可能不同 | 用户可能看到概览日期比日历更宽 | 根据产品反馈决定是否增加范围说明或切换 | 产品负责人确认交互方向 |

## 8. 更新记录

- 2026-08-05：新建 Beta 3 工程记录；完成三语标题更新、活跃日期首尾裁剪、定向测试、统计测试、全量测试和静态分析；人工回归仍待目标平台执行。
