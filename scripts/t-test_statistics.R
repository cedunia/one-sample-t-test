## READ IN DATA ##
source("./scripts/t-test_cleaning.R")

## LOAD PACKAGES ##

## ORGANIZE DATA ##
data_stats <- data_clean

## BUILD MODEL ##
# T-TEST (base R)

data_stats.t_computed <- t.test(data_stats$systolic, mu = 127.2)
data_stats.t_tabulated <- qt(0.975, 44)