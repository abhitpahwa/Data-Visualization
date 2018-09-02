#Correlation

options(scipen=999)
library(ggplot2)
library(ggalt)
library(gganimate)
library(gapminder)
library(ggExtra)
library(ggcorrplot)
theme_set(theme_bw())
data("midwest",package="ggplot2")

#Scatter plot
scatter_plot<-ggplot(midwest,aes(x=area,y=poptotal))+
  geom_point(aes(col=state,size=popdensity))+
  geom_smooth(method="loess",se=F)+
  xlim(c(0,0.1))+
  ylim(c(0,500000))+
  labs(subtitle="Area vs Population",
       y="Population",
       x="Area",
       title="Scatterplot",
       caption="Source: midwest")
scatter_plot

#Scatter plot with encircling
midwest_select<-midwest[midwest$poptotal>350000 & midwest$poptotal<=500000 & midwest$area>0.01 & midwest$area<0.1,]
scatter_plot_encircle<-ggplot(midwest,aes(x=area,y=poptotal))+
  geom_point(aes(col=state,size=popdensity))+
  xlim(c(0,0.1))+
  ylim(c(0,500000))+
  geom_encircle(aes(x=area,y=poptotal),
                data=midwest_select,
                color="red",
                size=2,
                expand=0.08)+
  labs(subtitle="Area vs Population",
       y="Population",
       x="Area",
       title="Scatterplot+Encircle",
       caption="Source: midwest")
scatter_plot_encircle

#Jitter plot
data(mpg,package="ggplot2")
jitter_plot<-ggplot(mpg,aes(cty,hwy))+
  geom_jitter(width=0.5,size=1)+
  labs(subtitle="mpg: city vs highway mileage",
       y="hwy",
       x="cty",
       title="Jittered points")
jitter_plot

#Counts plot
counts_plot<-ggplot(mpg,aes(cty,hwy))+
  geom_count(col="tomato3",show.legend=F)+
  labs(subtitle="mpg: city vs highway mileage",
       y="hwy",
       x="cty",
       title="Counts plot")
counts_plot

#Bubble plot
mpg_select<-mpg[mpg$manufacturer %in% c("audi","ford","honda","hyundai"),]
bubble_plot<-ggplot(mpg_select,aes(displ,cty))+
  labs(subtitle="mpg: Displacement vs City Mileage",
       title="Bubble chart")+
  geom_jitter(aes(col=manufacturer,size=hwy))+
  geom_smooth(aes(col=manufacturer),method="lm",se=F)
bubble_plot

#Animated bubble chart
animated_bubble_plot<-ggplot(gapminder,aes(gdpPercap,lifeExp,size=pop,colour=country))+
  geom_point(alpha=0.7,show.legend = FALSE)+
  scale_color_manual(values = country_colors)+
  scale_size(range = c(2,12))+
  scale_x_log10()+
  facet_wrap(~continent)+
  labs(title="Year: {frame_time}",x='GDP per capita',y="life expectancy")+
  transition_time(year)+
  ease_aes('linear')
animated_bubble_plot

#Marginal Histogram / Boxplot
mpg_select<-mpg[mpg$hwy>=35 & mpg$cty>27,]
marginal_plot<-ggplot(mpg,aes(cty,hwy))+
  geom_count()+
  geom_smooth(method = "lm",se=F)
marginal_histogram<-ggMarginal(marginal_plot,type="histogram",fill="transparent")
marginal_boxplot<-ggMarginal(marginal_plot,type="boxplot",fill="transparent")
marginal_densityplot<-ggMarginal(marginal_plot,type="density",fill="transparent")
marginal_histogram
marginal_boxplot
marginal_densityplot

#Correlogram
data("mtcars")
corr<-round(cor(mtcars),1)
corrplot<-ggcorrplot(corr,hc.order=TRUE,type="lower",
           lab = TRUE,
           lab_size = 3,
           method = "circle",
           colors = c("tomato2","white","springgreen3"),
           title="Correlogram of mtcars")
corrplot