# Run from the repository root: pwsh -NoProfile -File test/scripts/build_version_test.ps1
# No Flutter SDK or Pester dependency; invoke the real prebuild in an isolated repo.
$ErrorActionPreference = 'Stop'
$buildScript = (Resolve-Path "$PSScriptRoot/../../lib/scripts/build.ps1").Path
$pwsh = (Get-Process -Id $PID).Path
$fixture = Join-Path ([System.IO.Path]::GetTempPath()) "expiliplus-version-$([guid]::NewGuid())"
$previousGithubEnv = $env:GITHUB_ENV
$cases = @(
    @{ Upstream = '2.1.6'; Version = '1.0.0-dev.3'; Tag = ''; Valid = $true },
    @{ Upstream = '2.1.6.2'; Version = '1.0.0-dev.3'; Tag = ''; Valid = $true },
    @{ Upstream = '2.1.6.2'; Version = '1.0.0'; Tag = ''; Valid = $true },
    @{ Upstream = '2.1.6.2'; Version = '1.0.0'; Tag = 'v1.0.0'; Valid = $true },
    @{ Upstream = '2.1.6.2'; Version = '1.0.0-dev.3'; Tag = 'v1.0.0-dev.3'; Valid = $true },
    @{ Upstream = '2.1.6.2'; Version = '1.0.0.1'; Tag = ''; Valid = $false; Error = 'semantic version not found' },
    @{ Upstream = '2.1.6.2'; Version = '1.0.0-dev.3'; Tag = 'v2.1.6.2'; Valid = $false; Error = 'does not match pubspec version' }
)
foreach ($upstream in @('', '2.1', '2.1.6.2.1', '2..6.2', '2.1.6.', 'v2.1.6.2', '2.1.6.x', '2.1.6.2-dev.1', '2.1.6.2+1', '-2.1.6.2', '2.1.6. 2', "2.1.6`n2")) {
    $cases += @{ Upstream = $upstream; Version = '1.0.0-dev.3'; Tag = ''; Valid = $false; Error = 'invalid upstream version' }
}

function Assert-Equal($Actual, $Expected, [string]$Description) {
    if ($Actual -cne $Expected) {
        throw "$Description`: expected '$Expected', got '$Actual'"
    }
}

New-Item -ItemType Directory -Path $fixture | Out-Null
Push-Location $fixture
try {
    git init --quiet
    if ($LASTEXITCODE -ne 0) { throw 'fixture git init failed' }
    git -c user.name=VersionTest -c user.email=version-test@example.invalid -c commit.gpgsign=false commit --allow-empty --quiet -m fixture
    if ($LASTEXITCODE -ne 0) { throw 'fixture git commit failed' }
    $hash = (git rev-parse HEAD).Trim()
    $env:GITHUB_ENV = Join-Path $fixture 'github-env'

    foreach ($case in $cases) {
        $originalPubspec = "name: version_fixture`nversion: $($case.Version)+99"
        Set-Content pubspec.yaml $originalPubspec
        Set-Content UPSTREAM_VERSION $case.Upstream
        Remove-Item pili_release.json, $env:GITHUB_ENV -ErrorAction SilentlyContinue
        $output = & $pwsh -NoProfile -File $buildScript -Platform android -Tag $case.Tag 2>&1 | Out-String
        $status = $LASTEXITCODE
        if (-not $case.Valid) {
            if ($status -eq 0 -or $output -notmatch [regex]::Escape($case.Error)) {
                throw "Expected rejection ($($case.Error)) for $($case | ConvertTo-Json -Compress): $output"
            }
            Assert-Equal (Test-Path pili_release.json) $false 'invalid input must not emit metadata'
            Assert-Equal (Test-Path $env:GITHUB_ENV) $false 'invalid input must not emit CI environment'
            Assert-Equal (Get-Content pubspec.yaml -Raw).Trim() $originalPubspec 'invalid input must not rewrite pubspec'
            continue
        }
        Assert-Equal $status 0 "prebuild exit ($($case.Upstream))"
        $metadata = Get-Content pili_release.json -Raw | ConvertFrom-Json
        $isRelease = $case.Tag -ne ''
        $display = if ($isRelease) { $case.Version } else { "$($case.Version)+build.1" }
        Assert-Equal $metadata.'pili.upstream' $case.Upstream 'full upstream provenance'
        Assert-Equal $metadata.'pili.name' $display 'independent ExP display version'
        Assert-Equal $metadata.'pili.release' $isRelease 'release flag'
        Assert-Equal $metadata.'pili.code' 1 'commit-count build number'
        Assert-Equal $metadata.'pili.hash' $hash 'commit provenance'
        Assert-Equal ((Get-Content pubspec.yaml) -join "`n") "name: version_fixture`nversion: $($case.Version)+1" 'ExP pubspec version'
        $ci = Get-Content $env:GITHUB_ENV
        Assert-Equal ($ci -contains "version=$display") $true 'CI display version'
        Assert-Equal ($ci -contains 'native_version=1.0.0') $true 'three-part native version'
        Assert-Equal ($ci -contains 'version_code=1') $true 'CI build number'
        $prerelease = $case.Version.Contains('-').ToString().ToLowerInvariant()
        Assert-Equal ($ci -contains "is_prerelease=$prerelease") $true 'prerelease flag'
    }
    Write-Output "PASS: $($cases.Count) build-version cases"
}
finally {
    $env:GITHUB_ENV = $previousGithubEnv
    Pop-Location
    Remove-Item -Recurse -Force $fixture
}
