# This program illustrates how to 

# 1. test for conditional independence
# 2. employ Naive Bayes Classifier. 

# Let's download Titanic data

install.packages("titanic")

library(titanic)
View(titanic_train)


# Let's generate the joint distribution in each cell of gender
mytable <- xtabs(~Pclass + Survived + Sex, data = titanic_train)

# Conduct Hypothesis Testing
mantelhaen.test(mytable)


# See https://cran.r-project.org/web/packages/samplesizeCMH/vignettes/samplesizeCMH-introduction.html
# for more detailed introduction


# Naive Baye Classifiers

library(naivebayes)
model <- naive_bayes(factor(Survived) ~ Pclass + Sex, data =titanic_train)
model

predict(model, newdata = titanic_test)

