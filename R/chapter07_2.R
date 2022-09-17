


library(tidyverse)
library(gapminder)
head(gapminder)

gapminder_07 <- gapminder |> 
  filter (year == 2007 & continent != "Oceania") |>
  mutate(population = pop/1000000,
         gdp = gdpPercap/1000)




ggplot(gapminder_07, aes(x = continent)) +
  geom_bar()

library(patchwork)
library(palmerpenguins)

p1 <- ggplot(penguins, aes(flipper_length_mm, body_mass_g))+
  geom_point()+
  ggtitle("p1")

p2 <- ggplot(penguins, aes(flipper_length_mm, body_mass_g,
                           color = species))+
  geom_point()+
  ggtitle("p2")+
  theme(legend.position="none")

p3 <- ggplot(penguins, aes(species))+
  geom_bar()+
  ggtitle("p3")

p1 + (p2 / p3)

#Left, the histogram
p1 <- ggplot(data=gapminder_07, aes(x=lifeExp)) +
  geom_histogram()

#Right, the density plot
p2 <- ggplot(data=gapminder_07, aes(x=lifeExp)) +
  geom_density()

p1 + p2




#A geom_scatter?
# ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
#   geom_scatter()   


#The data transformation step of the simple bar graph
gapminder_07 |>
  count(continent)


#Add count stats to see what happens in the background
ggplot(data=gapminder_07) +
  geom_bar(aes(x=continent, y=..count..))

#Minimal example for a scatter plot 
ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
  geom_point() +    
  geom_smooth()


#Anscombe's second example
p1 <- ggplot(anscombe, aes(x=x2, y=y2)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x)
  
#Anscombe's second example by hand with a quadratic term
p2 <- ggplot(anscombe, aes(x=x2, y=y2)) +
  geom_point() +
  geom_smooth(method="lm", formula = y ~ poly(x, 2))


#Plot both graphs next to each other with patchwork
p1 + p2

## #Map with color
p1 <- ggplot(gapminder_07, aes(x=gdp, y = lifeExp, 
                               color = continent)) +
  geom_point()+
  scale_color_manual(values=c("red", "gray", "gray", "gray"))

p2 <- ggplot(gapminder_07, aes(x=gdp, y = lifeExp, 
                               shape = continent)) +
  geom_point()+
  scale_shape_manual(values=c(0, 2, 3, 14))

p1 + p2

#Map with color
p1 <- ggplot(gapminder_07, aes(x=gdp, y = lifeExp)) +
  geom_point()

p2 <- ggplot(gapminder_07, aes(x=gdp, y = lifeExp, alpha = continent)) +
  geom_point()
  
p1 + p2

#include color
ggplot(gapminder_07, aes(x=gdp, y = lifeExp,
                         color = continent)) +
  geom_point()

#include size
ggplot(gapminder_07, aes(x=gdp, y = lifeExp,
                         color = continent,
                         size = population)) +
  geom_point()




#A dot plot
p1 <- ggplot(gapminder_07, aes(continent, lifeExp)) +
  geom_point(size = 1)+
  stat_summary(fun = "median", colour = "red", size = 1.5, geom = "point")

#And with position_jitter
p2 <- ggplot(gapminder_07, aes(continent, lifeExp)) +
   geom_point(size = 1, 
              position=position_jitter(width=1, height=1))

p1 + p2

library(palmerpenguins)
#position = "stack" is the default 
p1 <- ggplot(penguins, aes(species, fill = island))+
  geom_bar()

p2 <- ggplot(penguins, aes(species, fill = island))+
  geom_bar(position = "dodge")

p1 + p2



p1 <- ggplot(penguins, aes(species, fill = island))+
  geom_bar(position =  position_dodge(preserve = "total"))

p2 <- ggplot(penguins, aes(species, fill = island)) +
  geom_bar(position = "fill")

p1 + p2

#a messy density plot - how could we improve it?
ggplot(gapminder_07, aes(x=lifeExp, color=continent)) +
  geom_density()

#facet_grid splits the graph by continent 
#each continent is display in its own column
ggplot(gapminder_07, aes(x=lifeExp)) +
  geom_density()+
  facet_grid(cols = vars(continent))

