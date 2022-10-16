library(tidyverse)
library(AER)
data(NMES1988)

df_NMES1988<- NMES1988

theme_set(theme_minimal()) # sets a default ggplot theme
library(DBI)
library(dplyr, warn.conflicts = FALSE)

con <- dbConnect(RSQLite::SQLite(), dbname = ":memory:")
dbWriteTable(con, "mtcars", mtcars)

#copy_to(con, mtcars)

mtcars_sql <- tbl(con, "mtcars")
mtcars_sql

options(tibble.print_max = 25, tibble.print_min = 5)

knitr::opts_chunk$set(
  fig.width = 6, fig.height = 4, fig.path = "images/", cache = TRUE,
  echo = TRUE, warning = FALSE, message = FALSE, eval = TRUE
)

knitr::opts_chunk$set(
  fig.process = function(filename) {
    new_filename <- stringr::str_remove(
      string = filename,
      pattern = "-1"
    )
    fs::file_move(path = filename, new_path = new_filename)
    ifelse(fs::file_exists(new_filename), new_filename, filename)
  }
)

#knitr::opts_chunk$set(tidy = "styler")

#source("utils.R")
Sys.setenv(lang = "en_US")


#Example data
df <- tribble(
  ~person, ~year, ~income,
  1, 2019, 2000,
  1, 2020, 2200,
  2, 2019, 1977,
  2, 2020, 1977,
  3, 2019, 3500,
  3, 2020, 3000
)

#Create a lag variable 
df |> 
  group_by(person)|> 
  mutate(income_lag = lag(income))

#Use lubridate to prepare time and date variables
library(lubridate)
x <- lakers$date[1]
x

# The ymd() function convert integers to a date
dates <- ymd(x)
dates

#Still an integer?
class(dates)

#Extract the day of a month
mday(dates)

#Extract month
month(dates)

#Extract years
year(dates)

#An example data preparation step
mtcars |> 
  group_by(cyl) |> 
  summarise(mpg = mean(mpg, na.rm = TRUE)) |> 
  arrange(desc(mpg))

#Save the data preparation steps as an obejects
library(dbplyr)
data_prep <- mtcars_sql |> 
  group_by(cyl) |> 
  summarise(mpg = mean(mpg, na.rm = TRUE)) |> 
  arrange(desc(mpg))

#Inspect the SQL query for the last data preparation step
data_prep |> show_query()

#The Titanic data
library(titanic)

#select variables
titanic_df <- titanic::titanic_train |> 
  dplyr::select(Survived, Sex, Age)

#inspect data
head(titanic_df)

#Minimal code to run a logistic regression
logit_model <- glm(Survived ~ Sex, family = binomial(link = 'logit'), 
                   data = titanic_df)

#print a summary
summary(logit_model)

#Inspect odds ratios
logit_model|>
  parameters::parameters(exponentiate = TRUE)

#Inspect marginal effects
logit_margins <- margins::margins(logit_model)
summary(logit_margins)

## library(gapminder)
## library(ggrepel)
## 
## #Left Plot: geom_text
## gapminder %>% filter(year == "2007" & continent == "Europe") %>%
##   ggplot(aes(gdpPercap, lifeExp, label = country)) +
##   geom_point(color = "red")+
##   geom_text(size = 2) + #geom_text
##   labs(title = "A: geom_text()")
## 
## #Right plot: geom_text_repel
## gapminder %>% filter(year == "2007" & continent == "Europe") %>%
##   ggplot(aes(gdpPercap, lifeExp, label = country)) +
##   geom_point(color = "red")+
##   coord_cartesian(clip = "off") +
##   geom_text_repel(size = 2) + #geom_text_repel
##   labs(title = "B: geom_text_repel()")
## 

library(gapminder)
library(ggrepel)
p1<- gapminder %>% filter(year == "2007" & continent == "Europe") %>% 
  ggplot(aes(gdpPercap, lifeExp, label = country)) +
  geom_point(color = "red")+
  geom_text(size = 2) + 
  labs(title = "A: geom_text()")

p2 <- gapminder %>% filter(year == "2007" & continent == "Europe") %>% 
  ggplot(aes(gdpPercap, lifeExp, label = country)) +
  geom_point(color = "red")+
  coord_cartesian(clip = "off") +
  geom_text_repel(size = 2) + 
  labs(title = "B: geom_text_repel()")
gridExtra::grid.arrange(p1, p2, ncol=2)

knitr::include_graphics('images/Fig_1202.png')

## #Inspect example shiny apps
## library(shiny)
## runExample("01_hello")
## runExample("02_text")
## runExample("03_reactivity")

#Mastering Shiny:
PracticeR::show_link("master_shiny", browse = FALSE )

## #Quarto website: <https://quarto.org/>

## #chrome_print prints the file as a PDF
## pagedown::chrome_print("template.html")

print_cran <- function(variables) {
  db <- tools::CRAN_package_db()
  
  #colnames(db)
  mdf <- data.frame(db[,1])
  
  colnames(mdf) <- c("Package")
  packages <- as.character(mdf$Package)
  
  nr_packages <- stringi::stri_unique(packages)
  length(nr_packages)
  
}

num <- print_cran()

num <- 18414L

## #Session info of Practice R
## sessioninfo::session_info()

Sys.time()
