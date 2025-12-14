# 엑셀 파일을 JSON으로 변환하는 방법

## 방법 1: 온라인 변환 도구 사용 (가장 간단)

1. **Excel to JSON 변환기 사용**
   - https://www.convertcsv.com/excel-to-json.htm
   - https://www.zamzar.com/convert/xlsx-to-json/
   - https://convertio.co/kr/xlsx-json/

2. **사용 방법**
   - 엑셀 파일을 업로드
   - JSON 형식 선택
   - 변환 후 다운로드
   - 파일명을 `prices.json`으로 변경
   - 프로젝트 루트에 업로드

## 방법 2: 엑셀에서 직접 수정 (권장)

1. **엑셀 파일 구조 확인**
   - 현재 `prices.json` 파일의 구조를 참고하세요
   - 각 옵션별로 `product`(제품가격)와 `delivery`(배송비) 구분

2. **JSON 형식으로 직접 작성**
   ```json
   {
     "version": "1.0",
     "lastUpdated": "2024-01-01",
     "prices": {
       "board": {
         "table": [
           [0, 0, 0, 0, 0, 0],
           [109800, 129800, 141700, 159700, 193100, 0],
           ...
         ]
       },
       "delivery": {
         "basic": 29800
       },
       ...
     }
   }
   ```

3. **온라인 JSON 검증 도구 사용**
   - https://jsonlint.com/
   - JSON 형식이 올바른지 확인

## 방법 3: Python 스크립트 사용 (고급)

```python
import pandas as pd
import json

# 엑셀 파일 읽기
df = pd.read_excel('가격표.xlsx')

# JSON으로 변환
prices = {
    "version": "1.0",
    "lastUpdated": "2024-01-01",
    "prices": {
        # 여기에 데이터 매핑
    }
}

# JSON 파일로 저장
with open('prices.json', 'w', encoding='utf-8') as f:
    json.dump(prices, f, ensure_ascii=False, indent=2)
```

## 가격 파일 구조 설명

### `prices.json` 파일 구조:

```json
{
  "version": "버전 번호",
  "lastUpdated": "마지막 업데이트 날짜",
  "prices": {
    "board": {
      "table": [
        [깊이별 가격 배열],
        ...
      ]
    },
    "delivery": {
      "basic": 기본 배송비
    },
    "mium": {
      "product": 제품 가격,
      "delivery": 배송비
    },
    "shelf": {
      "product": [폭별 가격 배열],
      "delivery": [개수별 배송비 배열],
      "heightExtra": {
        "925": 높이 추가 비용,
        "1400": 높이 추가 비용,
        "1860": 높이 추가 비용
      }
    },
    "giyeok": {
      "product": 가격
    },
    "deskMat": {
      "product": 가격,
      "delivery": 배송비
    },
    "drawer": {
      "product": 가격,
      "delivery": 배송비
    },
    "fence": {
      "product": [폭별 가격 배열],
      "delivery": 배송비
    },
    "moving2": {
      "product": 가격,
      "delivery": 배송비
    },
    "moving3": {
      "product": 가격,
      "delivery": 배송비
    }
  }
}
```

## 업데이트 방법

1. **엑셀 파일 수정**
   - 가격 정보 업데이트

2. **JSON 파일 생성**
   - 위 방법 중 하나를 사용하여 `prices.json` 생성

3. **파일 업로드**
   - GitHub Pages: `prices.json` 파일을 프로젝트 루트에 업로드
   - 로컬 서버: 프로젝트 루트에 `prices.json` 파일 배치

4. **확인**
   - 브라우저에서 F12 → Console 확인
   - "✅ 가격 데이터 로드 완료" 메시지 확인

## 주의사항

- JSON 파일은 UTF-8 인코딩으로 저장
- 숫자는 따옴표 없이 작성 (문자열이 아님)
- 배열과 객체 구분 주의
- JSON 형식 검증 필수 (https://jsonlint.com/)

