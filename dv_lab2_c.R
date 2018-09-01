#Stastical Analysis

library(lattice)
dataset<-read.csv("dataset_lab2.csv",sep=",",header=TRUE)
dataset$ses_factor=factor(dataset$ses,labels=c("low","middle","high"))

#fit linear model
reg<-lm(write~math+socst+ses_factor,dataset)
par(mfrow=c(3,2))
plot(reg,which=1:2)
plot(reg,which=3:4)
plot(reg,which=5:6)