#Deviation

options(scipen=999)
library(ggplot2)
library(quantmod)
theme_set(theme_bw())
data("mtcars")

#Diverging bars
mtcars$'car name'<-rownames(mtcars)
mtcars$mpg_z<-round((mtcars$mpg-mean(mtcars$mpg))/sd(mtcars$mpg),2)
mtcars$mpg_type<-ifelse(mtcars$mpg_z<0,"below","above")
mtcars<-mtcars[order(mtcars$mpg_z),]
mtcars$'car name'<-factor(mtcars$'car name',levels=mtcars$'car name')
diverging_bar<-ggplot(mtcars,aes(x=`car name`,y=mpg_z,label=mpg_z))+
  geom_bar(stat='identity',aes(fill=mpg_type),width=0.5)+
  scale_fill_manual(name='Mileage',
                    labels=c("Above average","Below Average"),
                    values=c("above"="#00ba38","below"="#f8766d"))+
  labs(subtitle="Normalized mileage from mtcars",
       title="Diverging bars")+
  coord_flip()
diverging_bar

#Diverging Lollipop chart
diverging_lollipop<-ggplot(mtcars,aes(x=`car name`,y=mpg_z,label=mpg_z))+
  geom_point(stat="identity",fill="black",size=6)+
  geom_segment(aes(y=0,
                   x=`car name`,
                   yend=mpg_z,
                   xend=`car name`),
               color='black')+
  geom_text(color="white",size=2)+
  labs(title="Diverging Lollipop chart",
       subtitle="Normalized mileage from mtcars : Lollipop")+
  ylim(-2.5,2.5)+
  coord_flip()
diverging_lollipop

#Diverging Dot plot
diverging_dot<-ggplot(mtcars,aes(x=`car name`,y=mpg_z,label=mpg_z))+
  geom_point(stat="identity",aes(col=mpg_type),size=6)+
  scale_color_manual(name="Mileage",labels=c("Above Average","Below Average"),
                     values = c("above"="#00ba38","below"="#f8766d"))+
  geom_text(color="white",size=2)+
  labs(title="Diverging dot plot",
       subtitle="Normalized mileage from mtcars: Dotplot")+
  ylim(-2.5,2.5)+
  coord_flip()
diverging_dot

#Area chart
data("economics",package = "ggplot2")
economics$returns_perc<-c(0,diff(economics$psavert)/economics$psavert[-length(economics$psavert)])
brks<-economics$date[seq(1,length(economics$date),12)]
lbls<-lubridate::year(economics$date[seq(1,length(economics$date),12)])
area<-ggplot(economics[1:100,],aes(date,returns_perc))+
  geom_area()+
  scale_x_date(breaks = brks,labels = lbls)+
  theme(axis.text.x = element_text(angle=90))+
  labs(title="Area chart",
       subtitle="Perc Returns for Personal Savings",
       y="%Returns for Personal savings",
       caption="Source : economics")
area
