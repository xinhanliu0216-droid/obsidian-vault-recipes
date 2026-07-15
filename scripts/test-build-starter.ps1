$ErrorActionPreference = 'Stop'

$tempRoot = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath())
$testName = "obsidian-vault-recipes-archive-$([guid]::NewGuid().ToString('N'))"
$testRoot = Join-Path $tempRoot $testName
$archive = Join-Path $testRoot 'starter.zip'
$expanded = Join-Path $testRoot 'expanded'
$builder = Join-Path $PSScriptRoot 'build-starter.ps1'

try {
    New-Item -ItemType Directory -Path $testRoot | Out-Null
    & $builder -OutputPath $archive -Scenario research

    if (-not (Test-Path -LiteralPath $archive)) {
        throw 'Starter archive was not created.'
    }
    Expand-Archive -LiteralPath $archive -DestinationPath $expanded

    foreach ($path in @(
        'CLAUDE.md',
        'START-HERE.md',
        'raw',
        'wiki/sources',
        '_templates/source.md',
        '.claude/skills/wiki-query/SKILL.md'
    )) {
        if (-not (Test-Path -LiteralPath (Join-Path $expanded $path))) {
            throw "Starter archive is missing: $path"
        }
    }
    $claude = Get-Content -LiteralPath (Join-Path $expanded 'CLAUDE.md') -Raw -Encoding UTF8
    if ($claude -notmatch 'paper' -or $claude -match '\{\{[A-Z_]+\}\}') {
        throw 'Starter archive has unresolved rules or template markers.'
    }

    Write-Host 'build-starter.ps1 smoke test passed.' -ForegroundColor Green
} finally {
    $resolved = [System.IO.Path]::GetFullPath($testRoot)
    $safeName = [System.IO.Path]::GetFileName($resolved)
    if (
        $resolved.StartsWith($tempRoot, [System.StringComparison]::OrdinalIgnoreCase) -and
        $safeName.StartsWith('obsidian-vault-recipes-archive-', [System.StringComparison]::Ordinal)
    ) {
        if (Test-Path -LiteralPath $resolved) {
            Remove-Item -LiteralPath $resolved -Recurse -Force
        }
    } else {
        throw "Refusing to clean unexpected test path: $resolved"
    }
}
