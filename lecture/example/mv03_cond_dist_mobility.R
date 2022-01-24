# This program illustrates what a transition will look like
# as a markov chain object

install.packages("markovchain")
install.packages("MmgraphR")

library("markovchain")
data("blanden") 

blanden

mobilityMc <- as(blanden, "markovchain") 

# Display the results
mobilityMc


# Change the order of the transition matrix
mobilityMc2 <- mobilityMc[,c(3,1,2,4)]
mobilityMc2

# Below is a package that is no longer available.
# We can graph the transition matrix
# where each line is weighted by probability.

# library("MmgraphR")

# stochastic_matrix_to_plot <- as(mobilityMc,"matrix")
# trmatplot(stochastic_matrix_to_plot,main="Income Mobility")

# For example, we do see a lot of lateral movement from one period to the next
