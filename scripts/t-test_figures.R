## READ IN DATA ##
source("./scripts/t-test_cleaning.R")

## LOAD PACKAGES ##
library(ggplot2)

## ORGANIZE DATA ##
data_figs <- data_clean

## MAKE FIGURES ##
# histogram visualization
systolic_histogram.plot <- ggplot(data_figs, 
       aes(x = systolic, fill = systolic)) +
  geom_histogram(bins = 10, colour = "#0571b0", fill = "#ca0020") +
  ggtitle("Systolic blood pressure in mmHg for 24 hour") +
  xlab("systolic blood pressure") +
  ylab("Count") +
  theme_classic() +
  theme(text=element_text(size=18), title=element_text(size=18),
        legend.position="none",
        strip.background = element_rect(color="white", fill="white"))
pdf("figures/systolic_blood_pressure_histogram.pdf")
systolic_histogram.plot
dev.off()

# qqplot
y <- quantile(data_figs$systolic[!is.na(data_figs$systolic)], 
              c(0.25, 0.75))
x <- qnorm(c(0.25, 0.75))
slope <- diff(y)/diff(x)
int <- y[1L] - slope * x[1L]
systolic.qqplot <- ggplot(data_figs, aes(sample = systolic))+ 
  stat_qq() + geom_abline(slope = slope, intercept = int) +
  annotate("text", x = 2, y = 120, label = round(shapiro$p.value,4))
  
pdf("figures/systolic_blood_pressure_qqplot.pdf")
systolic.qqplot
dev.off()