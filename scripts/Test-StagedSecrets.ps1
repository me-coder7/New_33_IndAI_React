[CmdletBinding()]
param([string]$PrivateEnvPath = '.env')
$ErrorActionPreference = 'Stop'
$paths = @(& git -c core.quotepath=false diff --cached --name-only --diff-filter=ACMR)
if ($LASTEXITCODE -ne 0) { throw 'Cannot inspect the Git index.' }
$privateValues = @()
if (Test-Path -LiteralPath $PrivateEnvPath) {
    foreach ($line in [IO.File]::ReadAllLines((Resolve-Path -LiteralPath $PrivateEnvPath))) {
        if ($line -match '^\s*([A-Z0-9_]*(SECRET|TOKEN|PASSWORD|SMTP_PASS)[A-Z0-9_]*)\s*=(.*)$') {
            $value = $Matches[3].Trim().Trim('"').Trim("'")
            if ($value.Length -ge 8 -and $value -notmatch '^replace-|^example') { $privateValues += $value }
        }
    }
}
$rules = @{
    'private key' = '-----BEGIN (RSA |OPENSSH |EC )?PRIVATE KEY-----'
    'GitHub token' = '\b(gh[pousr]_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{40,})'
    'AWS access key' = '\bAKIA[A-Z0-9]{16}\b'
    'JWT literal' = 'eyJ[A-Za-z0-9_-]{20,}\.[A-Za-z0-9_-]{20,}\.[A-Za-z0-9_-]{20,}'
}
$issues = [Collections.Generic.List[string]]::new()
foreach ($path in $paths) {
    $name = [IO.Path]::GetFileName($path)
    if (($name -match '^\.env($|\.)' -and $name -ne '.env.example') -or
        $path -match '(^|/)(node_modules|dist|data|persistent-data|uploads|test-results|playwright-report)/' -or
        $path -match '\.(sqlite(-wal|-shm)?|db|log|zip)$') {
        $issues.Add("Excluded private/generated path: $path"); continue
    }
    if ([IO.Path]::GetExtension($path).ToLowerInvariant() -in @('.png', '.jpg', '.jpeg', '.pdf', '.mp4', '.webm', '.woff', '.woff2', '.ttf')) { continue }
    $content = (& git show (':' + $path)) -join "`n"
    if ($LASTEXITCODE -ne 0) { throw "Cannot read staged file: $path" }
    foreach ($rule in $rules.Keys) {
        if ($content -match $rules[$rule]) { $issues.Add("Potential $rule in $path") }
    }
    foreach ($value in $privateValues) {
        if ($content.Contains($value)) { $issues.Add("Local private environment value found in $path") }
    }
    if ($name -eq '.env.example') {
        foreach ($line in $content.Split("`n")) {
            if ($line -match '^\s*([A-Z0-9_]*(SECRET|TOKEN|PASSWORD|SMTP_PASS)[A-Z0-9_]*)\s*=\s*(.+)$') {
                $value = $Matches[3].Trim()
                if ($value -and $value -notmatch '^#|^replace-|^example') { $issues.Add("Nonempty credential default in $path") }
            }
        }
    }
}
if ($issues.Count) {
    $issues | ForEach-Object { Write-Error $_ -ErrorAction Continue }
    throw 'Staged secret/artifact review failed. No private values were printed.'
}
Write-Output "PASS: inspected $($paths.Count) staged files; no excluded paths or configured credential patterns found."
Write-Output 'This pattern check supplements human review and cannot prove the absence of every possible secret.'
