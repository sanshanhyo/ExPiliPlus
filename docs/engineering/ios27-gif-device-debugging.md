# iOS 27 实机 GIF 导出调试与修复执行手册

> 状态：iOS 27 实机 GIF 全链路验证通过<br>
> 记录日期：2026-08-23<br>
> 更新日期：2026-08-23<br>
> 适用版本：1.0.0-dev.1；main@9b8199eaa 加当前工作区已有未提交修改<br>
> 范围：播放器 iOS 27 实机 GIF 导出、相册保存、取消和失败修复；不包含 Android/桌面回归、音频、编辑、贴纸、文字、分享和下载回退

## 1. 当前结论

本次 /goal 已完成工具检查、代码基线、deployment target 修复、Pods 重装、Flutter 构建、实体设备部署、转码/相册保存修复，并完成用户确认的 iOS 27 真机全链路验收。24 组参数矩阵、相册动画播放、权限拒绝后恢复授权、取消和重复导出均通过；本手册完成条件已满足，可记录“iOS 27 实机通过”。本次已修改 GIF MethodChannel、原生媒体读取和相册保存收尾逻辑。

当前目标已完成：同一条普通点播视频在 iOS 27 实体设备上完成 24 组参数矩阵，全部生成并保存到相册；相册拒绝后恢复授权、导出中取消、重复导出和播放状态恢复均由用户确认通过。

## 2. 背景与范围

### 2.1 要解决的问题

此前 iOS 27 真机尚未完成真实 Bilibili DASH、GIF 生成、相册保存和取消验收。当前 iOS 路径由 Flutter MethodChannel 调用 AVAssetImageGenerator 读取 H.264 视频帧，再由 ImageIO 写入 GIF；Android 和桌面仍使用原有 libmpv 路径。

### 2.2 不解决的问题

- 不把 HEVC、AV1 或直播源扩展到当前 iOS 原生路径。
- 不在没有直接读取失败证据时增加整轨下载或分段下载回退。
- 不改变 Android、Windows、macOS、Linux 的 GIF 转码实现。
- 不增加音频、后台任务、编辑器、贴纸、文字或分享能力。
- 不因普通构建失败擅自提高最低 iOS 版本；只有确认 Xcode 27 的 deployment target 阻塞时，才按第 6 节允许的条件处理。

## 3. 依据与已知状态

| 类型 | 结论 | 依据 |
| --- | --- | --- |
| 已确认 | 当前工具基线为 Xcode 27.0、Flutter 3.44.8、CocoaPods 1.17.0。 | 本机只读检查；执行时重新记录版本 |
| 已确认 | 实体 iPhone 当前报告 iOS 27.0，CoreDevice 状态为 connected。 | xcrun xcdevice list、xcrun devicectl list devices；执行时重新检查 |
| 已确认 | iOS GIF 入口只筛选 avc1 视频源，原生会话通过 io.github.sanshanhyo.expiliplus/gif_export 工作。 | lib/plugin/pl_player/view/view.dart；lib/plugin/pl_player/widgets/ios_gif_converter.dart；ios/Runner/AppDelegate.swift |
| 已确认 | 原生限制为时长不超过 10 秒、宽度不超过 720、FPS 不超过 15、单次只允许一个导出、GIF 无音频且无限循环。 | ios/Runner/GifExportSession.swift |
| 已确认 | Xcode 27 明确拒绝 Runner/Pods 中的 iOS 12–14 deployment target；已按本手册允许的条件统一到 iOS 15 并重装 Pods。 | `build/logs/ios27-gif-build.log`；`ios/Podfile`；`ios/Runner.xcodeproj/project.pbxproj` |
| 已确认 | `flutter build ios --debug --no-codesign` 通过，签名版 `flutter run` 已完成 Xcode 构建、安装并启动；Release 版修复包也已重新部署到设备。 | `build/logs/ios27-gif-build-after-ios15.log`；`build/logs/ios27-gif-flutter-release-save-fix.log` |
| 已确认 | 当前工作区已有签名、Bundle ID、Scheme/SPM、Pod 和其他业务修改。 | 执行前后的 `git status --short` 与 `git diff` |
| 已确认（非阻塞） | Debug Flutter VM Service 未在 60 秒内被发现；Release 包已完成设备安装、启动和业务验收，因此不影响本次 iOS 27 GIF 结论。 | `build/logs/ios27-gif-flutter-run.log`；用户真机验收反馈 |
| 已确认 | 普通 Bilibili DASH 已在 iOS 27 AVFoundation 原生路径中完成 24 组参数矩阵并持续提供帧。 | `build/logs/ios27-gif-device-gif-export.log`；用户真机验收反馈 |
| 已确认 | 用户实测修复前导出进度可完成，但照片 App 没有 GIF；已将 iOS GIF 保存改为 `SaverGallery.saveImage` 原始字节路径。 | `lib/utils/image_utils.dart`；用户实测反馈 |
| 已确认 | 修复后的签名 Release 包已在实体 iPhone 上完成一次 5 秒、720p、12 FPS 的 60 帧原生转码；视频轨道加载、逐帧取图和 GIF finalize 均成功，输出约 5 MB。 | `build/logs/ios27-gif-device-gif-export.log`；设备控制台脱敏日志 |
| 已确认 | 用户确认修复后的 24 个 GIF 均成功保存到系统相册，并可打开、循环播放。 | 用户于 2026-08-23 的真机反馈 |
| 已确认 | 相册权限拒绝后可进入设置恢复授权，并重新导出成功。 | 用户于 2026-08-23 的真机反馈 |
| 已确认 | 最大组合导出中取消可在规定时间内清理临时文件、恢复播放且不产生半成品；连续重复导出无 busy 或状态残留。 | 用户于 2026-08-23 的真机反馈 |

