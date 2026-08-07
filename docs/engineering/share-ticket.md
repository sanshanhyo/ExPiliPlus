# 分享票工程实现记录

> 状态：已实现，待设备与桌面人工回归<br>
> 记录日期：2026-08-05<br>
> 更新日期：2026-08-07<br>
> 适用版本：`1.0.0-dev.1`，`main`<br>
> 范围：仅包含 UGC BV 视频的分享票入口、编辑/预览、PNG 生成、保存和系统分享；不包含番剧/PGC、音频、本地视频和私信分享逻辑

## 1. 当前结论

已在 UGC 视频分享菜单加入“分享为分享票”，并新增独立二级页面。页面使用 `share2.png` 作为固定 1086×1448 背景，通过 Flutter `Stack` 叠加视频封面、视频信息、UP 主信息、统计数据、附言、二维码和分享者信息，支持预览、保存图片和系统分享。必要的封面、UP 主头像及 UP 主资料加载失败时阻止进入可生成状态并提供重试；未登录用户仍可生成，分享者头像和名称留空。本轮没有修改 PGC、音频、本地视频或私信分享入口。

业务代码已修改；Android、iOS、Windows、macOS、Linux 真机/桌面人工回归尚未在本环境完成。

## 2. 背景与任务范围

### 2.1 要解决的问题

用户在 UGC 视频分享菜单中需要一种基于固定票据模板的视觉化分享方式。分享票需要自动带入 BV 视频链接、封面、标题、发布时间、UP 主资料和播放统计，同时允许填写分享附言，并可输出图片或调用系统分享。

### 2.2 不解决的问题

- 不为番剧/PGC、音频、本地视频增加分享票入口。
- 不替换既有视频文本分享、动态转发、私信分享或外部链接逻辑。
- 不调用生图服务，不新增图片处理或网络依赖。
- 不在本轮承诺所有平台的相册权限、文件选择器和系统分享面板已通过人工回归。

## 3. 依据与现状

| 类型 | 结论 | 依据 |
| --- | --- | --- |
| 已确认 | UGC 分享菜单由 `UgcIntroController.actionShareVideo` 构造，本轮入口只加入此处。 | `lib/pages/video/introduction/ugc/controller.dart` |
| 已确认 | 视频详情已经提供 BV、封面、标题、发布时间、时长、UP 主和统计字段；分享票右上角展示视频时长而非分享时间。 | `lib/models_new/video/video_detail/data.dart`、`lib/models/model_owner.dart`、`lib/services/share_ticket_service.dart` |
| 已确认 | UP 主等级和头像由现有 `MemberHttp.memberInfo` 补充，当前用户来自 `Pref.userInfoCache`。 | `lib/http/member.dart`、`lib/utils/storage_pref.dart` |
| 已确认 | 模板原图为 1086×1448，已复制到 Flutter 资源目录。 | `docs/share2.png`、`assets/images/share_ticket/share2.png`、`pubspec.yaml` |
| 已确认 | 二维码内容使用标准视频路径 `https://www.bilibili.com/video/<bvid>`。 | `lib/services/share_ticket_service.dart` |
| 已确认 | 附言输入限制为 100 个 Unicode code point，数据模型和输入框均执行限制。 | `lib/services/share_ticket_service.dart`、`lib/pages/share_ticket/view.dart` |
| 待验证 | 实际远程图片、UP 主资料请求失败时，各平台网络栈是否稳定触发重试状态。 | 需在有网络的设备或桌面环境操作 |
| 待验证 | Android/iOS 相册权限、Windows/macOS/Linux 文件保存路径和系统分享能力。 | 需进行平台人工回归 |
| 待验证 | 不同字体、窄屏、超长标题和多分辨率封面下的视觉溢出与二维码可识别性。 | 需进行截图、扫码和视觉检查 |

## 4. 技术路线

```mermaid
flowchart TD
  A[UGC 视频分享菜单] --> B[关闭分享菜单]
  B --> C[打开分享票二级页面]
  C --> D[请求 UP 主资料]
  D --> E[预加载封面与头像]
  E -->|成功| F[编辑附言并实时预览]
  E -->|失败| G[错误状态与重试]
  F --> H[RepaintBoundary 截图]
  H --> I[保存 1086×1448 PNG]
  H --> J[share_plus 系统分享]
```

页面打开后先校验视频详情中的 `owner`、`mid`、`bvid`、封面和标题，再请求 UP 主资料。只有资料和必要图片预加载完成后才进入编辑/预览状态。当前登录用户存在且 `isLogin == true` 时复用缓存身份；没有登录用户时不请求分享者资源，也不阻止生成。

预览和截图使用同一个固定尺寸的 `ShareTicketCanvas`，模板背景通过 `Image.asset` 加载，内容使用 `Positioned`、`ClipRRect`、文字组件、头像和 `PrettyQrView` 叠加。`RepaintBoundary.toImage(pixelRatio: 1)` 输出 1086×1448 PNG，二维码和链接均来自同一个 `qrContent` 值，避免内容不一致。

## 5. 实施记录

### 5.1 变更文件

