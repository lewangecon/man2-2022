# Illustrate how we can use the connection to mean
# generate dummy variables and calculate the means
# of the variables for each combination of the predictors

# Simulate artificial data 

  set.seed(123456) 
  y <- sample(c(1:4),1000,replace= TRUE, prob=c(0.25,0.25,.25,.25)) 
  
  x <- sample(c(0:1),1000,replace= TRUE, prob=c(0.5,0.5)) 
  z <- sample(c(0:1),1000, replace= TRUE, prob=c(0.25,0.75))
  
  data <- as.data.frame(cbind(y,x,z)) 
  attach(data)

  head(data)
  
# Step 1. Generate new indicator variables
  
  data$dummies <- model.matrix(~factor(y)+0, data=data) 
  head(data) 
  
  # if we do not specify + 0, we will automatically one category
  # data$dummies <- model.matrix(~factor(y), data=data) 
  # head(data)   
  
# Step 2. Calculate the mean of each variables for each combination of predictors  
  aggregate(data$dummies,by=list(x),FUN=mean) 
  
  aggregate(data$dummies,by=list(x),FUN=mean)[2:5]  
  
  # We can easily extend it to more than one variables
  aggregate(data$dummies,by=list(x,z),FUN=mean) 
  
  