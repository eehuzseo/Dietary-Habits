# ============================================================
# 03_variable_coding.R
# 목적: 분석에 사용할 그룹 변수 생성
#       - 연령 / BMI / 허리둘레 / 결혼 / 외식빈도 / 채소·과일·음주 등
#       - 성별 기준 복부비만+BMI 결합 비만 변수(bm) 생성
#       - 복합표본 설계 객체 생성
# ============================================================

# ── 1. 성별 분리 데이터 ──────────────────────────────────────
male_data   <- h1 %>% filter(sex == 1)
female_data <- h1 %>% filter(sex == 2)


# ── 2. 연령 그룹 (6구간) ─────────────────────────────────────
h1 <- h1 %>%
  mutate(age_gr = case_when(
    age < 30             ~ 1,   # 19-29세
    age >= 30 & age < 40 ~ 2,   # 30대
    age >= 40 & age < 50 ~ 3,   # 40대
    age >= 50 & age < 60 ~ 4,   # 50대
    age >= 60 & age < 70 ~ 5,   # 60대
    age >= 70            ~ 6,   # 70대
    TRUE                 ~ NA_real_
  ))


# ── 3. BMI 그룹 (3구간) ──────────────────────────────────────
# 1: 정상(BMI<23), 2: 과체중(23≤BMI<25), 3: 비만(BMI≥25)
h1 <- h1 %>%
  mutate(bmi_gr = case_when(
    HE_BMI < 23                  ~ 1,
    HE_BMI >= 23 & HE_BMI < 25  ~ 2,
    HE_BMI >= 25                 ~ 3,
    TRUE                         ~ NA_real_
  ))


# ── 4. 허리둘레 그룹 (성별 기준) ────────────────────────────
# 남성 ≥90cm, 여성 ≥85cm 이면 복부비만(1)
h1 <- h1 %>%
  mutate(wc_gr = case_when(
    sex == 1 & HE_wc >= 90 ~ 1,
    sex == 2 & HE_wc >= 85 ~ 1,
    TRUE                   ~ 2
  ))


# ── 5. 결혼(동거인) 여부 (2구간) ────────────────────────────
# 1: 독거(marri_2==1), 2: 동거(marri_2≥2)
h1 <- h1 %>%
  mutate(marry_gr = case_when(
    marri_2 == 1  ~ 1,
    marri_2 >= 2  ~ 2,
    TRUE          ~ NA_real_
  ))


# ── 6. 외식 빈도 그룹 (3구간) ───────────────────────────────
h1 <- h1 %>%
  mutate(out_gr = case_when(
    L_OUT_FQ %in% c(1, 2, 3) ~ 1,   # 월 1회 미만 ~ 주 1회 미만
    L_OUT_FQ %in% c(4, 5)    ~ 2,   # 주 1회 ~ 주 2~3회
    L_OUT_FQ %in% c(6, 7)    ~ 3,   # 거의 매일 이상
    TRUE                      ~ NA_real_
  ))


# ── 7. 채소류 섭취 빈도 그룹 (3구간) ────────────────────────
h1 <- h1 %>%
  mutate(veg1_gr = case_when(
    LS_VEG1 %in% c(1, 2)          ~ 1,   # 하루 2회 이상
    LS_VEG1 %in% c(3, 4, 5)       ~ 2,   # 주 2~6회
    LS_VEG1 %in% c(6, 7, 8, 9)    ~ 3,   # 주 1회 이하
    TRUE                           ~ NA_real_
  ))


# ── 8. 과일 섭취 빈도 그룹 (5구간) ──────────────────────────
h1 <- h1 %>%
  mutate(fr_gr = case_when(
    LS_FRUIT %in% c(1, 2)    ~ 1,   # 하루 2회 이상
    LS_FRUIT %in% c(3, 4)    ~ 2,   # 하루 1회 ~ 주 5~6회
    LS_FRUIT == 5             ~ 3,   # 주 3~4회
    LS_FRUIT %in% c(6, 7)    ~ 4,   # 주 1~2회
    LS_FRUIT %in% c(8, 9)    ~ 5,   # 월 1회 이하
    TRUE                      ~ NA_real_
  ))


