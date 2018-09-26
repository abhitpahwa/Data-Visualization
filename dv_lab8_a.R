#K-Mean Cluster using R

#plot the cluster
dataset<-read.csv("dataset_lab8.csv",sep = ",",header = TRUE)
library(cluster)
library(factoextra)
set.seed(1)
grp_meat<-kmeans(dataset[,c("WhiteMeat","RedMeat")],centers = 3,nstart = 10)
grp_meat
o=order(grp_meat$cluster)
data.frame(dataset$Country[o],grp_meat$cluster[o])
plot(dataset$RedMeat,dataset$WhiteMeat,type="n",xlim=c(3,19),xlab = "Red Meat",ylab = "White Meat")
text(x=dataset$RedMeat,y=dataset$WhiteMeat,labels=dataset$Country,col=grp_meat$cluster+1)

#plot the cluster using library factoextra
col<-dataset[2:10]
scale_col<-as.data.frame(lapply(col,scale))
func_plot<-function(data,nc=9,seed=12345){
  plt<-(nrow(data)-1)*sum(apply(data,2,var))
  for(i in 2:nc){
    set.seed(seed)
    plt[i]<-sum(kmeans(data,centers = i)$withinss)
  }
  plot(1:nc,plt,type="b",xlab="Number of clusters",ylab="Within groups sum of squares")
}
func_plot(scale_col,nc=9)

#plot using fciz_cluster
clusters<-kmeans(scale_col,10)
clusters$size
clusters$centers
fviz_cluster(clusters,dataset[,-1])

#plot using clustergram
#for this you have to first implement clustegram.R 
dataset<-scale(dataset[,-1])
clustergram(dataset,k.range = 2:8,line.width = 0.004,add.center.points = T)

#plot using autoplot
library(ggfortify)
library(ggplot2)
autoplot(kmeans(dataset[,-1],3),dataset)

#determine optimal number of clusters using different methods
#elbow method
fviz_nbclust(scale_col,kmeans,method="wss")+geom_vline(xintercept = 7,linetype=2)+labs(subtitle="Elbow method")
#silhouette method
fviz_nbclust(scale_col,kmeans,method="silhouette")+labs(subtitle="Silhouette method")
#gap statistic method
fviz_nbclust(scale_col,kmeans,method="gap_stat",nboot = 10)+labs(subtitle="Elbow method")

