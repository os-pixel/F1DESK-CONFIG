@echo off
REM 자동 커밋 및 푸시 배치 파일
REM 사용법: auto-commit.bat "커밋 메시지"

setlocal

if "%1"=="" (
    for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
    set datetime=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2% %datetime:~8,2%:%datetime:~10,2%:%datetime:~12,2%
    set MESSAGE=자동 업데이트: %datetime%
) else (
    set MESSAGE=%1
)

echo 📝 변경사항 확인 중...
git status --short

echo.
echo 📦 변경사항 스테이징 중...
git add -A

echo.
echo 💾 커밋 중...
git commit -m "%MESSAGE%"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo 🚀 GitHub에 푸시 중...
    git push origin main
    
    if %ERRORLEVEL% EQU 0 (
        echo.
        echo ✅ 성공적으로 GitHub에 업데이트되었습니다!
    ) else (
        echo.
        echo ❌ 푸시 실패. 수동으로 확인해주세요.
    )
) else (
    echo.
    echo ❌ 커밋 실패.
)

endlocal

