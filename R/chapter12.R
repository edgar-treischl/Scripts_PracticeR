#Chapter 12###########
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


#Example data prep########
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
#library(lubridate)
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


#Establish an example SQL connection to illustrates dbplyr (FEHLER: Fußnote?)
library(DBI)
library(dplyr, warn.conflicts = FALSE)

con <- dbConnect(RSQLite::SQLite(), dbname = ":memory:")
dbWriteTable(con, "mtcars", mtcars)
mtcars_sql <- tbl(con, "mtcars")

#Save the data preparation steps as an obejects
#library(dbplyr)
data_prep <- mtcars_sql |>
  group_by(cyl) |>
  summarise(mpg = mean(mpg, na.rm = TRUE)) |>
  arrange(desc(mpg))

#Inspect the SQL query for the last data preparation step
data_prep |> show_query()




#Logistic Regression in a Nutshell#############
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


#Visualization next steps############


library(gapminder)
library(ggrepel)

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



#Inspect example shiny apps
#library(shiny)
#runExample("01_hello")
#runExample("02_text")
#runExample("03_reactivity")

#Mastering Shiny:
PracticeR::show_link("master_shiny", browse = F)

#Reporting

#Quarto website: <https://quarto.org/>

#chrome_print prints the file as a PDF
#pagedown::chrome_print("template.html")