## 4. 保护工作区和证据

执行前后都运行：

~~~bash
pwd
git status --short
git diff --name-only
git diff --check
~~~

执行者必须遵守以下边界：

- 当前已有修改原样保留，不使用 git reset --hard、git checkout -- 或宽范围删除。
- 当前本机签名、Bundle ID、Xcode Scheme/SPM、Pod 变化视为用户已有调试状态，不回退、不自动提交，也不把无关差异整理进修复。
- 原始日志放在忽略的 build/logs/，只在工程记录中引用文件名和脱敏摘要。
- 日志不得包含完整视频 URL、签名参数、Cookie、User-Agent/Referer 内容、账号信息、设备标识或 Team ID。
- 24 个相册产物由用户决定是否保留，Codex 不自动删除。

## 5. /goal 执行顺序

### 5.1 阶段一：工具、设备和自动化基线

先检查工具和设备，不要先改业务代码：

~~~bash
xcodebuild -version
xcode-select -p
pod --version
/Users/husky/Developer/sdk/flutter/bin/flutter --version
xcrun devicectl list devices --filter "Platform BEGINSWITH 'iOS'" --hide-default-columns --columns State --hide-headers
/Users/husky/Developer/sdk/flutter/bin/flutter devices
~~~

应看到 Xcode 27、Flutter 3.44.8、CocoaPods 1.17.0，以及一台实体 iOS 27 设备处于可用/已连接状态。设备未连接、签名失败或应用无法安装时，先停在环境分支，不把问题归因于 GIF 代码。

建立代码基线：

~~~bash
/Users/husky/Developer/sdk/flutter/bin/flutter test --no-pub test/plugin/pl_player/widgets/ios_gif_converter_test.dart
/Users/husky/Developer/sdk/flutter/bin/flutter analyze --no-fatal-infos
~~~

### 5.2 阶段二：安装、日志和用户接管

使用当前工作区已有签名状态和实体设备目标启动 Debug 应用。设备 ID 不写入文档，执行时从 flutter devices 选择实体 iPhone。本次启动已完成编译、安装并尝试启动，但 Flutter 未发现 Dart VM Service；用户可直接在已安装的本地测试应用中继续完成页面操作：

~~~bash
mkdir -p build/logs
/Users/husky/Developer/sdk/flutter/bin/flutter run -d <实体设备ID> --debug 2>&1 | tee build/logs/ios27-gif-flutter-run.log
~~~

Codex 在应用启动、视频选择、权限弹窗和相册检查处暂停，请用户按提示完成点按。用户应选择一条普通点播视频，满足以下条件：

- 视频时长至少 15 秒。
- 480p 和 720p 均有 H.264（avc1）DASH 源。
- 不是直播、DRM 或必须额外输入凭据的内容。
- 播放器能够正常播放并显示 GIF 入口。

