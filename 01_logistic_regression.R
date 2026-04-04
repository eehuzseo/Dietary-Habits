# ============================================================
# 01_logistic_regression.R
# 목적: 복합표본 설계를 반영한 로지스틱 회귀분석 수행
#       - 남성 / 여성 각각 svyglm(quasibinomial) 적용
#       - 다중공산성(VIF) 진단
#       - 오즈비(OR) 및 95% 신뢰구간 산출
#       - ROC 커브 및 AUC 계산
# ============================================================

library(survey)
library(car)
library(pROC)


# ════════════════════════════════════════════════════════════
# [1] 남성 로지스틱 회귀분석
# ════════════════════════════════════════════════════════════

# 복합표본 설계 객체 (남성)
svd_male_lr <- svydesign(ids = ~psu, strata = ~kstrata,
                         weights = ~wt_itvex, data = male_data)

# 로지스틱 회귀모형
male_logit <- svyglm(
  bm ~ L_BR_FQ + bd_gr + bd2_gr + LS_FRUIT +
       L_BR_TO + L_OUT_FQ + ho_incm + age + marry_gr,
  design = svd_male_lr,
  family  = quasibinomial
)

cat("\n======== 남성 로지스틱 회귀 요약 ========\n")
summary(male_logit)

# 다중공산성(VIF) 진단
cat("\n남성 VIF:\n")
print(car::vif(male_logit))

# 오즈비 및 95% 신뢰구간
cat("\n남성 오즈비(OR):\n")
print(exp(coef(male_logit)))

cat("\n남성 95% 신뢰구간:\n")
print(exp(confint.default(male_logit)))

# ROC 커브 및 AUC
male_data$pred_prob <- predict(male_logit, type = "response")

roc_male <- roc(male_data$bm, male_data$pred_prob)
plot(roc_male,
     main = "ROC Curve - Male",
     col  = "blue", lwd = 2)

cat("\nAUC (남성):", auc(roc_male), "\n")


# ════════════════════════════════════════════════════════════
# [2] 여성 로지스틱 회귀분석
# ════════════════════════════════════════════════════════════

# 복합표본 설계 객체 (여성)
svd_female_lr <- svydesign(ids = ~psu, strata = ~kstrata,
                           weights = ~wt_itvex, data = female_data)

# 로지스틱 회귀모형
female_logit <- svyglm(
  bm ~ L_BR_FQ + LK_LB_CO + bd_gr + bd2_gr + LS_FRUIT +
       veg1_gr + out_gr + L_BR_TO + ho_incm + edu + age + marry_gr,
  design = svd_female_lr,
  family  = quasibinomial
)

cat("\n======== 여성 로지스틱 회귀 요약 ========\n")
summary(female_logit)

# 다중공산성(VIF) 진단
cat("\n여성 VIF:\n")
print(car::vif(female_logit))

# 오즈비 및 95% 신뢰구간
cat("\n여성 오즈비(OR):\n")
print(exp(coef(female_logit)))

cat("\n여성 95% 신뢰구간:\n")
print(exp(confint.default(female_logit)))

# ROC 커브 및 AUC
female_data$pred_prob <- predict(female_logit, type = "response")

roc_female <- roc(female_data$bm, female_data$pred_prob)
plot(roc_female,
     main = "ROC Curve - Female",
     col  = "red", lwd = 2)

cat("\nAUC (여성):", auc(roc_female), "\n")
