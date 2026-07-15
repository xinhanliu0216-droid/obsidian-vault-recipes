[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$VaultPath,
    [string]$OutputPath
)

$ErrorActionPreference = 'Stop'
$vault = [IO.Path]::GetFullPath($VaultPath)
if (-not (Test-Path -LiteralPath $vault -PathType Container)) {
    throw "Vault does not exist: $vault"
}

$wikiPath = Join-Path $vault 'wiki'
$pages = if (Test-Path -LiteralPath $wikiPath) {
    @(Get-ChildItem -LiteralPath $wikiPath -Recurse -File -Filter '*.md')
} else { @() }
$allMarkdown = @(Get-ChildItem -LiteralPath $vault -Recurse -File -Filter '*.md')
$titleToPath = @{}
foreach ($file in $allMarkdown) {
    $titleToPath[$file.BaseName.ToLowerInvariant()] = $file.FullName
}

$brokenLinks = [Collections.Generic.List[string]]::new()
$orphanPages = [Collections.Generic.List[string]]::new()
$unverifiedPages = [Collections.Generic.List[string]]::new()
$stalePages = [Collections.Generic.List[string]]::new()
$duplicateTitles = $pages | Group-Object { $_.BaseName.ToLowerInvariant() } | Where-Object Count -gt 1
$cutoff = (Get-Date).AddDays(-180)

foreach ($file in $pages) {
    $content = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    $links = [regex]::Matches($content, '\[\[(?<target>[^\]|#]+)')
    $validLinkCount = 0
    foreach ($link in $links) {
        $target = $link.Groups['target'].Value.Trim()
        $targetName = [IO.Path]::GetFileNameWithoutExtension($target).ToLowerInvariant()
        if ($titleToPath.ContainsKey($targetName)) {
            $validLinkCount++
        } else {
            $relative = $file.FullName.Substring($vault.Length + 1)
            $brokenLinks.Add("$relative -> $target")
        }
    }
    if ($validLinkCount -eq 0) { $orphanPages.Add($file.FullName.Substring($vault.Length + 1)) }
    if ($content -match '(?m)^status:\s*(unverified|draft)\s*$') {
        $unverifiedPages.Add($file.FullName.Substring($vault.Length + 1))
    }
    if ($file.LastWriteTime -lt $cutoff) { $stalePages.Add($file.FullName.Substring($vault.Length + 1)) }
}

$rawCount = if (Test-Path -LiteralPath (Join-Path $vault 'raw')) {
    @(Get-ChildItem -LiteralPath (Join-Path $vault 'raw') -Recurse -File).Count
} else { 0 }
$sourceCount = if (Test-Path -LiteralPath (Join-Path $wikiPath 'sources')) {
    @(Get-ChildItem -LiteralPath (Join-Path $wikiPath 'sources') -File -Filter '*.md').Count
} else { 0 }

$lines = [Collections.Generic.List[string]]::new()
$lines.Add('# Vault Health Report')
$lines.Add('')
$lines.Add("Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')")
$lines.Add('')
$lines.Add('## Summary')
$lines.Add('')
$lines.Add("- Wiki pages: $($pages.Count)")
$lines.Add("- Raw files: $rawCount")
$lines.Add("- Source pages: $sourceCount")
$lines.Add("- Broken wikilinks: $($brokenLinks.Count)")
$lines.Add("- Pages without valid links: $($orphanPages.Count)")
$lines.Add("- Draft or unverified pages: $($unverifiedPages.Count)")
$lines.Add("- Pages not updated in 180 days: $($stalePages.Count)")
$lines.Add("- Duplicate filename groups: $($duplicateTitles.Count)")

function Add-Section {
    param([string]$Title, [System.Collections.IEnumerable]$Items)
    $array = @($Items)
    $lines.Add('')
    $lines.Add("## $Title")
    $lines.Add('')
    if ($array.Count -eq 0) {
        $lines.Add('- None')
    } else {
        foreach ($item in $array) { $lines.Add("- $item") }
    }
}

Add-Section 'Broken wikilinks' $brokenLinks
Add-Section 'Pages without valid links' $orphanPages
Add-Section 'Draft or unverified pages' $unverifiedPages
Add-Section 'Stale pages' $stalePages
Add-Section 'Duplicate filenames' ($duplicateTitles | ForEach-Object { "$($_.Name): $((@($_.Group.FullName) -join ', '))" })

$report = $lines -join [Environment]::NewLine
if ($OutputPath) {
    $resolvedOutput = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($OutputPath)
    [IO.File]::WriteAllText($resolvedOutput, $report, [Text.UTF8Encoding]::new($false))
    Write-Host "Health report: $resolvedOutput" -ForegroundColor Green
} else {
    $report
}