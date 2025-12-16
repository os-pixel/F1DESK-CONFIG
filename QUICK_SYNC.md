# 빠른 GitHub 동기화 가이드

## 🚀 가장 간단한 방법

파일을 수정한 후 다음 명령어 하나만 실행하세요:

### PowerShell
```powershell
.\auto-commit.ps1
```

### 또는 배치 파일
```cmd
auto-commit.bat
```

**끝!** 자동으로 GitHub에 업데이트됩니다.

## 📝 커밋 메시지 지정하기

```powershell
.\auto-commit.ps1 "index.html UI 개선"
```

## 🔄 자동 감지 모드 (파일 저장 시 자동 업데이트)

```powershell
.\watch-and-sync.ps1
```

이제 파일을 저장할 때마다 자동으로 GitHub에 반영됩니다.
종료하려면 `Ctrl+C`를 누르세요.

## 💡 팁

- **일반적인 작업**: `auto-commit.ps1` 사용
- **지속적인 편집**: `watch-and-sync.ps1` 사용
- **중요한 변경사항**: 수동으로 확인 후 커밋

