#Univariate plots

library(lattice)
dataset<-read.csv("dataset_lab2.csv",sep=",",header=TRUE)
dataset$ses_factor=factor(dataset$ses,labels=c("low","middle","high"))

#histogram
histogram(~write,dataset)
histogram(~write|ses_factor,dataset)

#density plot
densityplot(~socst,dataset)
densityplot(~socst|ses_factor,dataset)

#quantile-quantile plot
qqmath(~write,dataset)
qqmath(~write|ses_factor,dataset)

#boxplot
bwplot(~math,dataset)           
bwplot(ses_factor~math,dataset)
