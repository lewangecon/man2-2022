library(fpp)
library(quantmod)
library(tseries)

# Download Coke and Pepsi stock prices
  getSymbols('PEP')
  getSymbols('COKE')

# Need only adjusted prices
  pepsi<-PEP$PEP.Adjusted
  coke<-COKE$COKE.Adjusted

# Generate price changes for each stock
# Note that it is not daily returns because we are interested in dollars
# not the percentage terms

  coke_change<-diff(coke)
  pepsi_change<-diff(pepsi)

  
# Now let's obtain $\beta_1$:

  fit<-lm(pepsi_change ~ coke_change)
  summary(fit)

# Over this time frame, on average, if Coke moves by 1 dollar, then Pepsi will move by  
  summary(fit)$coefficients[2,1]
  
# Let's calculate the number of shares
  1000/summary(fit)$coefficients[2,1]



