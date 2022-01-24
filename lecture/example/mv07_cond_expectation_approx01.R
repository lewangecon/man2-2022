# This program illustrates three possible solutions 
# to approximate the CEF with a continuous predictor.

wagedata <- read.csv("data/wage2.csv") 
attach(wagedata) 

# Solution (1): Kernel Estimation
# closedness is defined as within 2 units

  # Manual Approach
  # Prediction for 50
  mean(wage[IQ >= (50 - 2) & IQ <= (50 + 2)])

  # Prediction for 80
  mean(wage[IQ >= (80 - 2) & IQ <= (80 + 2)])
  
  # Prediction for 100
  mean(wage[IQ >= (100 - 2) & IQ <= (100 + 2)])
  

  # Function Approach
  # Define a function that can take on arbitrary set of values
  # and definition of closedness
  
  np <- function(x,k){
    
    return(mean(wage[IQ <= ( x + k) & IQ >= (x - k)])) 
    
  }
  
  # Calculate predictions for only three data points
  mydata <- c(50, 80, 100)
  sapply(mydata, np, k=2)
  
  # Calculate predictions for every data point
  wagedata$results <- sapply(IQ, np, k=2)
  View(wagedata)  
  
  
# Solution (1) Extension: General Kernel Estimation
# Nadaraya-Watson kernel regression estimator
  
  nonpar.reg.largebw <- ksmooth(IQ, wage, kernel="normal")
  
  plot(nonpar.reg.largebw)  
  
  # We can assess the points for which this command calculate the predictions
  nonpar.reg.largebw
  
  # We can select our own points
  nonpar.reg.largebw <- ksmooth(IQ, wage, kernel="normal", x.points = c(50,80,100))
  
# Solution (2): K-nearest Neighbor Estimation    
  
  # Manual Approach
  
  x<-60 
  K<-3
  # List the data from the smallest
  order(abs(IQ-x))[1:K] 
  
  # Pick the closest k neighbors
  wage[order(abs(IQ-x))[1:K]]
  mean(wage[order(abs(IQ-x))[1:K]])  
  
  
  # Function approach
  
  KKN <- function(x,K){
    return(mean(wage[order(abs(IQ-x))[1:K]]))
  }
  
  mydata <- c(50, 80, 100)
  sapply(mydata,KKN,K=3)
  
  wagedata$results_KKN<-sapply(IQ,KKN,K=3)
  View(wagedata) 
  
  
  # Tidyverse approach
  
  library(tidyverse)
  wagedata %>% 
    mutate(d = abs(IQ - 80)) %>% 
    arrange(d) %>% 
    filter(row_number() <=4) %>% 
    summarise(mean(wage))  
  
# Solution (3): Parametric Linear Regression
  
  results<-lm(wage~IQ)
  results
  
  new<-data.frame(IQ=c(50,80, 100))
  predict(results,new)  
  
  
  # More than one variable
  
  # Estimate the model
  results<-lm(wage~married+IQ+black,data=wagedata)
  
  # Generate data for the values that you need to predict for
  new<-data.frame(married=0,black=1,IQ=120)
  
  # Prediction
  predict(results,new)