#library(tidyverse)
#library(knitr)
#library(prettydoc)
#library(cowplot)
#library(gapminder)
#library(patchwork)

source("utils.R")
Sys.setenv(LANG = "en")

#anscombe_long <- read_excel("anscombe_long.xlsx")


#options(max.print = 100)
options(tibble.print_max = 25, tibble.print_min = 5)

#knitr::opts_chunk$set(echo = FALSE)



knitr::opts_chunk$set(
  fig.process = function(filename) {
    new_filename <- stringr::str_remove(string = filename,
                                        pattern = "-1")
    fs::file_move(path = filename, new_path = new_filename)
    ifelse(fs::file_exists(new_filename), new_filename, filename)
  }
)

knitr::opts_chunk$set(
  fig.height = 2.5,  fig.path = "images/", cache = TRUE,     
  out.width='90%', echo = TRUE, warning = FALSE, message = FALSE, eval = TRUE
)

ggplot2::theme_set(ggplot2::theme_minimal()) # sets a default ggplot theme


## # 7.2 The grammar of graphics ##################################################

## example_plot()

## knitr::include_graphics('images/Fig_0721.pdf')

#The setup for section 7.2 #####
library(dplyr)
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

## #Left plot, the geom_histogram
## ggplot(data=gapminder_07, aes(x=lifeExp)) +
##   geom_histogram()
## 
## #Right plot, the geom_density
## ggplot(data=gapminder_07, aes(x=lifeExp)) +
##   geom_density()
## 

#As Patchwork
p1 <- ggplot(data=gapminder_07, aes(x=lifeExp)) +
  geom_histogram()

p2 <- ggplot(data=gapminder_07, aes(x=lifeExp)) +
  geom_density()

p1 + p2

## geom_plot()

knitr::include_graphics('images/Fig_0724.pdf')

#Does geom_scatter exist?
ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
  geom_scatter()   


#The data transformation step ...
count_continent <- gapminder_07 |>
  count(continent)

count_continent

#And the bar graph
ggplot(data=gapminder_07, aes(x=continent)) +
  geom_bar()

## #geom_bar fills in the counting!
## ggplot(data=gapminder_07) +
##   geom_bar(aes(x=continent, y=..count..))

#Minimal example for a scatter plot with geom_smooth
ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
  geom_point() +    
  geom_smooth()

## #Linear fit
## ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
##   geom_point() +
##   geom_smooth(method = "lm", formula = y ~ x)
## 
## #Add a quadratic term
## ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
##   geom_point() +
##   geom_smooth(method="lm", formula = y ~ poly(x, 2))

#Patchwork#############
p1 <- ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
  geom_point() +    
  geom_smooth(method = "lm", formula = y ~ x)
  
  
p2 <- ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
  geom_point() +    
  geom_smooth(method="lm", formula = y ~ poly(x, 2))

p1 + p2

## #Map with color
## ggplot(gapminder_07, aes(x=gdp, y = lifeExp, color = continent)) +
##   geom_point()+
##   scale_color_manual(values=c("red", "gray", "gray", "gray"))
## 
## #Map with shapes
## ggplot(gapminder_07, aes(x=gdp, y = lifeExp, shape = continent)) +
##   geom_point()+
##   scale_shape_manual(values=c(0, 2, 3, 14))

p1 <- ggplot(gapminder_07, aes(x=gdp, y = lifeExp, 
                               color = continent)) +
  geom_point()+
  scale_color_manual(values=c("red", "gray", "gray", "gray"))

p2 <- ggplot(gapminder_07, aes(x=gdp, y = lifeExp, 
                               shape = continent)) +
  geom_point()+
  scale_shape_manual(values=c(0, 2, 3, 14))

p1 + p2

## #Alpha
## ggplot(gapminder_07, aes(x=gdp, y = lifeExp, color = continent)) +
##   geom_point(alpha = .5)
## #Map with alpha
## ggplot(gapminder_07, aes(x=gdp, y = lifeExp, alpha = continent)) +
##   geom_point()
## 

#PATCHWORK
p1 <- ggplot(gapminder_07, aes(x=gdp, y = lifeExp, 
                               color = continent)) +
  geom_point(alpha = .3)

p2 <- ggplot(gapminder_07, aes(x=gdp, y = lifeExp, alpha = continent)) +
  geom_point()
  
p1 + p2

## #Include color
## ggplot(gapminder_07, aes(x=gdp, y = lifeExp,
##                          color = continent)) +
##   geom_point()
## 
## #Include color and size
## ggplot(gapminder_07, aes(x=gdp, y = lifeExp,
##                          color = continent,
##                          size = population)) +
##   geom_point()
## 


p1 <- ggplot(gapminder_07, aes(x=gdp, y = lifeExp, color = continent)) +
  geom_point()+
  theme_minimal(base_size = 10)

p2 <- ggplot(gapminder_07, aes(x=gdp, y = lifeExp, color = continent, size = population)) +
  geom_point()+
  theme_minimal(base_size = 10)

p1 + p2

## #A dot plot
## ggplot(gapminder_07, aes(continent, lifeExp)) +
##   geom_point(size = 1)
## 
## #Add position_jitter
## ggplot(gapminder_07, aes(continent, lifeExp)) +
##   geom_point(size = 1, position=position_jitter())
## 
## 
## #A ggbeeswarm plot
## library(ggbeeswarm)
## 
## ggplot(gapminder_07, aes(continent, lifeExp)) +
##   geom_beeswarm(size = 1, cex = 3)+
##   stat_summary(fun = "median", colour = "red",
##                size = 1, geom = "point")
## 
## 

