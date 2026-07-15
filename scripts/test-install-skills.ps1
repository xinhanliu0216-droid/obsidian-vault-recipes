$ErrorActionPreference = 'Stop'

$tempRoot = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath())
$testName = "obsidian-vault-recipes-skills-$([guid]::NewGuid().ToString('N'))"
$testRoot = Join-Path $tempRoot $testName
$installer = Join-Path (Split-Path -Parent $PSScriptRoot) 'skills/install-skills.ps1'
$expected = @(
    'wiki-butler',
    'wiki-init',
    'wiki-ingest',
    'wiki-build',
    'wiki-query',
    'wiki-specialize',
    'wiki-formal',
    'wiki-lint',
    'wiki-diagnose'
)

try {
    & $installer -Destination $testRoot

    $installed = @(Get-ChildItem -LiteralPath $testRoot -Directory -Filter 'wiki-*')
    if ($installed.Count -ne $expected.Count) {
        throw "Expected $($expected.Count) skills, found $($installed.Count)."
    }
    foreach ($name in $expected) {
        if (-not (Test-Path -LiteralPath (Join-Path $testRoot "$name/SKILL.md"))) {
            throw "Installed skill is missing SKILL.md: $name"
        }
    }

    $refusedOverwrite = $false
    try {
        & $installer -Destination $testRoot
    } catch {
        $refusedOverwrite = $true
    }
    if (-not $refusedOverwrite) {
        throw 'Installer did not refuse existing skill directories.'
    }

    & $installer -Destination $testRoot -Force
    Write-Host 'install-skills.ps1 smoke test passed.' -ForegroundColor Green
} finally {
    $resolved = [System.IO.Path]::GetFullPath($testRoot)
    $safeName = [System.IO.Path]::GetFileName($resolved)
    if (
        $resolved.StartsWith($tempRoot, [System.StringComparison]::OrdinalIgnoreCase) -and
        $safeName.StartsWith('obsidian-vault-recipes-skills-', [System.StringComparison]::Ordinal)
    ) {
        if (Test-Path -LiteralPath $resolved) {
            Remove-Item -LiteralPath $resolved -Recurse -Force
        }
    } else {
        throw "Refusing to clean unexpected test path: $resolved"
    }
}
