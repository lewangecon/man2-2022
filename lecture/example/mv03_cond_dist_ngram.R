# This program illustrates how to analyze text by modelling the relationship
# between words. The distribution for ngram is nothing but the joint distribution
# of two words (X and Y)

# This program is adapted from Text Mining with R (Silge and Robinson)
# available here at https://www.tidytextmining.com/ngrams.html

library(tidyverse)
library(dplyr)
library(tidytext)
library(janeaustenr)
library(ggplot2)
library(tidyr)


# How many books of Jane Austen (a game theorist) have we downloaded?
# https://www.amazon.com/Jane-Austen-Game-Theorist-Updated/dp/0691162441/ref=sr_1_1?crid=IOOIDPEHFHMM&keywords=jane+austen+game+theorist&qid=1582509509&sprefix=Jane+austen+game+the%2Caps%2C182&sr=8-1
  table(austen_books()$'book')

# We will examine pairs of two consecutive words, called "bigrams"
# tokenize the "text" variable with bigram, and save this information
# in a variable called "bigram"

  austen_bigrams <- austen_books() %>%
    unnest_tokens(bigram, text, token = "ngrams", n = 2)
  
  austen_bigrams

# Let's examine what are the most common bigrams

  austen_bigrams %>%
    count(bigram, sort = TRUE)

# Now let's treat each word as X and Y
# The first word as X (predictor) and the second as Y (outcome)

  
  bigrams_separated <- austen_bigrams %>%
    separate(bigram, c("word1", "word2"), sep = " ")

# Let's get rid of all the stop words
  bigrams_filtered <- bigrams_separated %>%
    filter(!word1 %in% stop_words$word) %>%
    filter(!word2 %in% stop_words$word)

# new bigram counts:
  bigram_counts <- bigrams_filtered %>% 
    count(word1, word2, sort = TRUE)
  
  bigram_counts

# names (whether first and last or with a salutation) 
# are the most common pairs in Jane Austen books.

# Note that you can reverse the action of splitting words
# with unite()

  bigrams_united <- bigrams_filtered %>%
    unite(bigram, word1, word2, sep = " ")
    #    ~~~~~~~
    # word1 + word2 ==> bigram
  
  bigrams_united
  
  # Let's calculate the frequency for each pair of words
  
  # traiditional way, but immediately difficult to read
  prop.table(table(bigrams_united$bigram))['sir thomas']
  
  # tidy approach; generate a data frame (tibble) more readable. 
  joint.dist<-bigrams_united %>% 
    count(bigram, sort = TRUE) 
  
  joint.dist
  
  joint.dist<-bigrams_united %>% 
    count(bigram, sort = TRUE) %>% 
      mutate(
        freq = n/sum(n)
      )
  
  ######################
  # We will use this approach again below
  # Note the variable "n"
  ######################
  
  
  prop.table(table(bigrams_united$bigram))['sir thomas']
  
  # We can visualize the joint distribution (just treating two words as one compound word!) as we did last semester
  
  ggplot(joint.dist[joint.dist$freq>=0.001,], mapping = aes(x=reorder(bigram,freq),y=freq)) +
    geom_bar(stat="identity") +
    coord_flip()
  
  # thousand pounds refer to money about a property that they were trying to sell.
  
  
# Let's calculate the probabiity of the first sentence
# View(austen_book())
  
# The family of Dashwood had long been settled in Sussex.  
  
# Let's examine which word is actually a stop word?
  
  sentence <- "The family of Dashwood had long been settled in Sussex"
  
  
  "the" %in% stop_words$word
  "family" %in% stop_words$word
  "of" %in% stop_words$word
  "dashwood" %in% stop_words$word
  "had" %in% stop_words$word
  "been" %in% stop_words$word
  "settled" %in% stop_words$word
  "long" %in% stop_words$word
  "sussex" %in% stop_words$word
  
  # a non-trivial sentence: family dashwood settled sussex
  
  # A non-repetitive solution
  
    # set every word to lower case first
    s.lower <- tolower(sentence)
    
    # split the sentence
    s.split <- strsplit(s.lower, " ")
    s.split
    
    # unlist it so that it is a vector
    s.split <- unlist(s.split)
    s.split
  
    # Write a function that repeats the evaluation for us
    # and apply it to every word in the vector
    select<-lapply(s.split, function(word){
        
        word %in% stop_words$word
      
        }
    )
    
    select
  
    # unlist the list so that it is a logical vector
    select <- unlist(select)
    select
  
    # select out the words
    s.split[select!="TRUE"]


    # We cannot calculate family dashwood since all the stop words were excluded
    # we do not have words called family dashwood in our data
    # To show the idea
    # Correct way to obtain pr[party | family]
    bigrams_filtered %>%
      filter(word1 == "family") %>%
      count(word2, sort = TRUE) %>%
      mutate( 
        freq = n/sum(n)
      )    %>%
      filter(word2 == "party")  
  
# Suppose that you are interested in predicting a word coming after sir
# You just need to use Bayes classifier with the next word being Y
# Below is a toy novel writer starting with "sir"!
    
  
  bigrams_filtered %>%
    filter(word1 == "sir") %>%
    count(word2, sort = TRUE) %>%
    mutate( 
      freq = n/sum(n)
    ) 
  
  
  bigrams_filtered %>%
    filter(word1 == "thomas") %>%
    count(word2, sort = TRUE) %>%
    mutate( 
      freq = n/sum(n)
    )    
  
  
  bigrams_filtered %>%
    filter(word1 == "bertram") %>%
    count(word2, sort = TRUE) %>%
    mutate( 
      freq = n/sum(n)
    )    
  
  
  bigrams_filtered %>%
    filter(word1 == "agreed") %>%
    count(word2, sort = TRUE) %>%
    mutate( 
      freq = n/sum(n)
    )     
  
# You can certainly create tri-gram data as well
  
  austen_books() %>%
    unnest_tokens(trigram, text, token = "ngrams", n = 3) %>%
    separate(trigram, c("word1", "word2", "word3"), sep = " ") %>%
    filter(!word1 %in% stop_words$word,
           !word2 %in% stop_words$word,
           !word3 %in% stop_words$word) %>%
    count(word1, word2, word3, sort = TRUE)  
  