# Illustrates the use of Bayes Classifier with the single variable case
install.packages("ISLR")
library("ISLR")

summary(Default)
str(Default)

attach(Default)

# Manual Approach (1)
all.dist <- addmargins(prop.table(table(student,default)))
all.dist

# What is the conditional distribution given a customer is a student
all.dist[1,1:2]/all.dist[1,3]
all.dist[2,1:2]/all.dist[2,3]

# Direct way

  prop.table(table(student,default), margin = 1)

# Manual Approach (2)
# Select the subset first
default.student <- subset(Default, student=="Yes")
prop.table(table(default.student$default))

# Manual Approach (3)
library(dplyr)
Default %>%
  filter(student == "Yes") %>%
  count(default) %>%
  mutate(feq = n/sum(n))

# Manual Approach (4)
# It is based on the mean, and we will introduce 
# aggregate() command

# Classification
# Neither a student nor a non-studdent is more likely default, and classify it as the No type

detach(Default)

# Let's use the Naive Bayes Package's built in command. 
# Load the naivebayes package
library(naivebayes)

# Build the location prediction model
model <- naive_bayes(default ~ student, data = Default)
model

# the following code won't work
newdata <- data.frame(student = "Yes")
predict(model, newdata = newdata)

# How to fix it?
newdata$student <- factor(newdata$student, levels = c("No", "Yes"))
str(newdata)
# Predict Thursday's 9am location
predict(model, newdata = newdata)

newdata <- data.frame(student = c("Yes", "Yes", "No", "Yes"))


