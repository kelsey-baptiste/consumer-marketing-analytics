install.packages("readxl")
library(readxl)
bls_data <- read_excel(file.choose())
names(bls_data)[names(bls_data) %in% c(
  "NEWID",
  "FINLWT21",
  "TOTEXPCQ",
  "FINCBTXM",
  "AGE_REF",
  "EDUC_REF",
  "FAM_SIZE",
  "FAM_TYPE"
)]
head(bls_data[c(
  "NEWID",
  "FINLWT21",
  "TOTEXPCQ",
  "FINCBTXM",
  "AGE_REF",
  "EDUC_REF",
  "FAM_SIZE",
  "FAM_TYPE"
)])
unique(bls_data$AGE_REF)

unique(bls_data$EDUC_REF)

table(bls_data$EDUC_REF)
unique(bls_data$EDUC_REF[bls_data$EDUC_REF == "77"])
table(bls_data$EDUC_REF, useNA = "ifany")

table(bls_data$EDUCATION, useNA = "ifany")
summary(bls_data$FINCBTXM)
sum(bls_data$FINCBTXM < 0, na.rm = TRUE)
sum(is.na(bls_data$FINCBTXM))
quantile(
  bls_data$FINCBTXM,
  probs = c(0, 0.25, 0.50, 0.75, 1),
  na.rm = TRUE
)
bls_data$INCOME_GROUP <- cut(
  bls_data$FINCBTXM,
  breaks = c(-Inf, 34616.5, 72000, 132837.2, Inf),
  labels = c(
    "Q1 - Lower income",
    "Q2 - Lower-middle income",
    "Q3 - Upper-middle income",
    "Q4 - Higher income"
  ),
  include.lowest = TRUE
)
table(bls_data$INCOME_GROUP, useNA = "ifany")
summary(bls_data$TOTEXPCQ)
sum(bls_data$TOTEXPCQ == 0, na.rm = TRUE)
sum(is.na(bls_data$TOTEXPCQ))
bls_data$INCOME_GROUP <- cut(
  bls_data$FINCBTXM,
  breaks = c(-Inf, 34616.5, 72000, 132837.2, Inf),
  labels = c(
    "Q1 - Lower income",
    "Q2 - Lower-middle income",
    "Q3 - Upper-middle income",
    "Q4 - Higher income"
  ),
  include.lowest = TRUE
)bls_data$INCOME_GROUP <- cut(
  bls_data$FINCBTXM,
  breaks = c(-Inf, 34616.5, 72000, 132837.2, Inf),
  labels = c(
    "Q1 - Lower income",
    "Q2 - Lower-middle income",
    "Q3 - Upper-middle income",
    "Q4 - Higher income"
  ),
  include.lowest = TRUE
)
bls_data$INCOME_GROUP <- cut(
  bls_data$FINCBTXM,
  breaks = c(-Inf, 34616.5, 72000, 132837.2, Inf),
  labels = c(
    "Q1 - Lower income",
    "Q2 - Lower-middle income",
    "Q3 - Upper-middle income",
    "Q4 - Higher income"
  ),
  include.lowest = TRUE
)
summary(bls_data$FINLWT21)
sum(is.na(bls_data$FINLWT21))
# Weighted spending by income group
weighted_spending <- bls_data %>%
  group_by(INCOME_GROUP) %>%
  summarise(
    weighted_avg_spending = weighted.mean(
      TOTEXPCQ,
      FINLWT21,
      na.rm = TRUE
    )
  )

weighted_spending

# Weighted spending by education level
weighted_education <- bls_data %>%
  group_by(EDUCATION) %>%
  summarise(
    weighted_avg_spending = weighted.mean(
      TOTEXPCQ,
      FINLWT21,
      na.rm = TRUE
    )
  )
bls_q2 <- read.csv("~/Desktop/intrvw24/fmli242.csv")

weighted_education
