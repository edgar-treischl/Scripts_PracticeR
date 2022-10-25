#7.2 The grammar of graphics ##################################################

#The setup for section 7.2 #####
library(dplyr)
library(ggbeeswarm)
library(ggforce)
library(ggplot2)
library(palmerpenguins)
library(patchwork)
#The gapminder data
library(gapminder)
head(gapminder)

#Create a smaller data frame
gapminder_07 <- gapminder |>
  filter (year == 2007 & continent != "Oceania") |>
  mutate(population = pop/1000000,
         gdp = gdpPercap/1000)


#Minimal code for a scatter plot
ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
  geom_point()

#Left plot, the geom_histogram
ggplot(data=gapminder_07, aes(x=lifeExp)) +
  geom_histogram()

#Right plot, the geom_density
ggplot(data=gapminder_07, aes(x=lifeExp)) +
  geom_density()



#Does geom_scatter exist?
# ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
#   geom_scatter()


#The data transformation step ...
count_continent <- gapminder_07 |>
  count(continent)

count_continent

#And the bar graph
ggplot(data=gapminder_07, aes(x=continent)) +
  geom_bar()

#geom_bar fills in the counting!
ggplot(data=gapminder_07) +
  geom_bar(aes(x=continent, y=..count..))

#Minimal example for a scatter plot with geom_smooth
ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
  geom_point() +
  geom_smooth()

#Linear fit
ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x)

#Add a quadratic term
ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
  geom_point() +
  geom_smooth(method="lm", formula = y ~ poly(x, 2))



#Map with color
ggplot(gapminder_07, aes(x=gdp, y = lifeExp, color = continent)) +
  geom_point()+
  scale_color_manual(values=c("red", "gray", "gray", "gray"))

#Map with shapes
ggplot(gapminder_07, aes(x=gdp, y = lifeExp, shape = continent)) +
  geom_point()+
  scale_shape_manual(values=c(0, 2, 3, 14))



#Alpha
ggplot(gapminder_07, aes(x=gdp, y = lifeExp, color = continent)) +
  geom_point(alpha = .5)
#Map with alpha
ggplot(gapminder_07, aes(x=gdp, y = lifeExp, alpha = continent)) +
  geom_point()




#Include color
ggplot(gapminder_07, aes(x=gdp, y = lifeExp,
                         color = continent)) +
  geom_point()

#Include color and size
ggplot(gapminder_07, aes(x=gdp, y = lifeExp,
                         color = continent,
                         size = population)) +
  geom_point()



#A dot plot
ggplot(gapminder_07, aes(continent, lifeExp)) +
  geom_point(size = 1)

#Add position_jitter
ggplot(gapminder_07, aes(continent, lifeExp)) +
  geom_point(size = 1, position=position_jitter())


#A ggbeeswarm plot
#library(ggbeeswarm)

ggplot(gapminder_07, aes(continent, lifeExp)) +
  geom_beeswarm(size = 1, cex = 3)+
  stat_summary(fun = "median", colour = "red",
               size = 1, geom = "point")





#library(palmerpenguins)
#Position stack is the default
ggplot(penguins, aes(species, fill = island))+
  geom_bar(position = "stack")

#Position fill
ggplot(penguins, aes(species, fill = island))+
  geom_bar(position = "fill")





#A messy density plot - how could we improve it?
ggplot(gapminder_07, aes(x=lifeExp, color=continent)) +
  geom_density()

#facet_grid splits the graph by continent
ggplot(gapminder_07, aes(x=lifeExp)) +
  geom_density()+
  facet_grid(cols = vars(continent))

#Split by columns (on the vertical axis)
ggplot(gapminder_07, aes(x=lifeExp)) +
  geom_density()+
  ggtitle("A: facet_grid(cols = vars(x))")+
  facet_grid(cols = vars(continent))


#Sply(Typo FEHLER) by rows (on the horizontal)
ggplot(gapminder_07, aes(x=lifeExp)) +
  geom_density()+
  ggtitle("B: facet_grid(rows = vars(x))")+
  facet_grid(rows = vars(continent))




#Split by facet_grid(row . column)
gapminder |>
  filter (year == 1952 | year == 2007) |>
  filter (continent != "Oceania") |>
  ggplot(aes(x=lifeExp)) +
  geom_density()+
  facet_grid(year ~ continent)

#Vertical facet, but wrapped
gapminder |>
  filter (continent == "Europe") |>
  ggplot(aes(x=lifeExp)) +
  geom_density()+
  facet_wrap(year ~ ., nrow=2)



#Fake data for a pie chart ...
data<-tribble(
  ~fruits,   ~Percentage,
  "Apples",   50.0,
  "Bananas",  30.0,
  "Cherries", 20.0
)


#Left, a bar plot
ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1)

#Right, the bull's-eye chart
ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1) +
  coord_polar()



#Add theta = "y" to get a pie chart
ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1, stat = "identity")+
  coord_polar(theta = "y")

#The theme_void "finalizes" the pie chart
ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1)+
  coord_polar(theta = "y")+
  theme_void()



#Left plot: Never use xlim outside of the coordinate system!
#ERROR gapminder as DATA not gapminder_gapminder_07 + gdpPercap
#BOTH
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x)+
  xlim(c(0,10000))+
  ggtitle("xlim")

#Right plot
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x)+
  coord_cartesian(xlim=c(0, 10000))+
  ggtitle("coord_cartesian(xlim)")





#Zoom in with ...
#library(ggforce)
#ERROR/FEHLER gapminder_07 and gapminder

ggplot(gapminder, aes(gdpPercap, lifeExp, color=continent))+
  geom_point()+
  facet_zoom(xlim = c(0, 10000))


#Shown in the book
library(viridis)

  ggplot(gapminder_07, aes(gdpPercap, lifeExp, color=continent))+
  geom_point()+
  facet_zoom(xlim = c(0, 10000))+
  theme_bw()+
  scale_color_viridis(discrete = TRUE, name = "Region", option = "viridis")

#For 7.3 Ggplot extensions, see:
#PracticeR::show_script("chapter07_3")

