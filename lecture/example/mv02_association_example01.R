# This program illustrates concepts related to 
# 1) meausres of linear relationship: covariance and correlation
# 2) Distributional relationship

library(quantmod)
# S&P 500 stock market index 
# the date when VXX was available 
getSymbols("SPY", from="2013-01-01")

# Equity Market Volatility 
# track the S&P 500 VIX Short-Term 
# Futures Index Total Return 

getSymbols("VXX", from="2013-01-01")

# Generate daily returns 

spy<-SPY$SPY.Adjusted 
spy_returns<- na.omit(diff(log(spy)))
vxx<-VXX$VXX.Adjusted 
vxx_returns <- na.omit(diff(log(vxx)))



# Covariance
cov(spy_returns, vxx_returns)

# Correlation
cor(spy_returns, vxx_returns)

# DIY to calculate correlation
cov(spy_returns, vxx_returns)/(sd(spy_returns)*sd(vxx_returns))


# Test of Zero Correlation

cor.test(vxx_returns,spy_returns, alternative = "two.side")


# Correlation and Independence

set.seed(123456)
x<-rnorm(100)
x2<-x^2
cor.test(x,x2)

# Tests of Independence (Distribution)

install.packages("np")
library(np) 

getSymbols("PEP")
getSymbols("COKE")


pepsi<-PEP$PEP.Adjusted 
pepsi_returns<- na.omit(diff(log(pepsi)))

coke<-COKE$COKE.Adjusted 
coke_returns<- na.omit(diff(log(coke)))

# Correlation 

cor(pepsi_returns, coke_returns)

# Note that we strongly advocate the use of the integration (default) 
# version of the statistic in applied settings but use the summation 
# (i.e. moment) version below purely by way of demonstration as it is computationally faster.

pepsi_returns<-as.vector(pepsi_returns) 
coke_returns<-as.vector(coke_returns)

npdeptest(coke_returns,pepsi_returns,boot.num=30,method="summation")





pepsi_returns<-as.vector(pepsi_returns) 
coke_returns<-as.vector(coke_returns)

npdeptest(coke_returns,pepsi_returns,boot.num=30,method="summation")