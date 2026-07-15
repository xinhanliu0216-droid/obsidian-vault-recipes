[CmdletBinding()]
param(
    [string]$OutputPath = (Join-Path (Split-Path -Parent $PSScriptRoot) 'dist/obsidian-vault-recipes-starter.zip'),
    [ValidateSet('general', 'course', 'research', 'product', 'project', 'personal', 'book')]
    [string]$Scenario = 'general',
    [string]$VaultName = 'My LLM Wiki',
    [string]$Goal = 'Organize local sources into a traceable, reusable knowledge base',
    [string]$PrimaryOutput = 'Reliable Wiki pages, answers, and synthesis',
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$initializer = Join-Path $PSScriptRoot 'new-vault.ps1'
$resolvedOutput = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($OutputPath)
$outputDirectory = Split-Path -Parent $resolvedOutput
$tempRoot = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath())
$stageName = "obsidian-vault-recipes-package-$([guid]::NewGuid().ToString('N'))"
$stageRoot = Join-Path $tempRoot $stageName

if ((Test-Path -LiteralPath $resolvedOutput) -and -not $Force) {
    throw "Output already exists: $resolvedOutput. Rerun with -Force to replace it."
}

try {
    & $initializer `
        -Destination $stageRoot `
        -VaultName $VaultName `
        -Goal $Goal `
        -PrimaryOutput $PrimaryOutput `
        -Scenario $Scenario `
        -IncludeSkills

    Copy-Item `
        -LiteralPath (Join-Path (Split-Path -Parent $PSScriptRoot) 'templates/START-HERE.md') `
        -Destination (Join-Path $stageRoot 'START-HERE.md')

    New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
    if (Test-Path -LiteralPath $resolvedOutput) {
        Remove-Item -LiteralPath $resolvedOutput -Force
    }
    $archiveItems = @(Get-ChildItem -LiteralPath $stageRoot -Force)
    Compress-Archive -LiteralPath $archiveItems.FullName -DestinationPath $resolvedOutput
    Write-Host "Built Starter Vault: $resolvedOutput" -ForegroundColor Green
} finally {
    $resolvedStage = [System.IO.Path]::GetFullPath($stageRoot)
    $safeName = [System.IO.Path]::GetFileName($resolvedStage)
    if (
        $resolvedStage.StartsWith($tempRoot, [System.StringComparison]::OrdinalIgnoreCase) -and
        $safeName.StartsWith('obsidian-vault-recipes-package-', [System.StringComparison]::Ordinal)
    ) {
        if (Test-Path -LiteralPath $resolvedStage) {
            Remove-Item -LiteralPath $resolvedStage -Recurse -Force
        }
    } else {
        throw "Refusing to clean unexpected staging path: $resolvedStage"
    }
}
