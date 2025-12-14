# 자동 커밋 및 푸시 스크립트
# 사용법: .\auto-commit.ps1 "커밋 메시지"

param(
    [string]$Message = "자동 업데이트: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
)

Write-Host "📝 변경사항 확인 중..." -ForegroundColor Cyan
git status --short

$changes = git status --porcelain
if ([string]::IsNullOrWhiteSpace($changes)) {
    Write-Host "✅ 변경사항이 없습니다." -ForegroundColor Green
    exit 0
}

Write-Host "📦 변경사항 스테이징 중..." -ForegroundColor Cyan
git add -A

Write-Host "💾 커밋 중..." -ForegroundColor Cyan
git commit -m $Message

if ($LASTEXITCODE -eq 0) {
    Write-Host "🚀 GitHub에 푸시 중..." -ForegroundColor Cyan
    git push origin main
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ 성공적으로 GitHub에 업데이트되었습니다!" -ForegroundColor Green
    } else {
        Write-Host "❌ 푸시 실패. 수동으로 확인해주세요." -ForegroundColor Red
    }
} else {
    Write-Host "❌ 커밋 실패." -ForegroundColor Red
}

