#Source file Practice R: Chapter 12
#Author: Edgar Treischl
#Source file from: GitHub
#Updates: None

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

# The ymd() function converts integers to a date
dates <- ymd(x)
dates

#Still an integer?
class(dates)

#Extract the day of a month
mday(dates)

#Extract month
month(dates)

#Extract year
year(dates)

#Establish a connection to the database
# library(DBI)
# con <- DBI::dbConnect(drv = odbc::odbc(),
#                       host = "host",
#                       port = 3306,
#                       dbname = "database_name",
#                       user = "user",
#                       password = "password")

#A SQL example:
#SELECT mpg FROM mtcars LIMIT 3;


#Establish a connection to the local memory
con_myDB <- dbConnect(drv = RSQLite::SQLite(),
                 dbname = ":memory:")

#Write a table into the "database"
dbWriteTable(conn = con_myDB,
             name = "mtcars",
             value = mtcars)

#List all tables
dbListTables(con_myDB)

#Get SQL Query
dbGetQuery(con_myDB, 'SELECT mpg FROM mtcars LIMIT 3;')

# 12.2 Data analysis ###########################################################

#The Titanic data
library(titanic)

#Select variables, for example:
titanic_df <- titanic::titanic_train |>
  dplyr::select(Survived, Sex)

#Inspect
head(titanic_df)

#Minimal code to run a logistic regression
logit_model <- glm(Survived ~ Sex, family = binomial(link = 'logit'),
                   data = titanic_df)

#Print a summary
summary(logit_model)

#Inspect odds ratios with the parameters package
logit_model|> parameters::parameters(exponentiate = TRUE)

#Inspect marginal effects with the margins package
logit_margins <- margins::margins(logit_model)
summary(logit_margins)

#The tidymodels website
#https://www.tidymodels.org/

# 12.3 Visualization ###########################################################

#Gapminder data
gapminder_df <- gapminder |>
  filter(year == "2007" & continent == "Europe")

#Left Plot: geom_text
ggplot(gapminder_df, aes(gdpPercap, lifeExp, label = country)) +
  geom_point(color = "red")+
  labs(title = "A: geom_text()")+
  geom_text()

#Right plot: geom_text_repel
ggplot(gapminder_df, aes(gdpPercap, lifeExp, label = country)) +
  geom_point(color = "red")+
  labs(title = "B: geom_text_repel()")+
  geom_text_repel()




#Inspect example shiny apps: 01_hello, 02_text, etc.
library(shiny)
#runExample("01_hello")


#Mastering Shiny:
#PracticeR::show_link("master_shiny")

# 12.4 Reporting ###############################################################

#Quarto website:
#https://quarto.org/

#chrome_print exports the file as a PDF
#pagedown::chrome_print("my_presentation.html")