## ## Divide by levels of "continent" on the vertical axis
ggplot(gapminder_07, aes(x=lifeExp)) +
  geom_density()+
  ggtitle("A: facet_grid(cols = vars(continent))")+
  facet_grid(cols = vars(continent))


## #Or on the horizontal
ggplot(gapminder_07, aes(x=lifeExp)) +
  geom_density()+
  ggtitle("B: facet_grid(rows = vars(continent))")+
  facet_grid(rows = vars(continent))


p1 <- ggplot(gapminder_07, aes(x=lifeExp)) +
  geom_density()+
  ggtitle("A: facet_grid(cols = vars(continent))")+
  facet_grid(cols = vars(continent))

p2 <- ggplot(gapminder_07, aes(x=lifeExp)) +
  geom_density()+
  ggtitle("B: facet_grid(rows = vars(continent))")+
  facet_grid(rows = vars(continent))

p1 + p2

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

#Let's generate some fake data for a pie chart ... 
data<-tribble(
  ~fruits,   ~Percentage,
  "Apples",   50.0,
  "Bananas",  30.0,
  "Cherries", 20.0
)


## #Right plot, a staged bar plot
ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1)

#Left, the bull's-eye chart
ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1) +
  coord_polar()


#add theta = "y" to get a pie chart
ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1, stat = "identity")+
  coord_polar(theta = "y")

#theme_void "finalizes" the pie chart
ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1)+
  coord_polar(theta = "y")+
  theme_void()


#Stranger things can happen ... 
p1 <- ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1)+
  coord_polar(theta = "y")

p2 <- ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1, stat = "identity")+
  coord_polar(theta = "y")+
  theme_void()

p1 + p2

#Left plot
#Please, do not use xlim outside of a coordinate system
p1 <- ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) +
  geom_point() +    
  geom_smooth(method = "lm", formula = y ~ x)+
  xlim(c(0, 10000))+
  ggtitle("xlim")

p2 <- ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) +
  geom_point() +    
  geom_smooth(method = "lm", formula = y ~ x)+
  coord_cartesian(xlim=c(0, 10000))+
  ggtitle("coord_cartesian(xlim)")

p1 + p2

library(ggforce)

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, color=continent))+
  geom_point()+
  facet_zoom(xlim = c(0, 10000))

library(viridis)

  ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, color=continent))+
  geom_point()+
  facet_zoom(xlim = c(0, 10000))+
  theme_bw()+
  scale_color_viridis(discrete = TRUE, name = "Region", 
                      option = "viridis")

  mean_gdps <- gapminder_07 %>% 
    group_by(continent)%>% 
    summarise(mean_gdp = mean(gdp),
              mean_lifeExp = mean(lifeExp))
  
  
  p1 <- ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
    geom_point(position = "jitter", color = "gray") +    
    geom_smooth(color = "red") +
    labs(x = "GDP (per 1000 Dollar)", 
         y = "Life expectancy")
  
  
  p2 <- ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
    geom_point(position = "jitter", color = "gray") + 
    geom_smooth(color = "black", se = F, size = 0.5) +
    facet_wrap( ~ continent, ncol=2, scales="free")+
    geom_vline(data = mean_gdps, mapping = aes(xintercept = mean_gdp),
               color = "red", linetype = 2) +
    geom_hline(data = mean_gdps, mapping = aes(yintercept = mean_lifeExp),
               color = "red", linetype = 2) +
    labs(x = "GDP (per 1000 Dollar)", 
         y = "Life expectancy")+
    theme(strip.text.x = element_text(size = 12))
  
  
  p1 + p2

#line types
PracticeR::show_linetypes()



#Reste
# library(ggbeeswarm)
# ggplot(gapminder_07, aes(continent, lifeExp)) +
#   geom_quasirandom(size = 1)+
#   theme_minimal(base_size = 9.5)


# ggplot() +
#   xlim(-12, 12)+
#   geom_function(fun = dnorm, args = list(mean = 5, sd = 2))+
#   geom_function(fun = dnorm, args = list(mean = -5, sd = 6), color = "red")
# 
