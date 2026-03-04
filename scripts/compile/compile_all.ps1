param(
    [string]$TargetDir = ""
)

$ErrorActionPreference = "Continue"

if ([string]::IsNullOrWhiteSpace($TargetDir)) {
    $repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..\..")
    $baseDir = Join-Path $repoRoot "university_exam\physics-standard"
}
else {
    $baseDir = (Resolve-Path $TargetDir).Path
}

if (-not (Test-Path $baseDir)) {
    Write-Host "Target directory not found: $baseDir" -ForegroundColor Red
    exit 1
}

$baseDir = (Resolve-Path $baseDir).Path

# Statistics
$totalFiles = 0
$successCount = 0
$failedFiles = @()

Write-Host "=== Starting LaTeX Compilation ===" -ForegroundColor Cyan
Write-Host "Target Directory: $baseDir" -ForegroundColor Gray
Write-Host ""

function Compile-TexFile {
    param(
        [string]$FilePath,
        [string]$DisplayName = "",
        [string]$JobName = "",
        [string]$InputExpression = ""
    )

    $relativePath = $FilePath.Replace($baseDir, "").TrimStart('\')
    $dir = Split-Path $FilePath -Parent
    $fileName = Split-Path $FilePath -Leaf
    $label = if ([string]::IsNullOrWhiteSpace($DisplayName)) { $relativePath } else { $DisplayName }
    $pdfName = if ([string]::IsNullOrWhiteSpace($JobName)) {
        ([System.IO.Path]::GetFileNameWithoutExtension($fileName)) + ".pdf"
    }
    else {
        "$JobName.pdf"
    }

    Write-Host "[$script:totalFiles] Compiling: $label" -NoNewline

    Push-Location $dir
    try {
        if (-not [string]::IsNullOrWhiteSpace($InputExpression)) {
            if ([string]::IsNullOrWhiteSpace($JobName)) {
                $null = lualatex -interaction=nonstopmode -halt-on-error $InputExpression 2>&1 | Out-String
            }
            else {
                $null = lualatex -interaction=nonstopmode -halt-on-error "-jobname=$JobName" $InputExpression 2>&1 | Out-String
            }
        }
        else {
            if ([string]::IsNullOrWhiteSpace($JobName)) {
                $null = lualatex -interaction=nonstopmode -halt-on-error $fileName 2>&1 | Out-String
            }
            else {
                $null = lualatex -interaction=nonstopmode -halt-on-error "-jobname=$JobName" $fileName 2>&1 | Out-String
            }
        }

        if (Test-Path $pdfName) {
            Write-Host " [OK]" -ForegroundColor Green
            $script:successCount++
        }
        else {
            Write-Host " [FAIL] (PDF not generated)" -ForegroundColor Red
            $script:failedFiles += $label
        }
    }
    catch {
        Write-Host " [ERROR] (Exception: $($_.Exception.Message))" -ForegroundColor Red
        $script:failedFiles += $label
    }
    finally {
        Pop-Location
    }

    $script:totalFiles++
}

# Step 1: Top-level files (ps_q.tex and ps_a.tex)
Write-Host "Step 1: Top-level files (ps_q.tex and ps_a.tex)" -ForegroundColor Yellow
$topLevelFiles = @("ps_q.tex", "ps_a.tex")
foreach ($file in $topLevelFiles) {
    $fullPath = Join-Path $baseDir $file
    if (Test-Path $fullPath) {
        Compile-TexFile -FilePath $fullPath
    }
}

Write-Host ""

# Step 2: Domain-level parent files
Write-Host "Step 2: Domain-level parent files" -ForegroundColor Yellow
Get-ChildItem -Path $baseDir -Recurse -Filter "ps_*.tex" -File | Where-Object {
    $_.Directory.Name -match "^(em_|me_|th_|mp_|wa_)"
} | ForEach-Object {
    Compile-TexFile -FilePath $_.FullName
}

Write-Host ""

# Step 3: Child files
Write-Host "Step 3: Child files (individual problems)" -ForegroundColor Yellow
Get-ChildItem -Path $baseDir -Recurse -Filter "ps_*.tex" -File | Where-Object {
    $_.Directory.Name -notmatch "^(em_|me_|th_|mp_|wa_)" -and
    $_.Directory.FullName -ne $baseDir
} | ForEach-Object {
    Compile-TexFile -FilePath $_.FullName
}

Write-Host ""
Write-Host "=== Compilation Summary ===" -ForegroundColor Cyan
Write-Host "Total files: $totalFiles" -ForegroundColor White
Write-Host "Success: $successCount" -ForegroundColor Green
Write-Host "Failed: $($failedFiles.Count)" -ForegroundColor Red

if ($failedFiles.Count -gt 0) {
    Write-Host ""
    Write-Host "Failed files:" -ForegroundColor Red
    $failedFiles | ForEach-Object {
        Write-Host "  - $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Done!" -ForegroundColor Cyan