p1 <- ggplot(gapminder_07, aes(continent, lifeExp)) +
  geom_point(size = 1)+
  theme_minimal(base_size = 10)

p2 <- ggplot(gapminder_07, aes(continent, lifeExp)) +
  geom_point(size = 1, position=position_jitter())+
  theme_minimal(base_size = 10)

library(ggbeeswarm)

p3 <- ggplot(gapminder_07, aes(continent, lifeExp)) +
  geom_beeswarm(size = 1, cex = 3)+
  stat_summary(fun = "median", colour = "red", 
               size = 1, geom = "point")+
  theme_minimal(base_size = 10)

p1 + p2 + p3

## library(palmerpenguins)
## 
## #Position stack is the default
## ggplot(penguins, aes(species, fill = island))+
##   geom_bar(position = "stack")
## 
## #Position fill
## ggplot(penguins, aes(species, fill = island))+
##   geom_bar(position = "fill")
## 
## 

#PATCHWORK#################
library(palmerpenguins)

p1 <- ggplot(penguins, aes(species, fill = island))+
  geom_bar()+
  theme_minimal(base_size = 12)

p2 <- ggplot(penguins, aes(species, fill = island))+
  geom_bar(position = "fill")+
  theme_minimal(base_size = 12)

p1 + p2

#A messy density plot - how could we improve it?
ggplot(gapminder_07, aes(x=lifeExp, color=continent)) +
  geom_density()

#facet_grid splits the graph by continent 
ggplot(gapminder_07, aes(x=lifeExp)) +
  geom_density()+
  facet_grid(cols = vars(continent))

## #Split by columns (on the vertical axis)
## ggplot(gapminder_07, aes(x=lifeExp)) +
##   geom_density()+
##   ggtitle("A: facet_grid(cols = vars(x))")+
##   facet_grid(cols = vars(continent))
## 
## 
## #Sply by rows (on the horizontal)
## ggplot(gapminder_07, aes(x=lifeExp)) +
##   geom_density()+
##   ggtitle("B: facet_grid(rows = vars(x))")+
##   facet_grid(rows = vars(continent))
## 

p1 <- ggplot(gapminder_07, aes(x=lifeExp)) +
  geom_density()+
  ggtitle("A: facet_grid(cols = vars(x))")+
  facet_grid(cols = vars(continent))

p2 <- ggplot(gapminder_07, aes(x=lifeExp)) +
  geom_density()+
  ggtitle("B: facet_grid(rows = vars(x))")+
  facet_grid(rows = vars(continent))

p1 + p2

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

## library(patchwork)
## 
## p1 <- ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
##   geom_point() +
##   ggtitle("p1")
## 
## 
## p2 <- ggplot(gapminder_07, aes(x=gdp, y=lifeExp,
##                                color = continent)) +
##   geom_point() +
##   ggtitle("p2")+
##   theme(legend.position="none")
## 
## p3 <- ggplot(data=gapminder_07, aes(x=continent)) +
##   geom_bar()+
##   ggtitle("p3")
## 

## #combine all three graphs
## p1 + (p2 / p3)

#Fake data for a pie chart ... 
data<-tribble(
  ~fruits,   ~Percentage,
  "Apples",   50.0,
  "Bananas",  30.0,
  "Cherries", 20.0
)


## #Left, a bar plot
## ggplot(data, aes(x="", y=Percentage, fill=fruits))+
##   geom_col(width = 1)
## 
## #Right, the bull's-eye chart
## ggplot(data, aes(x="", y=Percentage, fill=fruits))+
##   geom_col(width = 1) +
##   coord_polar()
## 

p1 <- ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1)

p2 <- ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1)+
  coord_polar()

p1 + p2

## #Add theta = "y" to get a pie chart
## ggplot(data, aes(x="", y=Percentage, fill=fruits))+
##   geom_col(width = 1, stat = "identity")+
##   coord_polar(theta = "y")
## 
## #The theme_void "finalizes" the pie chart
## ggplot(data, aes(x="", y=Percentage, fill=fruits))+
##   geom_col(width = 1)+
##   coord_polar(theta = "y")+
##   theme_void()
## 


p1 <- ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1)+
  coord_polar(theta = "y")

p2 <- ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1, stat = "identity")+
  coord_polar(theta = "y")+
  theme_void()

p1 + p2

## #Left plot: Never use xlim outside of the coordinate system!
## ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
##   geom_point() +
##   geom_smooth(method = "lm", formula = y ~ x)+
##   xlim(c(0,10000))+
##   ggtitle("xlim")
## 
## #Right plot
## ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
##   geom_point() +
##   geom_smooth(method = "lm", formula = y ~ x)+
##   coord_cartesian(xlim=c(0, 10000))+
##   ggtitle("coord_cartesian(xlim)")
## 

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

## #Zoom in with ...
## library(ggforce)
## 
## ggplot(gapminder, aes(gdpPercap, lifeExp, color=continent))+
##   geom_point()+
##   facet_zoom(xlim = c(0, 10000))

library(ggforce)
library(viridis)

  ggplot(gapminder_07, aes(gdpPercap, lifeExp, color=continent))+
  geom_point()+
  facet_zoom(xlim = c(0, 10000))+
  theme_bw()+
  scale_color_viridis(discrete = TRUE, name = "Region", option = "viridis")

## #For 7.3 Ggplot extensions, see:
## #PracticeR::show_script("ggplot_extensions")

Sys.time()
