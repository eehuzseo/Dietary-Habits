# ============================================================
# 01_crosstabs_chisq.R
# 목적: 비만 변수(bm)와 각 독립변수 간
#       복합표본 카이제곱 검정 및 가중 교차표 산출
#       → 남성(svd_male) / 여성(svd_female) 각각 수행
# ============================================================

# ── 공통 함수: 가중 교차표 + 행별 백분율 출력 ───────────────
print_crosstab <- function(design, formula, var_label) {
  cat("\n", rep("=", 60), "\n", sep = "")
  cat("변수:", var_label, "\n")
  cat(rep("-", 60), "\n", sep = "")

  # 카이제곱 검정
  result <- svychisq(formula, design = design)
  cat("카이제곱 검정 결과:\n")
  print(result)

  # 가중 교차표
  cross_table <- svytable(formula, design = design)
  cat("\n가중 교차표:\n")
  print(cross_table)

  # 행별 백분율
  pct_0 <- (cross_table[1, ] / sum(cross_table[1, ])) * 100
  pct_1 <- (cross_table[2, ] / sum(cross_table[2, ])) * 100
  cat("\nbm=0(비만) 행 백분율(%):\n"); print(round(pct_0, 1))
  cat("bm=1(비비만) 행 백분율(%):\n"); print(round(pct_1, 1))
}


# ════════════════════════════════════════════════════════════
# [1] 전체 성별 분포 확인
# ════════════════════════════════════════════════════════════
cat("\n전체 성별 분포:\n")
svytable(~sex, design = svd)


# ════════════════════════════════════════════════════════════
# [2] 남성 분석
# ════════════════════════════════════════════════════════════
cat("\n\n======== 남성 분석 ========\n")

# 연령 그룹
print_crosstab(svd_male, ~bm + age_gr,   "연령 그룹")

# 소득 수준
print_crosstab(svd_male, ~bm + ho_incm,  "소득 수준")

# 교육 수준
print_crosstab(svd_male, ~bm + edu,      "교육 수준")

# 결혼(동거인) 여부
print_crosstab(svd_male, ~bm + marry_gr, "동거인 여부")

# 아침 식사 빈도 (결식)
print_crosstab(svd_male, ~bm + L_BR_FQ, "아침 식사 빈도")

# 아침 동반 여부
print_crosstab(svd_male, ~bm + L_BR_TO, "아침 동반 여부")

# 점심 동반 여부
print_crosstab(svd_male, ~bm + L_LN_TO, "점심 동반 여부")

# 저녁 동반 여부
print_crosstab(svd_male, ~bm + L_DN_TO, "저녁 동반 여부")

# 외식 빈도
print_crosstab(svd_male, ~bm + out_gr,  "외식 빈도")

# 채소류 섭취 빈도
print_crosstab(svd_male, ~bm + veg1_gr, "채소류 섭취 빈도")

# 채소류(장아찌 제외) 섭취 빈도
print_crosstab(svd_male, ~bm + LS_VEG2, "채소류(장아찌 제외) 섭취 빈도")

# 과일 섭취 빈도
print_crosstab(svd_male, ~bm + fr_gr,   "과일 섭취 빈도")

# 식이보충제 복용 여부
print_crosstab(svd_male, ~bm + LS_1YR,  "식이보충제 복용 여부")

# 영양표시 인지 여부
print_crosstab(svd_male, ~bm + LK_LB_CO,"영양표시 인지 여부")

# 음주 빈도
print_crosstab(svd_male, ~bm + bd_gr,   "음주 빈도")

# 음주량
print_crosstab(svd_male, ~bm + bd2_gr,  "음주량")


# ════════════════════════════════════════════════════════════
# [3] 여성 분석
# ════════════════════════════════════════════════════════════
cat("\n\n======== 여성 분석 ========\n")

# 연령 그룹
print_crosstab(svd_female, ~bm + age_gr,   "연령 그룹")

# 소득 수준
print_crosstab(svd_female, ~bm + ho_incm,  "소득 수준")

# 교육 수준
print_crosstab(svd_female, ~bm + edu,      "교육 수준")

# 결혼(동거인) 여부
print_crosstab(svd_female, ~bm + marry_gr, "동거인 여부")

# 아침 식사 빈도 (결식)
print_crosstab(svd_female, ~bm + L_BR_FQ, "아침 식사 빈도")

# 아침 동반 여부
print_crosstab(svd_female, ~bm + L_BR_TO, "아침 동반 여부")

# 점심 동반 여부
print_crosstab(svd_female, ~bm + L_LN_TO, "점심 동반 여부")

# 저녁 동반 여부
print_crosstab(svd_female, ~bm + L_DN_TO, "저녁 동반 여부")

# 외식 빈도
print_crosstab(svd_female, ~bm + out_gr,  "외식 빈도")

# 채소류 섭취 빈도
print_crosstab(svd_female, ~bm + veg1_gr, "채소류 섭취 빈도")

# 채소류(장아찌 제외) 섭취 빈도
print_crosstab(svd_female, ~bm + LS_VEG2, "채소류(장아찌 제외) 섭취 빈도")

# 과일 섭취 빈도
print_crosstab(svd_female, ~bm + fr_gr,   "과일 섭취 빈도")

# 식이보충제 복용 여부
print_crosstab(svd_female, ~bm + LS_1YR,  "식이보충제 복용 여부")

# 영양표시 인지 여부
print_crosstab(svd_female, ~bm + LK_LB_CO,"영양표시 인지 여부")

# 음주 빈도
print_crosstab(svd_female, ~bm + bd_gr,   "음주 빈도")

# 음주량
print_crosstab(svd_female, ~bm + bd2_gr,  "음주량")
