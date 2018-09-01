#Multivariate plots

library(lattice)
dataset<-read.csv("dataset_lab2.csv",sep=",",header=TRUE)
dataset$ses_factor=factor(dataset$ses,labels=c("low","middle","high"))

#scatter plot
xyplot(write~math,dataset)
xyplot(write~math|ses_factor,dataset)

#scatter plot matrices
subset<-dataset[,8:12]
splom(~subset[,1:4])
