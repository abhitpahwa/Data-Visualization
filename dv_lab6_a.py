#GGPLOT FOR PLOTS,SUBPLOTS,SCATTERPLOTS IN PYTHON

from ggplot import *
#using default dataset 
graph=ggplot(aes(x='rating', y='length'), data=movies) +geom_line()
graph.show()

import pandas as pd

#reading user defined dataset
dataset=pd.read_csv("A:/dv/lab/lab6/dataset_lab6.csv")

#line plot
graph=ggplot(aes(x="PetalWidthCm",y="SepalWidthCm"),data=dataset)+geom_line()
graph.show()

#scatter plot
graph=ggplot(aes(x="SepalWidthCm",y="PetalWidthCm"),data=dataset)+geom_point()
graph.show()

#scatterplot with labels
graph=ggplot(aes(x="SepalWidthCm",y="PetalWidthCm"),data=dataset)+geom_point()+labs(title="Scatter plot",x="Sepal Width(cm)",y="Petal Width(cm)")
graph.show()

#scatterplot with colors
graph=ggplot(aes(x="SepalWidthCm",y="PetalWidthCm",color="Species"),data=dataset)+geom_point()+labs(title="Scatter plot",x="Sepal Width(cm)",y="Petal Width(cm)")+scale_color_brewer(type='div',palette=2)+ggtitle("Scatter Plot")
graph.show()

#another way to give labels
graph=ggplot(aes(x="SepalWidthCm",y="PetalWidthCm",color="Species"),data=dataset)+geom_point()+xlab("Sepal Width")+ylab("Sepal Length")+scale_color_brewer(type='div',palette=3)+ggtitle("Scatter Plot")
graph.show()

#facet_wrap use with single column
graph=ggplot(aes(x="SepalWidthCm",y="PetalWidthCm",color="Species"),data=dataset)+geom_point()+xlab("Sepal Width")+ylab("Sepal Length")+scale_color_brewer(type='div',palette=3)+ggtitle("Scatter Plot")+facet_wrap('Species',ncol=2)
graph.show()

#facet_wrap use with multiple column
graph=ggplot(aes(x="SepalWidthCm",y="PetalWidthCm",color="Species"),data=dataset)+geom_point()+xlab("Sepal Width")+ylab("Sepal Length")+scale_color_brewer(type='div',palette=3)+ggtitle("Scatter Plot")+facet_wrap('Color','Species',ncol=3)
graph.show()

#facet_wrap default 
graph=ggplot(aes(x="SepalWidthCm",y="PetalWidthCm",color="Species"),data=dataset)+geom_point()+xlab("Sepal Width")+ylab("Sepal Length")+scale_color_brewer(type='div',palette=3)+ggtitle("Scatter Plot")+facet_wrap('Color','Species')
graph.show()

#scales in facet_wrap
graph=ggplot(aes(x="SepalWidthCm",y="PetalWidthCm",color="Species"),data=dataset)+geom_point()+xlab("Sepal Width")+ylab("Sepal Length")+scale_color_brewer(type='div',palette=3)+ggtitle("Scatter Plot")+facet_wrap('Color','Species',scales='free')
graph.show()

#facet_grid
graph=ggplot(aes(x="SepalWidthCm",y="PetalWidthCm",color="Species"),data=dataset)+geom_point()+xlab("Sepal Width")+ylab("Sepal Length")+scale_color_brewer(type='div',palette=3)+ggtitle("Scatter Plot")+facet_grid('Color','Species')
graph.show()

