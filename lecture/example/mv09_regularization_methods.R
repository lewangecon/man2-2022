# This program illustrates how to implement
# both ridge and lasso regressions in R

install.packages("glmnet")
library(glmnet)


wagedata <- read.csv("data/wage2.csv")

wagedata <- na.omit(wagedata)

# lets get rid of ln wages since we will be using all the variables
wagedata <- wagedata[,-17]

# This command generates the intercept automatically
# we need to get rid of it since the command automatically
# standardize the variables for us

# Predictors
X <- model.matrix(wage ~ ., wagedata)[,-1]

# Outcome variable
y <- wagedata$wage

# Linear Regression
  fit.lr <- lm(wage ~ ., wagedata)
  coef(fit.lr)

# Lets examine the sum of L1 and L2 norm of all 
# the estimated coefficients
  
  sum(abs(coef(fit.lr)[-1]))
  sum(coef(fit.lr)[-1] ^ 2)


# Ridge Regression
# The two plots illustrate how much the coefficients are 
# penalized for different values of lambda. 
# Notice none of the coefficients are forced to be zero.

  par(mfrow = c(1, 2))
  
  # Ridge regression when alpha is set to zero
  # Lasso regression when alpha is set to one
  
  fit.ridge <- glmnet(X, y, alpha = 0)
  plot(fit.ridge)
  plot(fit.ridge, xvar = "lambda", label = TRUE)
  
  # We can use cross-validation to select a good lambda value
  
  fit.ridge.cv <- cv.glmnet(X, y, alpha = 0)
  plot(fit.ridge.cv)
  
  # Two vertical lines are drawn. The first is the lambda that 
  # gives the smallest MSE. The second is the that gives 
  # an MSE within one standard error of the smallest.

  # We can examine the details of the results
  # for both these values
  coef(fit.ridge.cv)
  
  
  coef(fit.ridge.cv, s = "lambda.min")
  
  # lets pick our best lambda
  bestlambda.ridge <- fit.ridge.cv$lambda.min
  bestlambda.ridge

  # predict using minimum lambda
  X[1:2,]
  
  # Note that you have to use a matrix (of more than two observations)
  # otherwise cbind2(1,X) wont work.
  predict(fit.ridge.cv, X[1:2,], s = bestlambda.ridge)
  
  
  
# Lasso Regression
# The two plots illustrate how much the coefficients are 
# penalized for different values of lambda. 

  par(mfrow = c(1, 2))
  
  # Ridge regression when alpha is set to zero
  # Lasso regression when alpha is set to one
  
  # Step 1. Estimation
  
  fit.lasso <- glmnet(X, y, alpha = 1)
  plot(fit.lasso)
  plot(fit.lasso, xvar = "lambda", label = TRUE)
  
  # Step 1.a Optimal lambda
  # We can use cross-validation to select a good lambda value
  
  fit.lasso.cv <- cv.glmnet(X, y, alpha = 1)
  plot(fit.lasso.cv)
  
  # Two vertical lines are drawn. The first is the lambda that 
  # gives the smallest MSE. The second is the that gives 
  # an MSE within one standard error of the smallest.
  
  # We can examine the details of the results
  # for the lambda value that minimizes the MSE
  coef(fit.lasso.cv, s = "lambda.min")
  

  
  # Step 2. lets pick our best lambda
  bestlambda.lasso <- fit.lasso.cv$lambda.min
  bestlambda.lasso
  
  # predict using minimum lambda
  X[1:2,]
  
  # Note that you have to use a matrix (of more than two observations)
  # otherwise cbind2(1,X) wont work.
  predict(fit.lasso.cv, X[1:2,], s = bestlambda.lasso)  

  
  
    