


## # 7.3 Ggplot2 extensions #######################################################

## #Get the minimal code script

library(titanic)
library(ggbeeswarm)

ggplot(titanic_train, aes(Survived, Age, color = Sex)) +
  geom_quasirandom(method = "quasirandom")




#Source: This example comes from the ggplot2 cheat sheet!
map <- map_data("state")
data <- data.frame(murder = USArrests$Murder,
                   state = tolower(rownames(USArrests)))

ggplot(data, aes(fill = murder))+
  geom_map(aes(map_id = state), map = map)+
  expand_limits(x = map$long, y = map$lat)




library(ggcharts)
data("popeurope")

dumbbell_chart(popeurope,
               x = country,
               y1 = pop1952, y2 = pop2007,
               top_n = 10)



## #Use the r-graph-gallery to make graph such as the hexbin plot!
## #There are many graphs (and code) to explore on:
## #www.r-graph-gallery.com



library(ggmosaic)

ggplot(data = titanic) +
  geom_mosaic(aes(x = product(Sex),
                  fill = Survived))




library(ggridges)

#minimal code by Claus Wilke:
ggplot(lincoln_weather,
       aes(x = `Mean Temperature [F]`, y = Month, fill = stat(x))) +
  geom_density_ridges_gradient(scale = 3,
                               rel_min_height = 0.01) +
  scale_fill_viridis_c(name = "Temp. [F]",
                       option = "C")



library(treemapify)
library(gapminder)

gapminder

data <- gapminder::gapminder |>
  filter(year == 2007 & continent == "Europe")

ggplot(data, aes(area = gdpPercap,
                 fill = lifeExp,
                 label = country)) +
  geom_treemap() +
  geom_treemap_text(fontface = "italic",
                    colour = "white",
                    place = "centre",
                    grow = TRUE)



library(waffle)
parts <- c(66, 22, 12)

waffle(parts, rows = 10)





#minimal code by Erwan Le Pennec
library(ggwordcloud)
#to recreate the plot each the exact same way: set a seed (starting point)
set.seed(123)

ggplot(love_words_small, aes(label = word,
                             size = speakers)) +
  geom_text_wordcloud() +
  scale_size_area(max_size = 30)



