run `dart run tool/jnigen.dart`

## 从 GitHub Actions 安装 macOS 构建

在 macOS 的仓库根目录执行：

```bash
./tool/install_actions_macos.sh
```

脚本会触发 `build.yml` 的 macOS-only 构建，等待成功后下载并校验
`ExPiliplus_macOS_release` DMG，保存到
`~/Downloads/ExPiliPlus-Actions`，安装到 `~/Applications/ExPiliplus.app`，
并启动应用。它不会绕过 macOS Gatekeeper，也不会删除旧版本；替换旧版本时
会先在安装目录留下带 Actions run ID 的备份。

前置条件是已安装 GitHub CLI，并完成 `gh auth login`。常用选项：

```bash
# 安装到系统 Applications 目录（可能需要本机权限）
./tool/install_actions_macos.sh --install-dir /Applications

# 使用已经完成的 Actions 运行，不重新触发构建
./tool/install_actions_macos.sh --run-id 34948101777 --no-launch
```
