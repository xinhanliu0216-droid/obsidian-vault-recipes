$ErrorActionPreference = 'Stop'

$tempRoot = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath())
$testName = "obsidian-vault-recipes-$([guid]::NewGuid().ToString('N'))"
$testRoot = Join-Path $tempRoot $testName
$initializer = Join-Path $PSScriptRoot 'new-vault.ps1'

try {
    $initParams = @{
        Destination = $testRoot
        VaultName = 'Smoke Test Vault'
        Goal = 'Verify deterministic initialization'
        PrimaryOutput = 'A valid empty LLM Wiki'
        Scenario = 'course'
    }
    & $initializer @initParams

    $required = @(
        'CLAUDE.md',
        'index.md',
        'log.md',
        'raw',
        'raw/assets',
        'wiki/sources',
        'wiki/entities',
        'wiki/concepts',
        'wiki/topics',
        'wiki/synthesis',
        '_templates/source.md',
        '_templates/concept.md',
        '_templates/entity.md',
        '_templates/topic.md',
        '_templates/synthesis.md'
    )

    foreach ($path in $required) {
        if (-not (Test-Path -LiteralPath (Join-Path $testRoot $path))) {
            throw "Initializer missed required path: $path"
        }
    }

    $claude = Get-Content -LiteralPath (Join-Path $testRoot 'CLAUDE.md') -Raw -Encoding UTF8
    foreach ($marker in @('{{VAULT_NAME}}', '{{VAULT_GOAL}}', '{{PRIMARY_OUTPUT}}', '{{SCENARIO_RULES}}')) {
        if ($claude.Contains($marker)) {
            throw "Unresolved template marker: $marker"
        }
    }
    if ($claude -notmatch 'question') {
        throw 'Course scenario rules were not merged.'
    }

    $refusedOverwrite = $false
    try {
        $secondParams = @{
            Destination = $testRoot
            VaultName = 'Second Vault'
            Goal = 'This must fail'
            PrimaryOutput = 'None'
            Scenario = 'general'
        }
        & $initializer @secondParams
    } catch {
        $refusedOverwrite = $true
    }
    if (-not $refusedOverwrite) {
        throw 'Initializer did not refuse a non-empty destination.'
    }

    Write-Host 'new-vault.ps1 smoke test passed.' -ForegroundColor Green
} finally {
    $resolved = [System.IO.Path]::GetFullPath($testRoot)
    $safeName = [System.IO.Path]::GetFileName($resolved)
    if (
        $resolved.StartsWith($tempRoot, [System.StringComparison]::OrdinalIgnoreCase) -and
        $safeName.StartsWith('obsidian-vault-recipes-', [System.StringComparison]::Ordinal)
    ) {
        if (Test-Path -LiteralPath $resolved) {
            Remove-Item -LiteralPath $resolved -Recurse -Force
        }
    } else {
        throw "Refusing to clean unexpected test path: $resolved"
    }
}
