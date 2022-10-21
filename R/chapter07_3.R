

library(tidyverse)

library(PracticeR)



#include DG Fonts with showtext
library(showtext)

#font_add("DGMetaScience", #"C:/Users/gu99mywo/AppData/Local/Microsoft/Windows/Fonts/DGMetaScience-Regular.otf")

#showtext_auto()


#data###


## # 7.3 Ggplot2 extensions #######################################################

## #Get the minimal code script
## PracticeR::show_script("ggplot_extensions")

## # fig.cap = "\\label{1}An alluvial example"
## titanic_alluvial()

knitr::include_graphics('images/fig_731.pdf')

library(ggalluvial)
#a wide data format is needed (see Chapter 11)
titanic_wide_format <- data.frame(Titanic)

ggplot(data = titanic_wide_format,
       aes(axis1 = Class, axis2 = Sex, axis3 = Age, y = Freq)) +
  geom_alluvium(aes(fill = Survived)) +
  geom_stratum()


## # fig.cap = "\\label{2}A beeswarm example"
##
## beeplot()

knitr::include_graphics('images/fig_732.pdf')

library(titanic)
library(ggbeeswarm)

ggplot(titanic_train, aes(Survived, Age, color = Sex)) +
  geom_quasirandom(method = "quasirandom")


## # fig.cap = "\\label{3}A choropleth example"
## map_plot()
##

knitr::include_graphics('images/fig_733.pdf')

#Source: This example comes from the ggplot2 cheat sheet!
map <- map_data("state")
data <- data.frame(murder = USArrests$Murder,
                   state = tolower(rownames(USArrests)))

ggplot(data, aes(fill = murder))+
  geom_map(aes(map_id = state), map = map)+
  expand_limits(x = map$long, y = map$lat)


## # fig.cap = "\\label{4}A dumbbell example"
## dumbbell_plot()

knitr::include_graphics('images/fig_734.pdf')

library(ggcharts)
data("popeurope")

dumbbell_chart(popeurope,
               x = country,
               y1 = pop1952, y2 = pop2007,
               top_n = 10)

## # fig.cap = "\\label{5}A hex bin example"
## hexbin_plot()

knitr::include_graphics('images/fig_735.pdf')

## #There are many graphs (and code) to explore on:
## #www.r-graph-gallery.com

## # fig.cap = "\\label{6}A mosaic plot example"
## mosaic_plot2()

knitr::include_graphics('images/fig_736.pdf')

library(ggmosaic)

ggplot(data = titanic) +
  geom_mosaic(aes(x = product(Sex),
                  fill = Survived))


## # fig.cap = "\\label{7}A ridge plot example"
## ridge_plot()

knitr::include_graphics('images/fig_737.pdf')

library(ggridges)

#minimal code by Claus Wilke:
ggplot(lincoln_weather,
       aes(x = `Mean Temperature [F]`, y = Month, fill = stat(x))) +
  geom_density_ridges_gradient(scale = 3,
                               rel_min_height = 0.01) +
  scale_fill_viridis_c(name = "Temp. [F]",
                       option = "C")

## # fig.cap = "\\label{8}A treemap example"
## tree_map()
## #tree2()

knitr::include_graphics('images/fig_738.pdf')

library(treemapify)
library(gapminder)

data <- gapminder::gapminder |>
  filter(year == 2007 & continent == "Europe")

ggplot(data, aes(area = gdpPercap,
                 fill = lifeExp,
                 label = country)) +
  geom_treemap() +
  geom_treemap_text(colour = "white",
                    grow = TRUE)

## # fig.cap = "\\label{9}A waffle chart example"
## waffle_plot()

knitr::include_graphics('images/fig_739.pdf')

library(waffle)
parts <- c(66, 22, 12)

waffle(parts, rows = 10)

## # fig.cap = "\\label{10}A word cloud example"
## #wordle_plot()
## alice_plot()

knitr::include_graphics('images/fig_7310.pdf')

## #Text Mining with R:
## PracticeR::show_link("textmining")

## #Minimal code by Erwan Le Pennec
library(ggwordcloud)
#to recreate the plot each the exact same way: set a seed (starting point)
set.seed(123)

ggplot(love_words_small, aes(label = word,
                             size = speakers)) +
  geom_text_wordcloud() +
  scale_size_area(max_size = 30)

#R Graphics Cookbook
show_link("r_graphics")
##
## #ggplot2: elegant graphics
## show_link("ggplot2")

## #Fundamentals of Data Visualization
## show_link("fundamentals_dataviz")
##
## #Data Visualization
## show_link("dataviz")

Sys.time()

