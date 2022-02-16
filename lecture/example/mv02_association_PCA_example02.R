

library(tidyverse)

data <- tribble(
  ~x, ~y, 
  #--, -- indicate what follows is data
  -20, -8,
  -10, -1,
  0, 0,
  10,1,
  20,8
)


cov <- cov(data)

Eigenvectors <- eigen(cov(data))$vectors
Eigenvalues <- eigen(cov(data))$values

Eigenvalues
Eigenvectors

PCAresults <- prcomp(data)
PCAresults$sdev^2

as.matrix(data) %*% c(0.95, 0.33)
as.matrix(data) %*% Eigenvectors
as.matrix(data) %*% Eigenvectors[,1]




one eigenvalue is much larger than the other, indicating a sig- nificant difference in the variance in the two derived dimensions. Even though this data is non-linear, we can get a pretty decent linear fit in 1D and the best single linear axis for the data is represented by the eigenvector associated with the large eigenvalue