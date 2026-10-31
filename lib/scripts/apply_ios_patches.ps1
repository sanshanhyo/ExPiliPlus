# App-local patches are separate from Flutter SDK patches so they can be
# validated without an SDK and safely retried after an interrupted build.
param(
    [string]$RepositoryRoot = (Join-Path $PSScriptRoot '../..')
)
$ErrorActionPreference = 'Stop'
$pending = @()
foreach ($name in @('bottom_sheet_ios_piliplus.patch', 'geetest_ios.patch')) {
    $patch = Join-Path $PSScriptRoot $name
    git -C $RepositoryRoot apply --check $patch 2>$null
    if ($LASTEXITCODE -eq 0) {
        $pending += $patch
        continue
    }
    git -C $RepositoryRoot apply --reverse --check $patch 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "$name already applied"
    } else {
        throw "Cannot apply $name cleanly (not already applied). Resolve the source/patch mismatch before retrying."
    }
}
# Preflight every patch before modifying any app files.
foreach ($patch in $pending) {
    git -C $RepositoryRoot apply $patch
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to apply $patch (exit $LASTEXITCODE)"
    }
    Write-Host "$patch applied"
}
