#!/usr/bin/env bash

set -euo pipefail

DEFAULT_REF="upstream-2.1.4-sync"
DEFAULT_DOWNLOAD_DIR="$HOME/Downloads/ExPiliPlus-Actions"
DEFAULT_INSTALL_DIR="$HOME/Applications"
WORKFLOW="build.yml"
ARTIFACT="ExPiliplus_macOS_release"

ref="$DEFAULT_REF"
download_dir="$DEFAULT_DOWNLOAD_DIR"
install_dir="$DEFAULT_INSTALL_DIR"
run_id=""
timeout_minutes=45
launch_app=1
repo=""

usage() {
  cat <<'EOF'
用法：
  tool/install_actions_macos.sh [选项]

默认行为：
  触发 upstream-2.1.4-sync 的 macOS-only GitHub Actions 构建，等待成功，
  下载 DMG 到 ~/Downloads/ExPiliPlus-Actions，安装到 ~/Applications，随后启动应用。

选项：
  --ref REF                 要构建的分支或标签（默认：upstream-2.1.4-sync）
  --run-id ID               使用已有 Actions 运行，不重新触发构建
  --repo OWNER/REPO         指定 GitHub 仓库（默认从当前目录推断）
  --download-dir DIR        DMG 保存目录
  --install-dir DIR         App 安装目录（可指定 /Applications）
  --timeout-minutes N       等待 Actions 的最长分钟数（默认：45）
  --no-launch               安装后不启动应用
  -h, --help                显示帮助

前置条件：
  macOS、GitHub CLI（gh）以及 gh auth login 已完成。
EOF
}

die() {
  printf '错误：%s\n' "$1" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || die "找不到命令：$1"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --ref)
      [ "$#" -ge 2 ] || die "--ref 需要参数"
      ref="$2"
      shift 2
      ;;
    --run-id)
      [ "$#" -ge 2 ] || die "--run-id 需要参数"
      run_id="$2"
      shift 2
      ;;
    --repo)
      [ "$#" -ge 2 ] || die "--repo 需要参数"
      repo="$2"
      shift 2
      ;;
    --download-dir)
      [ "$#" -ge 2 ] || die "--download-dir 需要参数"
      download_dir="$2"
      shift 2
      ;;
    --install-dir)
      [ "$#" -ge 2 ] || die "--install-dir 需要参数"
      install_dir="$2"
      shift 2
      ;;
    --timeout-minutes)
      [ "$#" -ge 2 ] || die "--timeout-minutes 需要参数"
      timeout_minutes="$2"
      shift 2
      ;;
    --no-launch)
      launch_app=0
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "未知参数：$1（使用 --help 查看用法）"
      ;;
  esac
done

[ "$(uname -s)" = "Darwin" ] || die "此流程只能在 macOS 上运行"
case "$timeout_minutes" in
  ''|*[!0-9]*) die "--timeout-minutes 必须是正整数" ;;
esac
[ "$timeout_minutes" -gt 0 ] || die "--timeout-minutes 必须大于 0"
if [ -n "$run_id" ]; then
  case "$run_id" in
    ''|*[!0-9]*) die "--run-id 必须是数字" ;;
  esac
