# GLB 파일 교체 가이드

## 현재 GLB 폴더 구조

### ✅ 이미 사용 중인 GLB 파일
- `attach1.glb` - 부착형 서랍 1단
- `attach2.glb` - 부착형 서랍 2단 / 이동 서랍 2단 (재사용)
- `attach3.glb` - 본체함 / 이동 서랍 3단 (재사용)
- `Storage_Sliding1 [높이].glb` - 슬라이딩 도어 1단 (1200, 1400, 1600, 1800, 2060)
- `Storage_Sliding2 [높이].glb` - 슬라이딩 도어 2단 (1200, 1400, 1600, 1800, 2060)
- `Storage_Flap [높이].glb` - 플랩 도어 (1200, 1400, 1600, 1800, 2060)
- `Storage_FlapStay [높이].glb` - 플랩 스테이 도어 (1200, 1400, 1600, 1800, 2060)

### ❓ 사용되지 않는 GLB 파일
- `UPPER_FLAP.glb` - 상부 플랩 옵션 (현재 미사용)
- `Storage Double sided_Flap [높이].glb` - 양면 플랩 도어 (1200, 1400, 1600, 1800, 2060) (현재 미사용)

### 📦 하드코딩된 박스로 생성되는 옵션들
- **이동 서랍 2단/3단** - 현재 attach2/attach3 모델 재사용 (fallback으로 박스)
- **하부가림막 (fence)** - 박스로 생성
- **파티션 옵션들** - 박스로 생성
  - `parti_ver_L` (좌측 수직 파티션)
  - `parti_ver_R` (우측 수직 파티션)
  - `parti_ver_M` (중첩 위치 파티션)
  - `parti_hol_B` (수평 파티션)
- **미니서랍 (drawer)** - 박스로 생성

## 교체 가능한 옵션들

### 1. UPPER_FLAP.glb
- **용도**: 상부 플랩 옵션
- **현재 상태**: 미사용
- **적용 위치**: 상부 옵션 영역 (현재 코드에 없음, 새로 추가 필요)

### 2. Storage Double sided_Flap
- **용도**: 양면 플랩 도어
- **현재 상태**: 미사용
- **적용 위치**: 수납 옵션 중 양면 플랩 옵션 (현재 코드에 없음, 새로 추가 필요)

### 3. 이동 서랍 전용 GLB 파일 (향후 추가 가능)
- `moving2.glb` - 이동 서랍 2단 전용 모델
- `moving3.glb` - 이동 서랍 3단 전용 모델
- **현재**: attach2/attach3 재사용
- **개선**: 전용 모델이 있으면 더 정확한 표현 가능

### 4. 파티션 전용 GLB 파일 (향후 추가 가능)
- `parti_ver_L.glb` - 좌측 수직 파티션
- `parti_ver_R.glb` - 우측 수직 파티션
- `parti_ver_M.glb` - 중첩 위치 파티션
- `parti_hol_B.glb` - 수평 파티션
- **현재**: 박스로 생성
- **개선**: 전용 모델이 있으면 더 정확한 표현 가능

### 5. 하부가림막 전용 GLB 파일 (향후 추가 가능)
- `fence.glb` - 하부가림막
- **현재**: 박스로 생성
- **개선**: 전용 모델이 있으면 더 정확한 표현 가능

## 교체 방법

### 기존 패턴 (attach1, attach2, attach3 참고)
```javascript
// 1. 전역 변수 선언
var upper_flap_model = null;

// 2. init() 함수에서 로드
gltfLoader.load(getResourcePath('glb/UPPER_FLAP.glb'), function(gltf) {
  upper_flap_model = gltf.scene;
  upper_flap_model.traverse(function(child) {
    if (child instanceof THREE.Mesh) {
      child.castShadow = true;
      child.receiveShadow = true;
    }
  });
  updateScene();
  render();
}, undefined, function(error) {
  console.error('UPPER_FLAP.glb 로드 실패:', error);
});

// 3. 사용 시점에서
if (upper_flap_model) {
  var upper_flap = upper_flap_model.clone();
  upper_flap.traverse(function(child) {
    if (child instanceof THREE.Mesh) {
      child.material = getMaterial(color);
      child.castShadow = true;
      child.receiveShadow = true;
    }
  });
  upper_flap.position.set(x, y, z);
  scene.add(upper_flap);
} else {
  // Fallback: 박스 생성
  geometry = new THREE.BoxBufferGeometry(width, height, depth);
  var upper_flap = new THREE.Mesh(geometry, material);
  scene.add(upper_flap);
}
```

## 권장 사항

1. **즉시 적용 가능**: UPPER_FLAP.glb, Storage Double sided_Flap 추가
2. **향후 개선**: 이동 서랍, 파티션, 하부가림막 전용 GLB 파일 추가 시 교체
3. **Fallback 유지**: GLB 로드 실패 시 박스로 대체하는 로직 유지

