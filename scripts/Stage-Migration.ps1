[CmdletBinding()]
param([switch]$Stage)
$ErrorActionPreference = 'Stop'
$root = (& git rev-parse --show-toplevel).Trim()
if ($LASTEXITCODE -ne 0) { throw 'Run inside the existing IndAI clone.' }
$remote = (& git remote get-url origin).Trim().TrimEnd('/')
if ($remote -ne 'https://github.com/me-coder7/New_33_IndAI_React') { throw 'Unexpected repository remote.' }
$branch = (& git branch --show-current).Trim()
if ($branch -ne 'redux-migration') { throw 'Only stage the initial import from redux-migration.' }
$trackedPaths = @(& git -c core.quotepath=false ls-files --modified --deleted | Sort-Object -Unique)
$newPaths = @(& git -c core.quotepath=false ls-files --others --exclude-standard | Sort-Object -Unique)
$paths = @(@($trackedPaths) + @($newPaths) | Sort-Object -Unique)
$paths = @($paths | Where-Object { $_ })
foreach ($path in $paths) {
    if ($path -match '[\x00-\x1f]' -or $path -match '(^|/)\.git(/|$)' -or
        ([IO.Path]::GetFileName($path) -match '^\.env($|\.)' -and [IO.Path]::GetFileName($path) -ne '.env.example') -or
        $path -match '(^|/)(node_modules|dist|persistent-data|uploads|test-results|playwright-report)/' -or
        $path -match '\.(sqlite(-wal|-shm)?|db|log|zip)$') { throw "Excluded path in migration plan: $path" }
}
if (-not $Stage) { $paths; Write-Output 'Review this exact list, then rerun with -Stage.'; return }
if ($trackedPaths.Count) {
    # Update tracked paths separately: deleted old CSV paths may now be ignored.
    & git --literal-pathspecs add -u -- @trackedPaths
    if ($LASTEXITCODE -ne 0) { throw 'Staging tracked changes failed.' }
}
if ($newPaths.Count) {
    # Literal pathspecs preserve spaces, ampersands and other filename characters.
    & git --literal-pathspecs add -- @newPaths
    if ($LASTEXITCODE -ne 0) { throw 'Staging failed.' }
}
& "$PSScriptRoot/Test-StagedSecrets.ps1"
& git diff --cached --check
if ($LASTEXITCODE -ne 0) { throw 'Staged whitespace check failed.' }
& git diff --cached --stat
