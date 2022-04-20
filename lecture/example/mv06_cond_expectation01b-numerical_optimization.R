# This program illustrate the grid search method to numerical 
# optimization by solving the linear regression problem. 


library(tidyverse)

# Generate artificial data with three data points
data <- data.frame(x = c(1:3)) %>% 
  mutate(y = 2*x + rnorm(3))

# Program a function to calculate mean squared error
# for a given beta coefficient
mymse <- function(beta){
  # Step 1. Generate prediction
  data$yhat   <- beta*data$x
  data$error  <- data$y-data$yhat
  data$error2 <- data$error^2
  mse <- mean(data$error2)
  
  return(mse)
}

# Try all possible beta values from 1 to 3
all.mse <- sapply(seq(1,3,.01), mymse)
results <- data.frame(
  beta = seq(1,3,.01),
  mse = all.mse)

# Plot the relationship
ggplot(data = results, mapping = aes(x = beta, y = mse)) +
  geom_point()

# Find out the optimal value
  # find out the position of the smallest MSE
  index <- which(results$mse==min(results$mse))
  index 
  # find out the corresponding beta value
  results$beta[index]
  
  # Interpretation: Of course, due to sampling errors, we do not necessarily
  # obtain the true coefficient. To see the impact of the sampling errors,
  # we can remove the random part in our data generating process, we will
  # see that we can now attain the true beta. 