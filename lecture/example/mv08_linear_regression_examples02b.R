# Illustrate how to use CV() command to select the best model

library(fpp)
mydata <- read.table("data/coach_salary_usatoday02.csv", header=TRUE, sep=",")
others <- mydata[2:10,]

fit1<-lm(total ~ share , data=others)
fit2<-lm(total ~ career, data=others)
fit3<-lm(total ~ sec, data=others)
fit4<-lm(total ~ share + career + sec , data=others)
fit5<-lm(total ~ share + career + sec + share*career, data=others)



CV1<-CV(fit1)
CV2<-CV(fit2)
CV3<-CV(fit3)
CV4<-CV(fit4)
CV5<-CV(fit5)

cbind(CV1,CV2,CV3,CV4,CV5)
