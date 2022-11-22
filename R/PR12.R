# 12. Next steps ###############################################################

#Setup Chapter 12
library(DBI)
library(dplyr)
library(dbplyr)
library(gapminder)
library(ggplot2)
library(ggrepel)
library(lubridate)
library(margins)
library(parameters)
library(titanic)
library(tibble)
library(shiny)


# 12.1 Data preparation ########################################################

#Example data
df <-  tribble(
  ~person, ~year, ~income,
        1,  2019,   1821,
        1,  2020,   2291,
        2,  2019,   1971,
        2,  2020,   2146,
        3,  2019,   3544,
        3,  2020,   2877
  )


#Create a lag variable 
df |> 
  group_by(person)|> 
  mutate(income_lag = lag(income))

#Use lubridate to prepare time and date variables
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

#Establish an example SQL connection
library(DBI)
con <- dbConnect(RSQLite::SQLite(), dbname = ":memory:")
dbWriteTable(con, "mtcars", mtcars)
mtcars_sql <- tbl(con, "mtcars")

#Save the data preparation steps as an object
library(dbplyr)
data_prep <- mtcars_sql |> 
  group_by(cyl) |> 
  summarise(mpg = mean(mpg, na.rm = TRUE)) |> 
  arrange(desc(mpg))

#Inspect the SQL query for the last data preparation step
data_prep |> show_query()

# 12.2 Data analysis ###########################################################

#The Titanic data
library(titanic)

#Select variables, for example:
titanic_df <- titanic::titanic_train |> 
  dplyr::select(Survived, Sex, Age)

#inspect data
head(titanic_df)

#Minimal code to run a logistic regression
logit_model <- glm(Survived ~ Sex, family = binomial(link = 'logit'), 
                   data = titanic_df)

#Print a summary
summary(logit_model)

#Inspect odds ratios
logit_model|>
  parameters::parameters(exponentiate = TRUE)

#Inspect marginal effects
logit_margins <- margins::margins(logit_model)
summary(logit_margins)

# 12.3 Visualization ###########################################################

#Left Plot: geom_text 
gapminder %>% filter(year == "2007" & continent == "Europe") %>% 
  ggplot(aes(gdpPercap, lifeExp, label = country)) +
  geom_point(color = "red")+ 
  geom_text(size = 2) + #geom_text
  labs(title = "A: geom_text()")

#Right plot: geom_text_repel
gapminder %>% filter(year == "2007" & continent == "Europe") %>% 
  ggplot(aes(gdpPercap, lifeExp, label = country)) +
  geom_point(color = "red")+
  coord_cartesian(clip = "off") + 
  geom_text_repel(size = 2) + #geom_text_repel
  labs(title = "B: geom_text_repel()")






## #Inspect example shiny apps
## library(shiny)
## runExample("01_hello")
## runExample("02_text")
## runExample("03_reactivity")

## #Mastering Shiny:
## PracticeR::show_link("master_shiny")

# 12.4 Reporting ###############################################################

## #Quarto website:
## #https://quarto.org/

## #chrome_print prints the file as a PDF
## pagedown::chrome_print("my_presentation.html")





#Session info of Practice R
sessioninfo::session_info()
