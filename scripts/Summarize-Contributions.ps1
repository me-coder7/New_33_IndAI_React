[CmdletBinding()]
param(
    [string]$Range = 'main..HEAD',
    [switch]$AllHistory,
    [switch]$AsJson,
    [string]$CsvPath
)
$ErrorActionPreference = 'Stop'
$repoRoot = & git rev-parse --show-toplevel
if ($LASTEXITCODE -ne 0) { throw 'Run this script inside the IndAI Git repository.' }

function Get-FileCategory([string]$Path) {
    $name = [IO.Path]::GetFileName($Path)
    $extension = [IO.Path]::GetExtension($Path).ToLowerInvariant()
    if ($name -match '^(package-lock\.json|npm-shrinkwrap\.json|yarn\.lock|pnpm-lock\.yaml)$') { return 'Lockfiles' }
    if ($Path -match '(^|/)(node_modules|dist|coverage|test-results|playwright-report)/') { return 'Generated' }
    if ($extension -in @('.png', '.jpg', '.jpeg', '.gif', '.svg', '.ico', '.pdf', '.mp4', '.webm', '.woff', '.woff2', '.ttf')) { return 'Assets' }
    if ($extension -in @('.md', '.txt', '.drawio') -or $Path -match '^(docs|individual-contributions)/') { return 'Documentation' }
    if ($extension -in @('.csv', '.tsv') -or $Path -match '/assets/catalog/|/data/stocks/') { return 'Datasets' }
    if ($extension -in @('.js', '.jsx', '.ts', '.tsx', '.mjs', '.cjs', '.css', '.scss', '.html', '.sql', '.ps1', '.py', '.sh', '.bat')) { return 'Source' }
    return 'Configuration'
}

$arguments = @('-c', 'core.quotepath=false', 'log', '--no-merges', '--root', '--no-renames', '--numstat', '--format=@@%H%x09%an%x09%ae')
if ($AllHistory) { $arguments += '--all' } else { $arguments += $Range }
$logLines = & git @arguments
if ($LASTEXITCODE -ne 0) { throw "Cannot read Git history for range '$Range'." }
$totals = @{}
$authorName = ''; $authorEmail = ''; $commit = ''
foreach ($line in $logLines) {
    if ($line.StartsWith('@@')) {
        $fields = $line.Substring(2).Split("`t", 3)
        $commit = $fields[0]; $authorName = $fields[1]; $authorEmail = $fields[2]
        continue
    }
    if ($line -notmatch '^(\d+|-)\t(\d+|-)\t(.+)$') { continue }
    $added = $Matches[1]; $deleted = $Matches[2]; $path = $Matches[3]
    $category = Get-FileCategory $path
    $key = $authorEmail.ToLowerInvariant() + '|' + $category
    if (-not $totals.ContainsKey($key)) {
        $totals[$key] = [PSCustomObject]@{
            Author = $authorName; Email = $authorEmail; Category = $category
            Added = [long]0; Deleted = [long]0; FrontendAdded = [long]0; FrontendDeleted = [long]0
            ChangedFileEntries = 0; BinaryEntries = 0
            Commits = [Collections.Generic.HashSet[string]]::new()
        }
    }
    $entry = $totals[$key]
    $entry.ChangedFileEntries++
    [void]$entry.Commits.Add($commit)
    if ($added -eq '-') { $entry.BinaryEntries++; continue }
    $entry.Added += [long]$added; $entry.Deleted += [long]$deleted
    if ($category -eq 'Source' -and $path.StartsWith('frontend/')) {
        $entry.FrontendAdded += [long]$added; $entry.FrontendDeleted += [long]$deleted
    }
}
$result = @($totals.Values | Sort-Object Email, Category | ForEach-Object {
    [PSCustomObject]@{
        Author = $_.Author; Email = $_.Email; Category = $_.Category
        Commits = $_.Commits.Count; Added = $_.Added; Deleted = $_.Deleted
        FrontendAdded = $_.FrontendAdded; FrontendDeleted = $_.FrontendDeleted
        ChangedFileEntries = $_.ChangedFileEntries; BinaryEntries = $_.BinaryEntries
    }
})
if ($CsvPath) { $result | Export-Csv -LiteralPath $CsvPath -NoTypeInformation -Encoding UTF8 }
if ($AsJson) { ConvertTo-Json -InputObject $result -Depth 4 } else { $result }

# A file touched in two commits is two file entries. Binary files have no line
# estimate. Even a PDF that Git treats as text remains an Asset, never Source.
# These numbers report recorded authorship; they do not measure effort or prove it.
