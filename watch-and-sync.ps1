# 파일 변경 감지 및 자동 커밋/푸시 스크립트
# 사용법: .\watch-and-sync.ps1

Write-Host "👀 파일 변경 감지 시작..." -ForegroundColor Cyan
Write-Host "종료하려면 Ctrl+C를 누르세요." -ForegroundColor Yellow
Write-Host ""

$lastCommit = Get-Date

# Git 저장소 루트 확인
$gitRoot = git rev-parse --show-toplevel 2>$null
if (-not $gitRoot) {
    Write-Host "❌ Git 저장소가 아닙니다." -ForegroundColor Red
    exit 1
}

Set-Location $gitRoot

# FileSystemWatcher 설정
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $gitRoot
$watcher.Filter = "*.*"
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

# 제외할 파일/폴더
$excludePatterns = @(
    "\.git",
    "node_modules",
    "\.vscode",
    "\.idea",
    "\.DS_Store",
    "Thumbs\.db"
)

$action = {
    $path = $Event.SourceEventArgs.FullPath
    $changeType = $Event.SourceEventArgs.ChangeType
    
    # 제외 패턴 확인
    $shouldExclude = $false
    foreach ($pattern in $excludePatterns) {
        if ($path -match $pattern) {
            $shouldExclude = $true
            break
        }
    }
    
    if ($shouldExclude) {
        return
    }
    
    $fileName = Split-Path $path -Leaf
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] 📝 $changeType`: $fileName" -ForegroundColor Gray
    
    # 5초 대기 (연속 변경 방지)
    Start-Sleep -Seconds 5
    
    # 마지막 커밋 후 10초 이상 지났는지 확인
    $timeSinceLastCommit = (Get-Date) - $lastCommit
    if ($timeSinceLastCommit.TotalSeconds -lt 10) {
        return
    }
    
    Write-Host "📦 변경사항 커밋 및 푸시 중..." -ForegroundColor Cyan
    
    git add -A
    $commitMessage = "자동 업데이트: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    git commit -m $commitMessage
    
    if ($LASTEXITCODE -eq 0) {
        git push origin main
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ GitHub에 업데이트 완료!" -ForegroundColor Green
            $script:lastCommit = Get-Date
        }
    }
}

# 이벤트 등록
Register-ObjectEvent -InputObject $watcher -EventName "Changed" -Action $action | Out-Null
Register-ObjectEvent -InputObject $watcher -EventName "Created" -Action $action | Out-Null
Register-ObjectEvent -InputObject $watcher -EventName "Deleted" -Action $action | Out-Null
Register-ObjectEvent -InputObject $watcher -EventName "Renamed" -Action $action | Out-Null

try {
    # 무한 대기
    while ($true) {
        Start-Sleep -Seconds 1
    }
} finally {
    $watcher.EnableRaisingEvents = $false
    $watcher.Dispose()
    Write-Host "`n👋 파일 감지 종료" -ForegroundColor Yellow
}