本次已增加原生阶段诊断日志，记录视频轨道加载、帧计划、帧进度、GIF finalize、错误域/错误码和输出字节数，不记录源 URL 和请求头内容。当前设备日志未出现 `asset_unreadable`、`frame_generation_failed` 或输出 finalize 失败；用户已确认一次 GIF 成功保存到系统相册。

### 5.3 阶段三：单组基线

先只执行 3 秒、480p、10 FPS：

1. 从播放器打开 GIF 入口，确认选择页展示预览、范围、分辨率和 FPS。
2. 确认视频暂停，选择 3 秒、480p、10 FPS 并开始导出。
3. 观察进度从 0 增长到完成，不出现 busy、asset_unreadable、frame_generation_failed 或输出校验失败。
4. 允许相册权限，确认保存成功。
5. 在相册打开 GIF，确认可播放并循环；回到播放器确认原播放状态已恢复。

默认组合 60 秒内未完成，进入故障分流，不继续盲跑矩阵。

### 5.4 阶段四：24 组完整矩阵

在同一条测试视频上完成全部组合。每组都要生成、保存、打开并检查循环播放。默认组合按 60 秒判断；其余组合按 180 秒判断。

| 编号 | 时长 | 宽度 | FPS | 预期帧数 | 耗时 | 进度 | 保存 | 相册播放 | 结论 |
| --- | ---: | ---: | ---: | ---: | --- | --- | --- | --- | --- |
| D03-W480-F10 | 3s | 480 | 10 | 30 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D03-W480-F12 | 3s | 480 | 12 | 36 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D03-W480-F15 | 3s | 480 | 15 | 45 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D03-W720-F10 | 3s | 720 | 10 | 30 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D03-W720-F12 | 3s | 720 | 12 | 36 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D03-W720-F15 | 3s | 720 | 15 | 45 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D05-W480-F10 | 5s | 480 | 10 | 50 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D05-W480-F12 | 5s | 480 | 12 | 60 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D05-W480-F15 | 5s | 480 | 15 | 75 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D05-W720-F10 | 5s | 720 | 10 | 50 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D05-W720-F12 | 5s | 720 | 12 | 60 | 5.6s | 通过 | 通过 | 通过 | 通过 |
| D05-W720-F15 | 5s | 720 | 15 | 75 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D08-W480-F10 | 8s | 480 | 10 | 80 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D08-W480-F12 | 8s | 480 | 12 | 96 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D08-W480-F15 | 8s | 480 | 15 | 120 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D08-W720-F10 | 8s | 720 | 10 | 80 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D08-W720-F12 | 8s | 720 | 12 | 96 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D08-W720-F15 | 8s | 720 | 15 | 120 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D10-W480-F10 | 10s | 480 | 10 | 100 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D10-W480-F12 | 10s | 480 | 12 | 120 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D10-W480-F15 | 10s | 480 | 15 | 150 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D10-W720-F10 | 10s | 720 | 10 | 100 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D10-W720-F12 | 10s | 720 | 12 | 120 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |
| D10-W720-F15 | 10s | 720 | 15 | 150 | 用户确认通过 | 通过 | 通过 | 通过 | 通过 |

耗时列除 D05-W720-F12 外未由设备控制台逐组采集；“用户确认通过”表示用户确认均在手册规定时限内完成，不补造具体耗时。

文件名应保留时长、宽度和 FPS，便于将相册产物与结果表对应。出现第一组失败时，暂停矩阵，先完成第 6 节的证据采集和最小修复，再重跑基线与受影响组合。

### 5.5 阶段五：权限恢复、取消和重复导出

#### 相册权限恢复

1. 在系统设置中拒绝或关闭照片权限。
2. 导出默认组合，确认不会显示成功保存，也不会把失败误报为成功。
3. 按应用提示进入设置重新授权。
4. 回到应用重新导出，确认保存成功并能在相册播放。

#### 取消

1. 选择 10 秒、720p、15 FPS，等待进度明确超过 0 后关闭加载层。
2. 5 秒内应完成原生取消、Dart Future 收尾、临时 GIF 清理和播放恢复。
3. 相册中不得出现取消产生的半成品，下一次导出不得返回 busy。