# ── 9. 음주 빈도 그룹 (4구간) ───────────────────────────────
h1 <- h1 %>%
  mutate(bd_gr = case_when(
    BD1_11 %in% c(1, 8)  ~ 1,   # 비음주
    BD1_11 %in% c(2, 3)  ~ 2,   # 월 1회 이하
    BD1_11 == 4           ~ 3,   # 월 2~3회
    BD1_11 %in% c(5, 6)  ~ 4,   # 주 1회 이상
    TRUE                  ~ NA_real_
  ))


# ── 10. 음주량 그룹 (4구간) ─────────────────────────────────
h1 <- h1 %>%
  mutate(bd2_gr = case_when(
    BD2_1 == 8            ~ 1,   # 비해당(비음주)
    BD2_1 %in% c(1, 2)   ~ 2,   # 1~3잔
    BD2_1 %in% c(3, 4)   ~ 3,   # 4~7잔
    BD2_1 == 5            ~ 4,   # 8잔 이상
    TRUE                  ~ NA_real_
  ))


# ── 11. 월 음주량 연속 변수 계산 ────────────────────────────
# BD1_11 → 월 음주 횟수 변환
h1 <- h1 %>%
  mutate(bd_freq_month = case_when(
    BD1_11 == 1 ~ 0,
    BD1_11 == 2 ~ 0.5,    # 월 1회 미만
    BD1_11 == 3 ~ 1,      # 월 1회
    BD1_11 == 4 ~ 2.5,    # 월 2~3회
    BD1_11 == 5 ~ 4,      # 주 1회
    BD1_11 == 6 ~ 10,     # 주 2~3회
    BD1_11 == 8 ~ 0,      # 비해당
    TRUE        ~ NA_real_
  ))

# BD2_1 → 1회 음주량(잔) 변환
h1 <- h1 %>%
  mutate(bd_amount = case_when(
    BD2_1 == 1 ~ 1.5,
    BD2_1 == 2 ~ 3.5,
    BD2_1 == 3 ~ 5.5,
    BD2_1 == 4 ~ 8,
    BD2_1 == 5 ~ 12,
    BD2_1 == 8 ~ 0,      # 비해당
    TRUE       ~ NA_real_
  ))

# 월 음주량 = 월 음주 횟수 × 1회 음주량
h1 <- h1 %>%
  mutate(mon_al = bd_freq_month * bd_amount)


# ── 12. 비만 변수 생성 (bm) ─────────────────────────────────
# 복부비만(허리둘레) AND BMI비만(bmi_gr==3) 동시 충족 시 비만(0)
# 남성: 허리둘레 ≥90cm / 여성: 허리둘레 ≥85cm
h1 <- h1 %>%
  mutate(bm = case_when(
    sex == 1 & HE_wc >= 90 & bmi_gr == 3 ~ 0,   # 남성 비만
    sex == 2 & HE_wc >= 85 & bmi_gr == 3 ~ 0,   # 여성 비만
    TRUE                                  ~ 1    # 비비만
  ))

cat("비만 변수 분포:\n")
table(h1$bm)   # 0: 비만, 1: 비비만


# ── 13. 성별 분리 데이터 업데이트 ───────────────────────────
male_data   <- h1 %>% filter(sex == 1)
female_data <- h1 %>% filter(sex == 2)

cat("\n남성 비만 분포:\n"); table(male_data$bm)
cat("\n여성 비만 분포:\n"); table(female_data$bm)


# ── 14. 복합표본 설계 객체 생성 ─────────────────────────────
# 전체
svd <- svydesign(ids = ~psu, strata = ~kstrata,
                 weights = ~wt_itvex, data = h1)

# 남성
svd_male <- svydesign(ids = ~psu, strata = ~kstrata,
                      weights = ~wt_itvex, data = male_data)

# 여성
svd_female <- svydesign(ids = ~psu, strata = ~kstrata,
                        weights = ~wt_itvex, data = female_data)

cat("\n설계 객체 생성 완료\n")
