# This program is to illustrate the use of simple linear regression
# when the predictor is a qualitative variable.


# 1. Tell R what the file name is.
mydata <- read.table("data/coach_salary_usatoday02.csv", header=TRUE, sep=",")

# 2. Let's click the data and look at them
# Nick Saban's salary is 5545852
# Share: share of loss in that season


# Let's use only other coaches' salaries
others <- mydata[2:10,]


# 3. Run the model
# Losing is good?! (Not causal effect!)

fit<-lm(total ~ share + career + sec, data=others)
summary(fit)

predict(fit, newdata = data.frame(share=0,career=167,sec=1))


5545852 - predict(fit, newdata = data.frame(share=0,career=167,sec=1))

# 4. Run another model

fit<-lm(total ~ share + career + sec + share*career, data=others)
summary(fit)

predict(fit, newdata = data.frame(share=0,career=167,sec=1))

5545852 - predict(fit, newdata = data.frame(share=0,career=167,sec=1))

# Nick Saban's salary is 5545852
