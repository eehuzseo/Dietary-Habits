# ============================================================
# 01_load_data.R
# 목적: 필요한 패키지 설치·로드 및 원시 데이터 불러오기
# 데이터: 국민건강영양조사 (복합표본 설계 적용)
# ============================================================

# ── 패키지 설치 (최초 1회만 실행) ──────────────────────────
# install.packages(c("sas7bdat", "dplyr", "psych", "descr",
#                    "gmodels", "survey", "srvyr", "car", "pROC"))

# ── 패키지 로드 ─────────────────────────────────────────────
library(sas7bdat)
library(dplyr)
library(psych)
library(descr)
library(gmodels)
library(survey)
library(srvyr)
library(car)
library(pROC)

# ── 작업 디렉토리 설정 ──────────────────────────────────────
# setwd("")  
# dir()

# ── 데이터 로드 ─────────────────────────────────────────────
h <- read.csv("data.csv", fileEncoding = "UTF-8")
head(h)

# 전체 표본 수 확인
freq(h$sex)   # 총 7,090명