fi
case "$install_dir" in
  /*) ;;
  *) die "--install-dir 必须是绝对路径" ;;
esac
[ "$install_dir" != "/" ] || die "拒绝把 App 安装目录设为根目录"

require_command gh
require_command hdiutil
require_command ditto
require_command find
require_command sed
require_command open

if ! gh auth status >/dev/null 2>&1; then
  die "GitHub CLI 尚未登录，请先运行 gh auth login"
fi

if [ -z "$repo" ]; then
  repo="$(gh repo view --json nameWithOwner --jq '.nameWithOwner')" \
    || die "无法从当前目录推断 GitHub 仓库，请使用 --repo OWNER/REPO"
fi

if [ -z "$run_id" ]; then
  target_sha="$(gh api "repos/$repo/commits/$ref" --jq '.sha')" \
    || die "无法解析 $repo@$ref"
  before_run_id="$(gh run list \
    --repo "$repo" \
    --workflow "$WORKFLOW" \
    --branch "$ref" \
    --limit 20 \
    --json databaseId,headSha,event \
    --jq '[.[] | select(.event == "workflow_dispatch" and .headSha == "'"$target_sha"'")] | if length == 0 then 0 else max_by(.databaseId).databaseId end')"

  printf '触发 macOS-only 构建：%s@%s\n' "$repo" "$ref"
  dispatch_url="$(gh workflow run "$WORKFLOW" \
    --repo "$repo" \
    --ref "$ref" \
    -f build_android=false \
    -f build_ios=false \
    -f build_mac=true \
    -f build_win_x64=false \
    -f build_linux_x64=false \
    -f tag=)" \
    || die "无法触发 GitHub Actions"
  [ -n "$dispatch_url" ] && printf '调度地址：%s\n' "$dispatch_url"

  run_id=""
  discovery_deadline=$((SECONDS + 120))
  while [ "$SECONDS" -lt "$discovery_deadline" ]; do
    candidate="$(gh run list \
      --repo "$repo" \
      --workflow "$WORKFLOW" \
      --branch "$ref" \
      --limit 20 \
      --json databaseId,headSha,event \
      --jq '[.[] | select(.event == "workflow_dispatch" and .headSha == "'"$target_sha"'")] | if length == 0 then empty else max_by(.databaseId).databaseId end')"
    if [ -n "$candidate" ] && [ "$candidate" != "$before_run_id" ]; then
      run_id="$candidate"
      break
    fi
    sleep 5
  done
  [ -n "$run_id" ] || die "已触发构建，但在 120 秒内没有找到对应运行记录"
else
  printf '使用已有 Actions 运行：%s\n' "$run_id"
fi

run_url="$(gh run view "$run_id" --repo "$repo" --json url --jq '.url')"
printf 'Actions 运行：%s\n' "$run_url"

deadline=$((SECONDS + timeout_minutes * 60))
last_status=""
while [ "$SECONDS" -lt "$deadline" ]; do
  status="$(gh run view "$run_id" --repo "$repo" --json status --jq '.status')"
  if [ "$status" != "$last_status" ]; then
    printf '当前状态：%s\n' "$status"
    last_status="$status"
  fi
  if [ "$status" = "completed" ]; then
    conclusion="$(gh run view "$run_id" --repo "$repo" --json conclusion --jq '.conclusion')"
    [ "$conclusion" = "success" ] \
      || die "Actions 构建未成功（结论：$conclusion），详情：$run_url"
    break
  fi
  sleep 15
done

final_status="$(gh run view "$run_id" --repo "$repo" --json status --jq '.status')"
[ "$final_status" = "completed" ] || die "等待 Actions 超时，详情：$run_url"

tmp_root="${TMPDIR:-/tmp}"
staging_dir="$(mktemp -d "$tmp_root/expiliplus-actions.XXXXXX")"
mount_dir="$staging_dir/mount"
artifact_dir="$staging_dir/artifact"
mkdir -p "$mount_dir" "$artifact_dir"
mounted=0
install_tmp=""
backup_path=""

cleanup() {
  if [ "$mounted" -eq 1 ]; then
    hdiutil detach "$mount_dir" -quiet >/dev/null 2>&1 || true
  fi
  if [ -n "$install_tmp" ] && [ -e "$install_tmp" ]; then
    rm -rf "$install_tmp"
  fi
  if [ -n "$staging_dir" ] && [ -d "$staging_dir" ]; then
    rm -rf "$staging_dir"
  fi
}
trap cleanup EXIT
trap 'exit 130' INT TERM

printf '下载 macOS DMG 产物……\n'
gh run download "$run_id" \
  --repo "$repo" \
  --name "$ARTIFACT" \
  --dir "$artifact_dir" \
  || die "无法下载 macOS 构建产物"

dmg_path="$(find "$artifact_dir" -type f -name '*.dmg' -print | sed -n '1p')"
dmg_count="$(find "$artifact_dir" -type f -name '*.dmg' -print | wc -l | tr -d ' ')"
[ "$dmg_count" = "1" ] || die "产物中应有且只有一个 DMG，实际为 $dmg_count 个"
[ -n "$dmg_path" ] || die "没有找到 DMG 文件"
hdiutil imageinfo "$dmg_path" >/dev/null \
  || die "DMG 校验失败：$dmg_path"

mkdir -p "$download_dir"
base_name="$(basename "$dmg_path")"
saved_dmg="$download_dir/$base_name"
if [ -e "$saved_dmg" ]; then
  stem="$(printf '%s' "$base_name" | sed 's/\.dmg$//')"
  saved_dmg="$download_dir/$stem"_run-"$run_id".dmg
fi
ditto "$dmg_path" "$saved_dmg"
printf 'DMG 已保存：%s\n' "$saved_dmg"

printf '挂载 DMG 并准备安装……\n'
hdiutil attach -nobrowse -readonly -mountpoint "$mount_dir" "$dmg_path" >/dev/null \
  || die "无法挂载 DMG"
mounted=1
app_source="$(find "$mount_dir" -type d -name 'ExPiliplus.app' -print | sed -n '1p')"
[ -n "$app_source" ] || die "DMG 中没有找到 ExPiliplus.app"

mkdir -p "$install_dir"
destination="$install_dir/ExPiliplus.app"
install_tmp="$install_dir/.ExPiliplus.app.install-$run_id-$$"
ditto "$app_source" "$install_tmp" \
  || die "无法复制新的 App"

if [ -e "$destination" ] || [ -L "$destination" ]; then
  osascript -e 'tell application "ExPiliplus" to quit' >/dev/null 2>&1 || true
  backup_path="$install_dir/ExPiliplus.app.backup-$run_id"
  if [ -e "$backup_path" ] || [ -L "$backup_path" ]; then
    backup_path="$install_dir/ExPiliplus.app.backup-$run_id-$(date +%s)"
  fi
  mv "$destination" "$backup_path" \
    || die "无法备份现有 App：$destination"
fi

if ! mv "$install_tmp" "$destination"; then
  if [ -n "$backup_path" ] && [ -e "$backup_path" ]; then
    mv "$backup_path" "$destination" || true
  fi
  die "无法完成 App 安装：$destination"
fi
install_tmp=""
if hdiutil detach "$mount_dir" -quiet >/dev/null 2>&1; then
  mounted=0
fi

printf '已安装：%s\n' "$destination"
if [ -n "$backup_path" ]; then
  printf '旧版本备份：%s\n' "$backup_path"
fi
if [ "$launch_app" -eq 1 ]; then
  open "$destination"
  printf '已请求启动应用。若首次打开被 Gatekeeper 拦截，请在 Finder 中右键该 App 并选择“打开”；此脚本不会绕过系统安全检查。\n'
fi
