# 국민건강영양조사 기반 비만 관련 요인 분석

복합표본 설계(Complex Survey Design)를 적용하여  
성인 남녀의 비만 관련 식행동·생활습관 요인을 분석한 R 코드입니다.

---

## 분석 개요

- **데이터**: 국민건강영양조사 (KNHANES)
- **대상**: 19~79세 성인 남녀
- **비만 정의**: BMI ≥ 25 AND 복부비만(남성 허리둘레 ≥ 90cm / 여성 ≥ 85cm) 동시 충족
- **분석 방법**: 복합표본 카이제곱 검정, 복합표본 로지스틱 회귀분석(svyglm)

---

## 구조

```
obesity-analysis/
├── README.md
├── 01_preprocessing/
│   ├── 01_load_data.R        # 패키지 설치·로드 및 데이터 불러오기
│   ├── 02_missing_values.R   # 결측치(무응답 코드) 처리 및 대상자 필터링
│   └── 03_variable_coding.R  # 그룹 변수 생성 및 복합표본 설계 객체 생성
├── 02_descriptive/
│   └── 01_crosstabs_chisq.R  # 비만 여부 × 각 변수 교차표 및 카이제곱 검정
└── 03_regression/
    └── 01_logistic_regression.R  # 로지스틱 회귀분석, VIF, 오즈비, ROC/AUC
```

---

## 실행 순서


```r
source("01_preprocessing/01_load_data.R")
source("01_preprocessing/02_missing_values.R")
source("01_preprocessing/03_variable_coding.R")
source("02_descriptive/01_crosstabs_chisq.R")
source("03_regression/01_logistic_regression.R")
```

---

## 주요 분석 변수

| 구분 | 변수 |
|------|------|
| 종속변수 | 비만 여부 (`bm`): BMI + 복부비만 복합 기준 |
| 인구사회학적 | 연령, 성별, 교육수준, 소득수준, 동거인 여부 |
| 식행동 | 아침·점심·저녁 식사 빈도 및 동반 여부, 외식 빈도 |
| 식품 섭취 | 채소류, 과일, 식이보충제 복용 여부, 영양표시 인지 |
| 음주 | 음주 빈도, 1회 음주량, 월 음주량 |

---

## 사용 패키지

| 패키지 | 용도 |
|--------|------|
| `survey` | 복합표본 설계 반영 분석 |
| `srvyr` | survey 패키지 dplyr 인터페이스 |
| `dplyr` | 데이터 전처리 |
| `descr` | 빈도표 |
| `gmodels` | 교차표 |
| `car` | VIF(다중공산성) 진단 |
| `pROC` | ROC 커브 및 AUC |

---

## 참고

- 원시 데이터(`data.csv`)는 저작권 및 개인정보 보호를 위해 저장소에 포함되지 않습니다.
- 국민건강영양조사 데이터는 [질병관리청 홈페이지](https://knhanes.kdca.go.kr)에서 신청 후 이용 가능합니다.
