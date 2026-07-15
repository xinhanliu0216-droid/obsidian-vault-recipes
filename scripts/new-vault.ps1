[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$Destination,

    [Parameter(Mandatory)]
    [string]$VaultName,

    [Parameter(Mandatory)]
    [string]$Goal,

    [Parameter(Mandatory)]
    [string]$PrimaryOutput,

    [ValidateSet('general', 'course', 'research', 'product', 'project', 'personal', 'book')]
    [string]$Scenario = 'general',

    [switch]$IncludeSkills
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$destinationPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Destination)

if (Test-Path -LiteralPath $destinationPath) {
    $existing = @(Get-ChildItem -LiteralPath $destinationPath -Force)
    if ($existing.Count -gt 0) {
        throw "Destination must be empty: $destinationPath"
    }
} else {
    New-Item -ItemType Directory -Path $destinationPath | Out-Null
}

function Write-Utf8File {
    param(
        [string]$Path,
        [string]$Content
    )

    $encoding = [System.Text.UTF8Encoding]::new($false)
    [System.IO.File]::WriteAllText($Path, $Content, $encoding)
}

$directories = @(
    'raw',
    'raw/assets',
    'wiki/sources',
    'wiki/entities',
    'wiki/concepts',
    'wiki/topics',
    'wiki/synthesis',
    '_templates'
)

foreach ($directory in $directories) {
    New-Item -ItemType Directory -Path (Join-Path $destinationPath $directory) | Out-Null
}

$claudeTemplate = Get-Content -LiteralPath (Join-Path $repoRoot 'templates/CLAUDE.md') -Raw -Encoding UTF8
$claudeContent = $claudeTemplate.
    Replace('{{VAULT_NAME}}', $VaultName).
    Replace('{{VAULT_GOAL}}', $Goal).
    Replace('{{PRIMARY_OUTPUT}}', $PrimaryOutput)

$scenarioPath = Join-Path $repoRoot "templates/scenarios/$Scenario.md"
$scenarioContent = (Get-Content -LiteralPath $scenarioPath -Raw -Encoding UTF8).Trim()
$claudeContent = $claudeContent.Replace('{{SCENARIO_RULES}}', $scenarioContent)

$today = Get-Date -Format 'yyyy-MM-dd'
$indexContent = (Get-Content -LiteralPath (Join-Path $repoRoot 'templates/index.md') -Raw -Encoding UTF8).
    Replace('YYYY-MM-DD', $today)
$logContent = (Get-Content -LiteralPath (Join-Path $repoRoot 'templates/log.md') -Raw -Encoding UTF8).
    Replace('YYYY-MM-DD', $today)

Write-Utf8File -Path (Join-Path $destinationPath 'CLAUDE.md') -Content $claudeContent
Write-Utf8File -Path (Join-Path $destinationPath 'index.md') -Content $indexContent
Write-Utf8File -Path (Join-Path $destinationPath 'log.md') -Content $logContent

Get-ChildItem -LiteralPath (Join-Path $repoRoot 'templates/pages') -File -Filter '*.md' |
    ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination (Join-Path $destinationPath '_templates')
    }

if ($IncludeSkills) {
    $skillsTarget = Join-Path $destinationPath '.claude/skills'
    New-Item -ItemType Directory -Path $skillsTarget -Force | Out-Null
    Get-ChildItem -LiteralPath (Join-Path $repoRoot 'skills') -Directory -Filter 'wiki-*' |
        ForEach-Object {
            Copy-Item -LiteralPath $_.FullName -Destination $skillsTarget -Recurse
        }
}

Write-Host "Created Vault: $destinationPath" -ForegroundColor Green
Write-Host "Scenario: $Scenario"
Write-Host "Bundled skills: $IncludeSkills"
Write-Host 'Next: open this folder in Obsidian, add one source under raw/, then ask the Agent for an ingest plan.'
