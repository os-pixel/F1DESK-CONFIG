# 자동 GitHub 동기화 가이드

로컬 파일 수정 시 자동으로 GitHub에 반영하는 방법입니다.

## 방법 1: 간단한 스크립트 사용 (권장)

### PowerShell 사용 (Windows)
```powershell
.\auto-commit.ps1 "커밋 메시지"
```

### 배치 파일 사용 (Windows)
```cmd
auto-commit.bat "커밋 메시지"
```

**커밋 메시지를 생략하면 자동으로 날짜/시간이 사용됩니다.**

## 방법 2: 파일 변경 자동 감지 (고급)

파일을 저장할 때마다 자동으로 커밋 및 푸시합니다.

```powershell
.\watch-and-sync.ps1
```

이 스크립트는:
- 파일 변경을 실시간으로 감지
- 변경 후 10초 대기 (연속 변경 방지)
- 자동으로 커밋 및 푸시
- Ctrl+C로 종료

## 방법 3: Git Hooks 사용

Git hooks가 설정되어 있어 `git commit` 시 자동으로 푸시됩니다.

```bash
git commit -m "커밋 메시지"
# 자동으로 GitHub에 푸시됨
```

## 사용 예시

### 예시 1: index.html 수정 후 업데이트
```powershell
# 파일 수정 후
.\auto-commit.ps1 "index.html UI 개선"
```

### 예시 2: 여러 파일 수정 후 업데이트
```powershell
.\auto-commit.ps1 "가격 정보 및 스타일 업데이트"
```

### 예시 3: 자동 감지 모드
```powershell
# 백그라운드에서 실행
.\watch-and-sync.ps1
# 이제 파일을 저장할 때마다 자동으로 GitHub에 반영됨
```

## 주의사항

1. **자동 푸시는 신중하게 사용하세요**
   - 테스트되지 않은 코드가 GitHub에 올라갈 수 있습니다
   - 중요한 변경사항은 수동으로 확인 후 커밋하세요

2. **충돌 발생 시**
   - 원격 저장소에 로컬에 없는 변경사항이 있으면 푸시가 실패합니다
   - `git pull` 후 다시 시도하세요

3. **파일 감지 스크립트**
   - `.git` 폴더와 `node_modules` 등은 자동으로 제외됩니다
   - 필요시 `watch-and-sync.ps1`의 `$excludePatterns`를 수정하세요

## 문제 해결

### 푸시 실패 시
```powershell
# 원격 변경사항 가져오기
git pull origin main

# 다시 푸시
.\auto-commit.ps1 "업데이트"
```

### Git hooks가 작동하지 않을 때
```powershell
# hooks 파일에 실행 권한 부여 (Linux/Mac)
chmod +x .git/hooks/pre-commit
chmod +x .git/hooks/post-commit
```

Windows에서는 PowerShell이 자동으로 실행됩니다.

## 추천 워크플로우

1. **일반적인 작업**: `auto-commit.ps1` 사용
2. **지속적인 편집**: `watch-and-sync.ps1` 사용
3. **중요한 변경사항**: 수동으로 `git commit` 및 `git push`

