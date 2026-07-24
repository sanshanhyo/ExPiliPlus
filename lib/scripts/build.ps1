param(
    [string]$Arg = ''
)

try {
    $flutterVersionName = $null
    $displayVersionName = $null
    $artifactVersionName = $null

    $versionCode = [int](git rev-list --count HEAD).Trim()

    $commitHash = (git rev-parse HEAD).Trim()

    $updatedContent = foreach ($line in (Get-Content -Path 'pubspec.yaml' -Encoding UTF8)) {
        if ($line -match '^\s*version:\s*([0-9]+(?:\.[0-9]+){2})\+([0-9]+)\s*$') {
            $flutterVersionName = $matches[1]
            $displayVersionName = "$flutterVersionName-ex.$($matches[2])"
            $artifactVersionName = $displayVersionName
            if ($Arg -eq 'android') {
                $artifactVersionName += '-' + $commitHash.Substring(0, 9)
            }
            "version: $flutterVersionName+$versionCode"
        }
        else {
            $line
        }
    }

    if ($null -eq $displayVersionName) {
        throw 'version not found'
    }

    $updatedContent | Set-Content -Path 'pubspec.yaml' -Encoding UTF8

    $buildTime = [int]([DateTimeOffset]::Now.ToUnixTimeSeconds())

    $data = @{
        'pili.name' = $displayVersionName
        'pili.code' = $versionCode
        'pili.hash' = $commitHash
        'pili.time' = $buildTime
    }

    $data | ConvertTo-Json -Compress | Out-File 'pili_release.json' -Encoding UTF8

    Add-Content -Path $env:GITHUB_ENV -Value "version=$artifactVersionName+$versionCode"
}
catch {
    Write-Error "Prebuild Error: $($_.Exception.Message)"
    exit 1
}
