## LOAD PACKAGES ##
library(dplyr)
library(magrittr)

## READ IN DATA ##
data <- read.csv('./data/blood_pressure.csv', header = TRUE, sep = '\t')

## ORGANIZE DATA ##

##Assumption1: var continous
colnames(data) <- "systolic"
class(data$systolic)

##Assumption2: var independant
#measure taken all the day during 24 hour.

##Assumption3: no outliers
# Get systolic outlier information
data_systolic_sum = data %>% summarise(systolic_mean = mean(systolic),
            systolic_sd = sd(systolic)) %>%
  ungroup() %>%
  mutate(systolic_high = systolic_mean + (2 * systolic_sd)) %>%
  mutate(systolic_low = systolic_mean - (2 * systolic_sd))

# Remove data points with slow/high systolic values
data_clean = data %>% filter(systolic < data_systolic_sum$systolic_high) %>%
  filter(systolic > data_systolic_sum$systolic_low)

##Assumption4: normal distribution
shapiro <- shapiro.test(data_clean$systolic)
