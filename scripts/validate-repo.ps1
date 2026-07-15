$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$errors = [System.Collections.Generic.List[string]]::new()

function Add-ValidationError {
    param([string]$Message)
    $errors.Add($Message)
}

$required = @(
    'README.md',
    'LICENSE',
    'CODE_OF_CONDUCT.md',
    'SECURITY.md',
    'CONTRIBUTING.md',
    'CHANGELOG.md',
    '.github/ISSUE_TEMPLATE/01-bug.yml',
    '.github/ISSUE_TEMPLATE/02-feature.yml',
    '.github/ISSUE_TEMPLATE/03-scenario.yml',
    '.github/pull_request_template.md',
    'docs/README.md',
    'docs/PUBLISHING.md',
    'docs/01-install-claude-code.md',
    'docs/02-install-obsidian-and-claudian.md',
    'docs/03-create-vault-and-claude-md.md',
    'docs/04-modify-claude-md.md',
    'docs/05-test-and-maintain.md',
    'templates/CLAUDE.md',
    'templates/START-HERE.md',
    'templates/index.md',
    'templates/log.md',
    'scripts/new-vault.ps1',
    'scripts/test-new-vault.ps1',
    'scripts/test-install-skills.ps1',
    'scripts/build-starter.ps1',
    'scripts/test-build-starter.ps1',
    'examples/course-demo/README.md',
    'examples/research-demo/README.md',
    'examples/project-demo/README.md',
    'tests/evals.json'
)

foreach ($path in $required) {
    if (-not (Test-Path -LiteralPath (Join-Path $root $path))) {
        Add-ValidationError "Missing required path: $path"
    }
}

$obsoleteManual = Join-Path $root '目标导向AI知识库培训手册.md'
if (Test-Path -LiteralPath $obsoleteManual) {
    Add-ValidationError 'The duplicated training manual should not exist.'
}

$claudeTemplate = Join-Path $root 'templates/CLAUDE.md'
if (Test-Path -LiteralPath $claudeTemplate) {
    $lineCount = (Get-Content -LiteralPath $claudeTemplate -Encoding UTF8).Count
    if ($lineCount -gt 200) {
        Add-ValidationError "templates/CLAUDE.md has $lineCount lines; limit is 200."
    }
}

$skillNames = @(
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

foreach ($name in $skillNames) {
    $entry = Join-Path $root "skills/$name/SKILL.md"
    if (-not (Test-Path -LiteralPath $entry)) {
        Add-ValidationError "Missing skill entry: skills/$name/SKILL.md"
        continue
    }

    $content = Get-Content -LiteralPath $entry -Raw -Encoding UTF8
    $frontmatter = [regex]::Match($content, '(?s)^---\r?\n(?<body>.*?)\r?\n---')
    if (-not $frontmatter.Success) {
        Add-ValidationError "Invalid frontmatter: skills/$name/SKILL.md"
        continue
    }

    $body = $frontmatter.Groups['body'].Value
    if ($body -notmatch "(?m)^name:\s*$([regex]::Escape($name))\s*$") {
        Add-ValidationError "Skill name does not match directory: $name"
    }
    if ($body -notmatch '(?m)^description:\s*\S.+$') {
        Add-ValidationError "Skill description is missing: $name"
    }

    $skillLineCount = (Get-Content -LiteralPath $entry -Encoding UTF8).Count
    if ($skillLineCount -gt 500) {
        Add-ValidationError "Skill exceeds 500 lines: $name ($skillLineCount)"
    }

    $description = [regex]::Match($body, '(?m)^description:\s*(?<value>.+)$').Groups['value'].Value
    if ($description.Length -gt 1536) {
        Add-ValidationError "Skill description exceeds 1536 characters: $name"
    }
}

$scenarioNames = @('course', 'research', 'product', 'project', 'personal', 'book')
foreach ($name in $scenarioNames) {
    foreach ($path in @("templates/scenarios/$name.md", "tests/cases/$name.md")) {
        if (-not (Test-Path -LiteralPath (Join-Path $root $path))) {
            Add-ValidationError "Missing scenario artifact: $path"
        }
    }
}

$pageTemplateNames = @('source', 'concept', 'entity', 'topic', 'synthesis')
foreach ($name in $pageTemplateNames) {
    $path = Join-Path $root "templates/pages/$name.md"
    if (-not (Test-Path -LiteralPath $path)) {
        Add-ValidationError "Missing page template: templates/pages/$name.md"
        continue
    }

    $content = Get-Content -LiteralPath $path -Raw -Encoding UTF8
    $frontmatter = [regex]::Match($content, '(?s)^---\r?\n(?<body>.*?)\r?\n---')
    if (-not $frontmatter.Success) {
        Add-ValidationError "Invalid page template frontmatter: $name"
        continue
    }

    foreach ($field in @('title', 'type', 'status', 'created', 'updated')) {
        if ($frontmatter.Groups['body'].Value -notmatch "(?m)^$field\s*:") {
            Add-ValidationError "Page template '$name' is missing field '$field'."
        }
    }
}

$forbidden = @(
    'PPT Slide 28',
    '低空申报库 v4.0',
    '结舌（仓库）',
    '不能通过 Obsidian 社区插件市场',
    '重读三遍'
)

$markdownFiles = Get-ChildItem -LiteralPath $root -Recurse -File -Filter '*.md' |
    Where-Object { $_.FullName -notmatch '[\\/]\.git[\\/]' }

foreach ($file in $markdownFiles) {
    $content = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    $relative = $file.FullName.Substring($root.Length + 1)

    foreach ($phrase in $forbidden) {
        if ($content.Contains($phrase)) {
            Add-ValidationError "Forbidden stale phrase '$phrase' in $relative"
        }
    }

    $links = [regex]::Matches($content, '\[[^\]]+\]\((?<target>[^)]+)\)')
    foreach ($link in $links) {
        $target = $link.Groups['target'].Value
        if ($target -match '^(https?://|mailto:|#)') {
            continue
        }

        $targetPath = $target.Split('#')[0]
        if ([string]::IsNullOrWhiteSpace($targetPath)) {
            continue
        }

        $targetPath = [Uri]::UnescapeDataString($targetPath)
        $resolved = Join-Path $file.DirectoryName $targetPath
        if (-not (Test-Path -LiteralPath $resolved)) {
            Add-ValidationError "Broken local link in $relative -> $target"
        }
    }
}

try {
    $evalSuite = Get-Content -LiteralPath (Join-Path $root 'tests/evals.json') -Raw -Encoding UTF8 |
        ConvertFrom-Json
    $evalSkills = @($evalSuite.evals | ForEach-Object { $_.skill })
    if ($evalSkills.Count -ne $skillNames.Count) {
        Add-ValidationError "Eval count $($evalSkills.Count) does not match skill count $($skillNames.Count)."
    }
    foreach ($name in $skillNames) {
        if ($name -notin $evalSkills) {
            Add-ValidationError "Missing eval for skill: $name"
        }
    }
} catch {
    Add-ValidationError "tests/evals.json is invalid JSON: $($_.Exception.Message)"
}

if ($errors.Count -gt 0) {
    Write-Host "Validation failed with $($errors.Count) error(s):" -ForegroundColor Red
    foreach ($message in $errors) {
        Write-Host " - $message" -ForegroundColor Red
    }
    exit 1
}

Write-Host "Validation passed: $($skillNames.Count) skills, $($scenarioNames.Count) scenarios, $($markdownFiles.Count) Markdown files." -ForegroundColor Green
