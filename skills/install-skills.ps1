param(
    [string]$Destination = (Join-Path $HOME '.claude/skills'),
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$source = $PSScriptRoot
$skillDirs = Get-ChildItem -LiteralPath $source -Directory -Filter 'wiki-*'

if ($skillDirs.Count -eq 0) {
    throw "No wiki-* skill directories found in $source"
}

New-Item -ItemType Directory -Path $Destination -Force | Out-Null

# Preflight every target before copying so a failed install never leaves a partial result.
foreach ($skill in $skillDirs) {
    $target = Join-Path $Destination $skill.Name
    if ((Test-Path -LiteralPath $target) -and -not $Force) {
        throw "Skill already exists: $target. Review it, then rerun with -Force to replace matching files."
    }
}

foreach ($skill in $skillDirs) {
    $entry = Join-Path $skill.FullName 'SKILL.md'
    if (-not (Test-Path -LiteralPath $entry)) {
        throw "Missing SKILL.md: $($skill.FullName)"
    }

    $target = Join-Path $Destination $skill.Name
    New-Item -ItemType Directory -Path $target -Force | Out-Null
    Copy-Item -Path (Join-Path $skill.FullName '*') -Destination $target -Recurse -Force
    Write-Host "Installed $($skill.Name) -> $target"
}

Write-Host "Installed $($skillDirs.Count) LLM Wiki skills."
