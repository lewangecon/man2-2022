# This program illustrates how you can use conditional distribution
# for different words to generate documents (a collection of texts)

# This example is from an online discussion
# This only thing we need to do is to replace the states with our words
# and the transition with ours.

# https://stackoverflow.com/questions/49624119/text-generation-using-markov-chains-in-r

# Note that we need to set the seed to ensure replication of our results:
# Question: Why?
set.seed(123456)

# define the states
words <- c("hello", "how", "are", "you")

# define the transition matrix (each row sums to 1)
transitions <-  rbind(c(0.1, 0.2, 0.3, 0.4),
                      c(0.1, 0.2, 0.3, 0.4),
                      c(0.1, 0.2, 0.3, 0.4),
                      c(0.1, 0.2, 0.3, 0.4))
rownames(transitions) <- colnames(transitions) <- words

# define a markovchain object
library(markovchain)
markovChain <- new("markovchain", states=words, 
                   transitionMatrix = transitions)

# sample from the Markov chain
# initial value given by t0
markovchainSequence(10, markovChain, t0="hello")
