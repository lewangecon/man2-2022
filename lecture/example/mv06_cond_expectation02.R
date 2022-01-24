

# This program illustrates how to estimate linear regression and
# calculate the CEF for two different purposes

wagedata <- read.csv("data/wage2.csv") 


# Linear Regression without intercept
results <- lm(wage ~ factor(married)+0, data=wagedata)