#### 重复导出

连续完成至少两次默认组合导出，中间不重启应用。每次都应创建新的会话、保存新的文件并恢复播放器；第二次不得复用第一次的错误状态或临时路径。

## 6. 故障分流与允许修改

| 症状/证据 | 首先检查 | 允许的最小修改 | 停止条件 |
| --- | --- | --- | --- |
| 设备不可用、安装失败、签名失败 | CoreDevice、Xcode 目标、当前本机签名状态 | 只修环境或签名配置；保留现有本机差异 | 仍需账号、证书或用户决定 |
| Xcode 明确因 iOS 12–14 deployment target 阻塞 | 构建日志中的具体 target | 仅在确认该阻塞后，将 Podfile、Runner Debug/Profile/Release 和必要 Pod 构建设置统一到 iOS 15；重新安装 Pods、编译并记录兼容性变化 | 非 deployment target 原因，不改最低版本 |
| GIF 入口提示源不可用 | DASH 是否存在、baseUrl/备用 URL、avc1 和目标宽度 | 只修现有 H.264 主/备用 URL 选择和空值处理 | 没有 H.264 源；不得改为 HEVC/AV1 |
| MethodChannel 缺失或 MissingPluginException | AppDelegate.swift 注册、通道名、GifExportSession.swift target membership | 修复 iOS 通道注册、文件编译归属并补通道测试 | 需要改公共产品协议 |
| busy、重复触发或会话未释放 | gifExportSession 清空时机、完成/取消竞态 | 修复单会话生命周期、完成回调和取消清理，并补回归测试 | 需要改变并发产品语义 |
| asset_unreadable 或 frame_generation_failed | 脱敏阶段日志、错误域/错误码、请求参数、视频时间范围 | 依据证据修 Header、重定向、URL 选择、时长边界或 AVFoundation 取帧方式 | 直读修复后仍失败且需要下载回退；停下请示 |
| output_creation_failed、output_finalize_failed 或 GIF 文件头无效 | 临时路径、目录权限、磁盘空间、ImageIO finalize、GIF87a/GIF89a | 只修已证实的输出创建/收尾问题并补文件头测试 | 需要改变文件格式或保存语义 |
| 转码成功但相册失败 | 照片权限、SaverGallery 返回结果、文件存在性 | 只修相册权限提示、保存结果传播和临时文件收尾 | 需要引入新的相册/分享依赖 |
| 取消超过 5 秒、残留文件或未恢复播放 | 原生当前帧、Dart dispose、Future finally、播放器状态 | 修主动取消、异步收尾、并发状态和恢复逻辑；保留 Android/桌面路径 | 需要扩大为后台任务 |

禁止因为看到“进度 0 失败”就盲目修改 libmpv 参数；iOS 当前路径不是 libmpv GIF 编码路径。禁止输出完整 CDN URL、Cookie 或真实登录响应。禁止自动加入整轨下载或分段下载回退。

若新增诊断，应包含阶段、耗时、参数范围、帧序号、错误域/错误码、输出字节数和 GIF 文件头，不包含网络凭据或可识别账号信息。诊断成功后保留为简洁调试日志。

## 7. 每次修复后的验证

按“测试先行、最小实现、再上设备”的顺序执行；本次已完成环境修复后的自动化和构建验证，真机业务步骤仍待用户接管：

~~~bash
dart format <变更的 Dart 文件>
/Users/husky/Developer/sdk/flutter/bin/flutter test --no-pub test/plugin/pl_player/widgets/ios_gif_converter_test.dart
/Users/husky/Developer/sdk/flutter/bin/flutter analyze --no-fatal-infos
/Users/husky/Developer/sdk/flutter/bin/flutter test
git diff --check
~~~

若修改 Swift 或 Xcode 配置，还要使用 `ios/Runner.xcworkspace` 编译 Runner，并记录实际 scheme、设备和结果。本次已按真实 deployment target 阻塞永久统一到 iOS 15；Flutter 构建通过，但显式 workspace 构建仍因当前既有 Swift Package 集成无法解析 `Flutter` 模块而失败，不能把该失败归因于 GIF 实现。

修复后必须依次重跑：

