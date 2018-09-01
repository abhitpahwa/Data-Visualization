# Plot a bar graph(x and y axes) and line graph(x and secondry y axes)

library(ggplot2)
dataset<-read.csv("dataset_lab1.csv",sep=",",header=TRUE)

#bar plot and line plot
gg<-ggplot(dataset,aes(x=Age.group,y=Number.of.loans,group=1))+
  geom_bar(stat="identity")+
  geom_line(aes(y=Bad.rate*2000),col="red",size=1.5)+
  scale_y_continuous(sec.axis = sec_axis(~./2000,name="Bad rate"))+
  labs(x="Age group",y="Number of loans")