| 文件 | 变更 | 原因 |
| --- | --- | --- |
| `lib/pages/video/introduction/ugc/controller.dart` | 修改 | 加入“分享为分享票”菜单项并打开二级页面 |
| `lib/pages/share_ticket/view.dart` | 新增 | 编辑、预览、资源加载、截图、保存和系统分享 |
| `lib/services/share_ticket_service.dart` | 新增 | 统一封装 BV 链接、视频字段、统计、UP 主和分享者数据 |
| `assets/images/share_ticket/share2.png` | 新增 | 跟踪模板背景资源，内容来自 `docs/share2.png` |
| `pubspec.yaml` | 修改 | 声明分享票资源目录 |
| `lib/l10n/app_zh.arb` | 修改 | 简体中文分享票文案 |
| `lib/l10n/app_zh_Hant.arb` | 修改 | 繁体中文分享票文案 |
| `lib/l10n/app_en.arb` | 修改 | English 分享票文案 |
| `lib/l10n/generated/app_localizations*.dart` | 更新 | 由 Flutter l10n 生成分享票键的访问器和实现 |
| `test/services/share_ticket_service_test.dart` | 新增 | 数据映射、链接、统计、分享者和附言长度测试 |
| `test/pages/share_ticket/view_test.dart` | 新增 | 模板画布、二维码和关键文案 Widget 测试 |
| `test/l10n/arb_key_consistency_test.dart` | 使用现有测试 | 验证三种 ARB 的键集合一致 |

### 5.2 关键决策

- **已确认：** 第一版只从 UGC BV 视频分享菜单进入；标准链接统一使用 `/video/BV...` 路径。
- **已确认：** `share2.png` 原样作为背景，不使用生图工具；输出前先在二级页面预览。
- **已确认：** 分享票中填充封面、标题、发布时间、UP 主头像/名称/等级、播放/弹幕/点赞、附言、二维码、分享者和 ExPiliPlus 来源文案。
- **已确认：** 动态文案使用简体中文、繁体中文和 English 三份 ARB；统计数值沿用项目现有 `NumUtils.numFormat`，因此会随当前语言使用 `K/M` 或本地化单位。
- **已确认：** 未登录时分享者区域为空；必要远程资源失败时显示错误和重试按钮。
- **候选方向：** 未来可将模板坐标和样式抽成可配置主题，但本轮保持固定模板以保证和样板一致。
- **待验证：** 需要在实际平台确认图片保存完成提示、权限申请和系统分享面板行为。

### 5.3 兼容性和风险

- 资源加载依赖 Bilibili 图片和会员资料接口；网络不可用时页面不会生成半成品图片，而是停留在错误/重试状态。
- `MemberHttp.memberInfo` 是现有网络接口，本轮没有新增依赖或替换请求协议；接口字段缺失时按资源失败处理。
- 图片保存复用 `ImageUtils.saveByteImg`，移动端仍遵循既有相册权限策略，桌面端仍使用既有文件选择器。
- 预览使用 `FittedBox` 缩放，截图使用固定尺寸画布；单行短标题会将下方信息整体上移，底部来源文案已上移并增强可读性；仍需在小屏、字体替换和长文本场景进行人工视觉验证。
- 分享者头像为空时只渲染空头像框和空名称，不把未登录视为资源错误。

## 6. 验证记录

| 层级 | 命令/平台/输入 | 预期 | 实际 | 结果 |
| --- | --- | --- | --- | --- |
| 定向测试 | `/Users/husky/Developer/sdk/flutter/bin/flutter test test/services/share_ticket_service_test.dart test/pages/share_ticket/view_test.dart test/l10n/arb_key_consistency_test.dart` | 分享票服务、页面和 ARB 测试通过 | 15 个测试全部通过 | 通过 |
| l10n 生成 | `/Users/husky/Developer/sdk/flutter/bin/flutter gen-l10n` | 生成三语言访问器 | 生成完成，无错误 | 通过 |
| 完整测试 | `/Users/husky/Developer/sdk/flutter/bin/flutter test` | 项目测试通过 | 67 个测试全部通过 | 通过 |
| 静态分析 | `/Users/husky/Developer/sdk/flutter/bin/flutter analyze` | 无新增分享票错误 | 没有分享票相关诊断；项目已有 70 条 info，命令以非零状态结束 | 受既有问题影响 |
| 差异检查 | `git diff --check` | 无空白错误 | 通过 | 通过 |
| 资源一致性 | `cmp -s docs/share2.png assets/images/share_ticket/share2.png` | 模板原样复制 | 文件一致，尺寸为 1086×1448 | 通过 |
| 人工视觉 | Android/iOS/Windows/macOS/Linux | 入口、预览、保存、分享、尺寸、二维码和溢出 | 当前环境未执行 | 待验证 |

静态分析仍会被项目已有诊断阻止，但日志中没有本轮分享票文件的诊断；完整测试和差异检查均已通过。

## 7. 遗留问题与下一步

| 问题 | 影响 | 下一步 | 前置条件 |
| --- | --- | --- | --- |
| 尚未完成真实平台回归 | 无法确认权限、文件路径和系统分享面板 | 在 Android、iOS、Windows、macOS、Linux 分别操作分享票流程 | 对应设备/桌面运行环境 |
| 尚未完成网络异常与重试人工验证 | 无法确认所有网络错误都能友好恢复 | 断网或拦截封面/会员请求，确认重试后可恢复 | 可控网络条件 |
| 尚未完成二维码和文字视觉检查 | 可能存在字体、长标题或设备缩放差异 | 生成 PNG，检查 1086×1448、扫码和文字边界 | 运行应用并导出图片 |

## 8. 更新记录

- 2026-08-05：新增分享票入口、数据服务、模板渲染页面、三语言文案、模板资源和自动化测试；记录当前自动化验证结果及待完成的平台人工回归。
- 2026-08-07：根据视觉反馈将右上角字段改为视频时长；短标题时压缩标题下方留白；底部 ExPiliPlus 来源文案上移并提高可读性；二维码和统计图标风格暂不调整。