1. 3 秒、480p、10 FPS 基线。
2. 失败所在的矩阵组合及其相邻边界组合。
3. 全部 24 组矩阵。
4. 相册拒绝、重新授权、取消和重复导出。

## 8. 完成条件与记录同步

只有以下条件全部满足，才能在本手册中写“iOS 27 实机通过”：

- 24 组组合均在规定时限内完成生成。
- 24 个 GIF 均成功写入系统相册并可打开、循环播放。
- 相册拒绝后重新授权可以重试成功。
- 最大组合取消在 5 秒内清理并恢复播放。
- 连续重复导出没有 busy、残留临时文件或播放状态错误。
- 自动化测试、静态检查、iOS 编译和 git diff --check 均有实际结果记录。
- 失败时的日志和修复均能定位到具体层，不包含敏感信息。

若验证通过或发生业务代码/Xcode 兼容性修改，必须同步更新既有 docs/engineering/gif-recording.md 的状态、更新日期、验证表和变更记录。本手册应保留完整调试过程；既有记录应反映新的工程结论。

若仍失败，记录：

| 项目 | 内容 |
| --- | --- |
| 失败阶段 | 环境、入口、通道、媒体读取、帧生成、输出、相册或生命周期 |
| 复现输入 | 参数组合、视频类型和用户可见操作，不写完整 URL |
| 脱敏证据 | 日志文件名、错误域/错误码、耗时和输出摘要 |
| 已尝试修复 | 文件、测试和实际结果 |
| 当前阻塞 | 需要用户决定、设备条件或外部服务变化的事项 |
| 下一步 | 可执行动作和前置条件 |

### 8.1 本次执行结果

| 项目 | 内容 |
| --- | --- |
| 失败阶段 | 修复前为转码阶段；修复后转码、输出、相册和生命周期均通过 |
| 复现输入 | 修复前用户报告“显示转码失败或已取消”；修复后同一普通点播视频完成 24 组参数矩阵 |
| 脱敏证据 | `build/logs/ios27-gif-device-gif-export.log`：`video-track-loaded`、帧进度、`finalize success`、输出约 5 MB；其余矩阵及权限/生命周期结果由用户真机确认 |
| 已尝试修复 | iOS 15 deployment target；`SaverGallery.saveImage` 原始字节保存；原生视频轨道异步加载和脱敏日志；保存前照片权限检查；取消竞态保护；定向/全量测试、签名 Release 构建通过 |
| 当前阻塞 | 无；本手册完成条件已全部满足 |
| 下一步 | 无；相关代码和文档已提交为 `c96cc16ea` 并推送到 `origin/main` |

## 9. 更新记录

- 2026-08-23：创建 iOS 27 实机 GIF 导出调试与修复执行手册；定义 24 组参数矩阵、权限恢复、取消、重复导出、脱敏日志、故障分流、iOS 15 deployment target 条件和完成门槛。
- 2026-08-23：执行工具基线、Dart 基线、Pods 重装、iOS 15 deployment target 修复、Flutter device build 和实体设备安装；未进入 GIF 业务验证，保留 VM Service 未发现及 workspace SPM/Flutter 模块解析失败证据。
- 2026-08-23：用户确认修复前导出进度完成但照片 App 无 GIF；将 iOS GIF 保存改为 `SaverGallery.saveImage` 原始字节路径，定向测试与全仓测试通过，并重新部署 Release 版等待复测。
- 2026-08-23：修复转码阶段的视频轨道异步加载并加入脱敏原生阶段日志；签名 Release 包在实体 iPhone 上完成 5 秒、720p、12 FPS、60 帧 GIF 转码和 finalize；当时照片库结果及完整矩阵尚待验证，后续已完成。
- 2026-08-23：用户确认修复后的 GIF 已成功保存到系统相册；当时相册动画播放、24 组矩阵、权限恢复、取消和重复导出尚待验证，后续已全部通过。
- 2026-08-23：补强 GIF 保存前的照片权限检查，并修复转码完成与用户取消竞态下仍可能保存文件的问题；定向测试、全量测试和签名 Release 构建通过，真机回归待执行。
- 2026-08-23：用户确认 24 组参数矩阵、相册动画播放、权限恢复、最大组合取消、重复导出和播放状态恢复全部通过；iOS 27 实机 GIF 全链路验收完成。
