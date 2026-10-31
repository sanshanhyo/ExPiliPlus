# Run from the repository root: pwsh -NoProfile -File test/scripts/ios_patches_test.ps1
# Uses real app sources and git apply; no Flutter SDK, macOS or Pester required.
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path "$PSScriptRoot/../..").Path
$script = Join-Path $root 'lib/scripts/apply_ios_patches.ps1'
$fixture = Join-Path ([System.IO.Path]::GetTempPath()) "expiliplus-ios-$([guid]::NewGuid())"
$files = @('lib/pages/common/slide/common_slide_page.dart',
           'lib/pages/login/geetest/geetest_webview_dialog.dart', 'pubspec.yaml')
function Assert-True($Condition, [string]$Description) {
    if (-not $Condition) { throw $Description }
}
function Reset-Fixture {
    foreach ($file in $files) {
        $target = Join-Path $fixture $file
        New-Item -ItemType Directory -Force (Split-Path $target) | Out-Null
        Copy-Item (Join-Path $root $file) $target -Force
    }
    Remove-Item "$fixture/lib/pages/login/geetest/geetest_plugin.dart" -ErrorAction SilentlyContinue
}
try {
    New-Item -ItemType Directory $fixture | Out-Null
    git -C $fixture init --quiet
    Assert-True ($LASTEXITCODE -eq 0) 'fixture git init'
    Reset-Fixture
    foreach ($name in @('bottom_sheet_ios_piliplus.patch', 'geetest_ios.patch')) {
        $patch = Join-Path $root "lib/scripts/$name"
        git -C $fixture apply --check $patch
        Assert-True ($LASTEXITCODE -eq 0) "$name git apply --check"
        git -C $fixture apply $patch
        Assert-True ($LASTEXITCODE -eq 0) "$name git apply"
        git -C $fixture apply --reverse --check $patch
        Assert-True ($LASTEXITCODE -eq 0) "$name reverse check"
    }
    $dialog = Get-Content "$fixture/lib/pages/login/geetest/geetest_webview_dialog.dart" -Raw
    Assert-True ($dialog.Contains("import 'package:ex_piliplus/pages/login/geetest/geetest_plugin.dart';")) 'native plugin import'
    Assert-True ($dialog -match 'if \(Platform.isIOS\) \{\s+return GeetestPlugin.geetest\(gt, challenge\);\s+\}\s+return showDialog') 'iOS native path and reachable WebView fallback'
    $plugin = Get-Content "$fixture/lib/pages/login/geetest/geetest_plugin.dart" -Raw
    foreach ($marker in @('onClose:', 'onResult:', 'onError:', 'completer.isCompleted', '..startCaptcha(registerData)')) {
        Assert-True ($plugin.Contains($marker)) "preserve captcha behavior: $marker"
    }
    Assert-True ((Get-Content "$fixture/pubspec.yaml" -Raw).Contains('gt3_flutter_plugin: ^0.1.0')) 'native dependency'

    # Run the same entrypoint used by patch.ps1, including retries.
    Reset-Fixture
    & $script -RepositoryRoot $fixture
    $before = @(Get-ChildItem $fixture -Recurse -File | Where-Object FullName -NotMatch '/\.git/' | Get-FileHash | ForEach-Object Hash) -join ','
    & $script -RepositoryRoot $fixture
    $after = @(Get-ChildItem $fixture -Recurse -File | Where-Object FullName -NotMatch '/\.git/' | Get-FileHash | ForEach-Object Hash) -join ','
    Assert-True ($before -ceq $after) 'repeat invocation must not change patched files'

    # Recover from the exact CI interruption: bottom-sheet applied, geetest pending.
    Reset-Fixture
    git -C $fixture apply "$root/lib/scripts/bottom_sheet_ios_piliplus.patch"
    Assert-True ($LASTEXITCODE -eq 0) 'partial-run fixture'
    & $script -RepositoryRoot $fixture
    Assert-True (Test-Path "$fixture/lib/pages/login/geetest/geetest_plugin.dart") 'partial-run recovery'

    # Conflicts must fail closed, before applying even the valid bottom-sheet patch.
    Reset-Fixture
    $dialogPath = "$fixture/lib/pages/login/geetest/geetest_webview_dialog.dart"
    (Get-Content $dialogPath -Raw).Replace('    return showDialog<Map<String, dynamic>>(', '    return incompatibleDialog<Map<String, dynamic>>(') | Set-Content $dialogPath
    $before = (Get-FileHash "$fixture/lib/pages/common/slide/common_slide_page.dart").Hash
    $rejected = $false
    try { & $script -RepositoryRoot $fixture } catch {
        if ($_.Exception.Message -notmatch 'Cannot apply geetest_ios.patch cleanly') { throw }
        $rejected = $true
    }
    Assert-True $rejected 'conflicting source must fail, not silently skip'
    Assert-True ($before -ceq (Get-FileHash "$fixture/lib/pages/common/slide/common_slide_page.dart").Hash) 'preflight must prevent partial app modifications'
    Assert-True (-not (Test-Path "$fixture/lib/pages/login/geetest/geetest_plugin.dart")) 'conflicting patch must not create plugin'
    Write-Output 'PASS: iOS patches apply/reverse, native behavior, retries, interrupted-run recovery and conflict rejection'
} finally {
    Remove-Item -Recurse -Force $fixture
}
