# init-folders.ps1
# Compatible with Windows PowerShell 5.1+

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# -----------------------------------------------------------------------------
# Create directories
# -----------------------------------------------------------------------------

$directories = @(
    '.claude',
    '.claude\skills',
    '.claude\rules',
    '.claude\agents'
)

foreach ($dir in $directories) {
    if (-not (Test-Path -LiteralPath $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
    }
}

# -----------------------------------------------------------------------------
# .claude/settings.json
# -----------------------------------------------------------------------------

$settingsPath = '.claude\settings.json'

if (-not (Test-Path -LiteralPath $settingsPath)) {

    $settingsContent = @(
        '{',
        '  "permissions": {',
        '    "allow": []',
        '  }',
        '}'
    )

    Set-Content `
        -LiteralPath $settingsPath `
        -Value $settingsContent `
        -Encoding UTF8
}

# -----------------------------------------------------------------------------
# .claude/settings.local.json
# -----------------------------------------------------------------------------

$settingsPath = '.claude\settings.local.json'

if (-not (Test-Path -LiteralPath $settingsPath)) {

    $settingsContent = @(
        '{',
        '  "permissions": {',
        '    "allow": []',
        '  }',
        '}'
    )

    Set-Content `
        -LiteralPath $settingsPath `
        -Value $settingsContent `
        -Encoding UTF8
}

# -----------------------------------------------------------------------------
# .mcp.json
# -----------------------------------------------------------------------------

$mcpLocalPath = '.mcp.json'

if (-not (Test-Path -LiteralPath $mcpLocalPath)) {

    $settingsContent = @(
        '{',
        '  "mcpServers": {}',
        '}'
    )

    Set-Content `
        -LiteralPath $mcpLocalPath `
        -Value $settingsContent `
        -Encoding UTF8
}

# -----------------------------------------------------------------------------
# CLAUDE.md
# -----------------------------------------------------------------------------

$claudeMdPath = 'CLAUDE.md'

if (-not (Test-Path -LiteralPath $claudeMdPath)) {

    $claudeMdContent = @(
        '# CLAUDE.md',
        '',
        'This file provides guidance to Claude Code when working in this repository.',
        '',
        '## Project Overview',
        '<!--
        Describe:
        - What this project does
        - Who it is for
        - Main value proposition
        -->',
        '',
        '## Development Setup',
        '<!--
        Document:
        - Dependency installation
        - Environment variables
        - Required tooling
        - Prerequisites
        -->',
        '',
        '## Available Commands',
        '<!--
        Document:
        - Build commands
        - Test commands
        - Lint commands
        - Development workflows
        -->',
        '',
        '## Architecture',
        '<!--
        Document:
        - High-level architecture
        - Key modules
        - Data flow
        - Important services
        -->',
        '',
        '## Code Conventions',
        '<!--
        Document:
        - Naming conventions
        - Testing patterns
        - PR workflow
        - Team-specific standards
        -->'
    )

    Set-Content `
        -LiteralPath $claudeMdPath `
        -Value $claudeMdContent `
        -Encoding UTF8
}

# -----------------------------------------------------------------------------
# CLAUDE.local.md
# -----------------------------------------------------------------------------

$claudeLocalPath = 'CLAUDE.local.md'

if (-not (Test-Path -LiteralPath $claudeLocalPath)) {

    $claudeLocalContent = @(
        '# CLAUDE.local.md',
        '',
        'Personal notes and local project context.',
        '',
        'This file is gitignored.'
    )

    Set-Content `
        -LiteralPath $claudeLocalPath `
        -Value $claudeLocalContent `
        -Encoding UTF8
}

# -----------------------------------------------------------------------------
# .claudeignore
# -----------------------------------------------------------------------------

$claudeIgnorePath = '.claudeignore'

if (-not (Test-Path -LiteralPath $claudeIgnorePath)) {

    $claudeIgnoreContent = @(
        '# Dependencies',
        'node_modules/',
        '.pnp/',
        '',
        '# Build outputs',
        'dist/',
        'build/',
        '.next/',
        '.nuxt/',
        '.out/',
        '',
        '# Environment & secrets',
        '.env',
        '.env.*',
        '!.env.example',
        '',
        '# Logs & caches',
        '*.log',
        '.cache/',
        '.turbo/',
        '',
        '# IDE',
        '.vscode/',
        '.idea/',
        '',
        '# OS',
        '.DS_Store',
        'Thumbs.db',
        '',
        '# Claude local config',
        '.claude/settings.local.json',
        'CLAUDE.local.md',
        '.mcp.json',
        '',
        '# Personal',
        '*.bat',
        '*.txt'
    )

    Set-Content `
        -LiteralPath $claudeIgnorePath `
        -Value $claudeIgnoreContent `
        -Encoding UTF8
}

# -----------------------------------------------------------------------------
# Check for existing coding project and run codegraph init if found
# -----------------------------------------------------------------------------

$projectFilePatterns = @(
    "*.cs", "*.js", "*.ts", "*.py", "*.java", "*.cpp", "*.h", "*.c", "*.rs", "*.go", "*.php", "*.rb", "*.swift", "*.kt", "*.kts", "*.mjs",
    "*.csproj", "*.sln", "package.json", "pom.xml", "build.gradle", "build.gradle.kts",
    "Cargo.toml", "go.mod", "composer.json", "Gemfile", "requirements.txt", "pyproject.toml", "setup.py",
    ".env", ".gitignore"
)

$isProject = $false
foreach ($pattern in $projectFilePatterns) {
    if (Test-Path -Path $pattern) {
        $isProject = $true
        break
    }
}

if ($isProject) {
    Write-Host "Existing coding project detected. Running codegraph init -i..."
    try {
        & codegraph init -i
        Write-Host "codegraph init completed."
    } catch {
        Write-Warning "codegraph init failed: $_"
    }
} else {
    Write-Host "No existing coding project detected. Skipping codegraph init."
}

# -----------------------------------------------------------------------------
# Report
# -----------------------------------------------------------------------------

Write-Host ''
Write-Host '=== init-folders complete ==='
Write-Host ''

Get-ChildItem -Recurse -Force |
    Where-Object {
        $_.FullName -notmatch '\\node_modules\\' -and
        $_.FullName -notmatch '\\\.git\\'
    } |
    Sort-Object FullName |
    Select-Object FullName