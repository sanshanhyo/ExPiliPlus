param(
    [string]$Platform = '',
    [string]$Tag = ''
)

try {
    $releaseVersion = $null
    $versionCode = [int](git rev-list --count HEAD).Trim()
    $commitHash = (git rev-parse HEAD).Trim()

    $updatedContent = foreach ($line in (Get-Content -Path 'pubspec.yaml' -Encoding UTF8)) {
        if ($line -match '^\s*version:\s*([0-9]+\.[0-9]+\.[0-9]+(?:-[0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*)?)\+([0-9]+)\s*$') {
            $releaseVersion = $matches[1]
            "version: $releaseVersion+$versionCode"
        }
        else {
            $line
        }
    }

    if ($null -eq $releaseVersion) {
        throw 'semantic version not found in pubspec.yaml'
    }

    $upstreamVersion = (Get-Content -Path 'UPSTREAM_VERSION' -Raw -Encoding UTF8).Trim()
    if ($upstreamVersion -notmatch '^[0-9]+\.[0-9]+\.[0-9]+$') {
        throw "invalid upstream version: $upstreamVersion"
    }

    $normalizedTag = $Tag.Trim()
    $isRelease = -not [string]::IsNullOrWhiteSpace($normalizedTag)
    if ($isRelease -and $normalizedTag -ne "v$releaseVersion") {
        throw "release tag '$Tag' does not match pubspec version 'v$releaseVersion'"
    }

    $displayVersion = if ($isRelease) {
        $releaseVersion
    }
    else {
        "$releaseVersion+build.$versionCode"
    }

    $updatedContent | Set-Content -Path 'pubspec.yaml' -Encoding UTF8

    $buildTime = [int]([DateTimeOffset]::Now.ToUnixTimeSeconds())
    $data = @{
        'pili.name' = $displayVersion
        'pili.code' = $versionCode
        'pili.upstream' = $upstreamVersion
        'pili.release' = $isRelease
        'pili.hash' = $commitHash
        'pili.time' = $buildTime
    }

    $data | ConvertTo-Json -Compress | Out-File 'pili_release.json' -Encoding UTF8

    if (-not [string]::IsNullOrWhiteSpace($env:GITHUB_ENV)) {
        Add-Content -Path $env:GITHUB_ENV -Value "version=$displayVersion"
        $isPrerelease = $releaseVersion.Contains('-').ToString().ToLowerInvariant()
        Add-Content -Path $env:GITHUB_ENV -Value "is_prerelease=$isPrerelease"
    }
}
catch {
    Write-Error "Prebuild Error: $($_.Exception.Message)"
    exit 1
}
