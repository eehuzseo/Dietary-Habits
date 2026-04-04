# ============================================================
# 02_missing_values.R
# 목적: 각 변수의 무응답 코드(9, 99 등)를 NA로 변환하고
#       분석 대상 조건에 맞게 데이터 필터링
# ============================================================

# ── 무응답 코드 → NA 변환 ───────────────────────────────────

# 식사 관련 변수
h$L_BR_FQ[h$L_BR_FQ == 9]   <- NA   # 아침 식사 빈도
h$L_LN_FQ[h$L_LN_FQ == 9]   <- NA   # 점심 식사 빈도
h$L_DN_FQ[h$L_DN_FQ == 9]   <- NA   # 저녁 식사 빈도
h$L_BR_TO[h$L_BR_TO == 9]   <- NA   # 아침 동반 여부
h$L_BR_WHO[h$L_BR_WHO == 9] <- NA   # 아침 동반자
h$L_LN_TO[h$L_LN_TO == 9]   <- NA   # 점심 동반 여부
h$L_LN_WHO[h$L_LN_WHO == 9] <- NA   # 점심 동반자
h$L_DN_TO[h$L_DN_TO == 9]   <- NA   # 저녁 동반 여부
h$L_DN_WHO[h$L_DN_WHO == 9] <- NA   # 저녁 동반자
h$L_OUT_FQ[h$L_OUT_FQ == 9] <- NA   # 외식 빈도

# 식품 섭취 빈도 변수
h$LS_VEG1[h$LS_VEG1 == 99]   <- NA  # 채소류 섭취 빈도
h$LS_VEG2[h$LS_VEG2 == 99]   <- NA  # 채소류(장아찌 제외) 섭취 빈도
h$LS_FRUIT[h$LS_FRUIT == 99] <- NA  # 과일 섭취 빈도
h$LS_1YR[h$LS_1YR == 9]      <- NA  # 식이보충제 복용 여부

# 식품 표시 인지 변수
h$LK_LB_CO[h$LK_LB_CO == 9] <- NA  # 영양표시 인지 여부

# 음주 변수
h$BD1_11[h$BD1_11 == 9] <- NA  # 음주 빈도
h$BD2_1[h$BD2_1 == 9]   <- NA  # 1회 음주량

# 결혼 상태 변수
h$marri_2[h$marri_2 == 8]  <- NA
h$marri_2[h$marri_2 == 9]  <- NA
h$marri_2[h$marri_2 == 99] <- NA


# ── 분석 대상 필터링 ────────────────────────────────────────
# 조건: 주요 변수 결측 없음 & 연령 19~79세

h1 <- h %>%
  filter(!is.na(L_BR_FQ), !is.na(L_LN_FQ),  !is.na(L_DN_FQ),
         !is.na(L_BR_TO), !is.na(L_LN_TO),   !is.na(L_DN_TO),
         !is.na(L_BR_WHO),!is.na(L_LN_WHO),  !is.na(L_DN_WHO),
         !is.na(L_OUT_FQ),
         !is.na(LS_VEG1), !is.na(LS_VEG2),   !is.na(LS_FRUIT),
         !is.na(LS_1YR),  !is.na(LK_LB_CO),
         !is.na(BD1_11),  !is.na(BD2_1),
         !is.na(ho_incm), !is.na(marri_2),
         !is.na(wt_itvex),!is.na(cfam),
         !is.na(HE_wc),   !is.na(HE_BMI),
         !is.na(edu),
         age >= 19 & age <= 79)

# 필터링 후 결측 확인
cat("분석 대상 표본 수:", nrow(h1), "\n")
freq(h1$sex)   # 성별 분포 확인
