library(tidyverse)
library(palmerpenguins)


#Use R as a calculator:
1 + 2

head(mtcars)

## library(gapminder)
## library(ggplot2)
## library(viridis)
## library(dplyr)
## library(showtext)
##
## font_add_google("Lato", "Lato")
## #font_add_google("Combo", "Combo")
##
## ## Automatically use showtext to render text for future devices
## showtext_auto()
##
## gapminder |>
##   filter (year == 2007) |>
##   mutate(pop=pop/1000000) |>
##   arrange(desc(pop)) |>
##   ggplot(aes(x = log(gdpPercap),
##              y = lifeExp,
##              size = pop,
##              color = continent)) +
##   geom_point(alpha = 0.7)+
##   scale_size(range = c(.1, 25), guide = "none")+
##   #scale_x_continuous(limits = c(5, 12.5)) +
##   scale_y_continuous(limits = c(30, 90))+
##   theme_minimal(base_size = 12, base_family ="Lato")+
##   scale_color_viridis(
##     discrete = TRUE, name = "Region", option = "viridis")+
##   labs(x = "GDP per capita (Log)",
##        y = "Life expectancy (2007)",
##        caption = "Data: Gapminder") +
##   guides(color = guide_legend(override.aes = list(size = 4),
##                               reverse=TRUE))
##

knitr::include_graphics('images/Fig_0102.pdf')

#I add comments for important steps, do the same for your future self
#Try to be explicit and outline what the code does

## #Practice R was build with the following platform and R packages.
## sessioninfo::session_info()

Sys.time()
