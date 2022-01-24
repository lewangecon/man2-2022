# This program illustrates how we actually obtain the transition matrix

library(MASS)
library(tidyverse)
library(dplyr)
library(tidytext)
library(janeaustenr)
library(ggplot2)
library(tidyr)


# Simulate some data

  set.seed(123456)
  mu <- c(0,0)
  Sigma <- matrix(c(10,3,3,10),2,2)
  
  
  data <- mvrnorm(n = 1000, mu, Sigma)
  
  # Put it into data frame
  data <- data.frame(
    parents = data[,1],
    child = data[,2]
  )
  
  head(data)
  


# Tidy way to discretize a continuous variable
install.packages("arules")
library("arules")

# Discretize the income by equal frequency

data<- data %>%
    mutate(
      parentsD = discretize(parents, method = "frequency", breaks = 4),
      childD = discretize(child, method = "frequency", breaks = 4),
    )

str(data)

# Joint Distribution
joint.dist<-prop.table(table(data$parentsD,data$childD))

joint.dist

# Marginal Distribution for the income distribution for parents

joint.dist <- addmargins(joint.dist)

# Transition Matrix (short-cut)

transition.matrix <- joint.dist[,-5]/joint.dist[,5]
transition.matrix

# Second Approach: Direct one
cond.dist<-prop.table(table(data$parentsD,data$childD), margin = 1)
cond.dist

