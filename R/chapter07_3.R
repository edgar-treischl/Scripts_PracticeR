## # 7.3 Ggplot2 extensions #######################################################

#Alluvial########
library(ggalluvial)
#a wide data format is needed (see Chapter 11)
titanic_wide_format <- data.frame(Titanic)

ggplot(data = titanic_wide_format,
       aes(axis1 = Class, axis2 = Sex, axis3 = Age, y = Freq)) +
  geom_alluvium(aes(fill = Survived)) +
  geom_stratum()


#Beeswarm#############

library(titanic)
library(ggbeeswarm)

ggplot(titanic_train, aes(Survived, Age, color = Sex)) +
  geom_quasirandom(method = "quasirandom")

#Choropleth maps######

#Source: This example comes from the ggplot2 cheat sheet!
map <- map_data("state")
data <- data.frame(murder = USArrests$Murder,
                   state = tolower(rownames(USArrests)))

ggplot(data, aes(fill = murder))+
  geom_map(aes(map_id = state), map = map)+
  expand_limits(x = map$long, y = map$lat)



#Dumbbell and lollipop charts#######

library(ggcharts)
data("popeurope")

dumbbell_chart(popeurope,
               x = country,
               y1 = pop1952, y2 = pop2007,
               top_n = 10)


#Hexbin map############
#There are many graphs (and code) to explore on:
#www.r-graph-gallery.com



#Mosaic plot######
library(ggmosaic)

ggplot(data = titanic) +
  geom_mosaic(aes(x = product(Sex),
                  fill = Survived))



#Ridge plots#######
library(ggridges)

#minimal code by Claus Wilke:
ggplot(lincoln_weather,
       aes(x = `Mean Temperature [F]`, y = Month, fill = stat(x))) +
  geom_density_ridges_gradient(scale = 3,
                               rel_min_height = 0.01) +
  scale_fill_viridis_c(name = "Temp. [F]",
                       option = "C")



#Treemaps######
#FEHLER_ Missing dplyr
library(treemapify)
library(gapminder)


data <- gapminder::gapminder |>
  dplyr::filter(year == 2007 & continent == "Europe")

ggplot(data, aes(area = gdpPercap,
                 fill = lifeExp,
                 label = country)) +
  geom_treemap() +
  geom_treemap_text(colour = "white",
                    grow = TRUE)


#Waffle charts#####

library(waffle)
parts <- c(66, 22, 12)

waffle(parts, rows = 10)



#Word clouds###########

#Text Mining with R:
library(PracticeR)
show_link("textmining", browse = F)

## #Minimal code by Erwan Le Pennec
library(ggwordcloud)
#to recreate the plot each the exact same way: set a seed (starting point)
set.seed(123)

ggplot(love_words_small, aes(label = word,
                             size = speakers)) +
  geom_text_wordcloud() +
  scale_size_area(max_size = 30)

#R Graphics Cookbook
show_link("r_graphics", browse=F)

#ggplot2: elegant graphics
show_link("ggplot2", browse=F)

#Fundamentals of Data Visualization
show_link("fundamentals_dataviz", browse=F)

#Data Visualization
show_link("dataviz", browse=F)


