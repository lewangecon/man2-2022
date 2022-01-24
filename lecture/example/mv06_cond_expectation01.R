# This program illustrates how to calculate the CEF 
# and use it for two different purposes

library(tidyverse)
wagedata <- read.csv("data/wage2.csv") 
attach(wagedata)

# Example 1: Binary Variable

# Use of CEF (I): Prediction
# Approach 1:

  aggregate(wage,by=list(married),FUN=mean) 
  results <-aggregate(wage,by=list(married),FUN=mean)[2] 
  
  results

# Approach 2:
  library(dplyr)
  
  wagedata %>% 
    group_by(married) %>% 
    summarise(mean = mean(wage,na.rm = TRUE))

# Use of CEF (II): Partial Effects of Marriage (or Marriage Premium)

  results
  results[2,1]-results[1,1]

  
# Example 2: Multivalued Discrete Variable
  
  wagedata$education <- NA
  
  wagedata$education[educ<12] <- 1
  wagedata$education[educ==12] <- 2
  wagedata$education[educ>12] <- 3
  
  
  attach(wagedata)
  
# Approach 1:
  
  aggregate(wage,by=list(education),FUN=mean,data=wagedata)
  
  
# Approach 2: Tidy approach
  
  wagedata %>% 
    mutate(education = case_when(
      educ <12 ~ 1,
      educ==12 ~ 2,
      educ>12 ~ 3
    )) %>% 
    group_by(education) %>% 
    summarise(mean = mean(wage,na.rm = TRUE))  
    