
#The Setup
library(tidyverse)
library(janitor)
library(naniar)
library(forcats)
library(haven)

## #the readr package reads txt/csv files
## library(readr)
## #import a csv file
## my_data <- read_csv("path_to_the_file/data.csv")

## #The haven package reads stata files
## library(haven)
## dataset <- read_stata("my_stata.dta")



## #Copy code to import data from the code preview
## overweight_world <- read_csv("~/data/overweight_world.csv")
## View(overweight_world)

## #Export data
## write_csv(my_new_data, "my_new_data.csv")



#A messy tibble
df <- tibble(x = c("9", 9, 9, 2, 3, 1, 2))
class(df$x)

#The as.*() functions convert input, here into an numeric vector
df$x <- as.numeric(df$x)
class(df$x)

#A real example, what a mess!
#overweight_world <- read_csv("data/overweight_world.csv")
#head(overweight_world)

#Inspect the column specification
#spec(overweight_world)

#Guess_parser reveals the parser to encode data
guess_parser(c("Hello world"))
guess_parser(c("2000,5", "2005,44", "2010,3"))
guess_parser(c("TRUE", "FALSE"))

## #Adjust the column specification if it is necessary
## overweight_world <- read_csv("data/overweight_world.csv",
##     col_types = cols(code = col_skip(),
##                     `2016` = col_integer())
##     )

## #Refer to NA indicators with the na option
## read_excel("data.xlsx",
##            na = "99")

## #This code returns an error:
## data.frame(
##   measurement 1 = 1,
##   2016 = 1)
## #> Error: unexpected numeric constant in:
## #> "data.frame(
## #>  measurement 1"
## #> Error: unexpected ')' in "  2016 = 2)"

#Insert back ticks
data.frame(
  `measurement 1` = 1, 
  `2016` = 1
)

#Tibble let us break name conventions
tibble(
  `measurement 1` = 1, 
  `2016` = 2
)

#Is x a tibble?
#is_tibble(overweight_world)

#The iris data
head(iris)
df <- as_tibble(iris)



## #snake_case
## my_var <- 1
## #SCREAMING_SNAKE_CASE
## MY_VAR <- 1
## #camelCase
## myVar <- 1
## #Upper_Camel
## MyVar <- 1
## #kebab-case hmm-mmmm
## my-var <- 1

## #rename variable: new_name = variable
## dplyr::rename(df, sepal_length = Sepal.Length)

#include rename in select
df %>% 
  select(
    new_var = Sepal.Length
    )

#The janitor package cleans data 
iris %>% 
  janitor::clean_names()%>%
  head()

#Another messy data set
messy_data <- data.frame(firstName   = 1:2, Second_name  = 1:2, `income in €`  = 1:2,
                         `2009`      = 1:2, measurement = 1:2, measurement = 1:2)
names(messy_data)

#Tibble checks duplicates and warns us
tibble(measurement = 1:2,
       measurement = 1:2)

#Janitor gets rid of many crude names
names(messy_data %>% janitor::clean_names())

#NA in summary functions
df <- tibble(satisfaction = c(1, 2, NA, 3, 4, 5, 99))
mean(df$satisfaction)

#is.na checks if value is NA
is.na(df$satisfaction)

#na.rm removes NA
mean(df$satisfaction, na.rm = TRUE) 

#shalle we include na.rm?
df$satisfaction[df$satisfaction == 99] <- NA
mean(df$satisfaction, na.rm=TRUE)



#Tiny data with NAs
df <- tibble(person = 1:5,
             country   = c(rep("US", times = 5)),
             age   = c(NA, 33, 999, 27, 51),
             children = c(NA, rep(1, times = 3), NA),
             age_child2   = c(rep(NA, times = 5)),
             sex = c("Male", "NA", "Female", "Male", NA))
df

#How many missing value has the variable sex?
sum(is.na(df$sex))

#At which position?
which(is.na(df$sex))

#naniar provides functions and graphs to explore missing values
library(naniar)

#n_miss counts number of missings
n_miss(df)

#n_complete counts complete cases
n_complete(df)

#How many missings has the data?
vis_miss(df)

#inspect the data frame one more time
df

#select all variables, except x with a - sign
df %>% 
  select(-age_child2)

#coalesce replaces NAs
children <- c(1, 4, NA, 2, NA)
coalesce(children, 0)

library(tidyr)
#Drop NAs
df %>% 
  select(-c(age_child2, country)) %>% 
  drop_na(sex)

#Drop all NAs
df %>% 
  select(-c(age_child2, country)) %>% 
  drop_na()

#na_if takes care of alternative missing values
x <- c(1, 999, 5, 7, 999)
na_if(x, 999)

#Replace values
df <- df %>% 
  select(-c(age_child2, country)) %>% 
  mutate(age = replace(age, age == "999", NA),
         sex = replace(sex, sex == "NA", NA))
df

#Replace NAs
df %>% replace_na(list(sex = "Not available"))

#Replace NAs with if_else
df %>% replace_na(list(sex = "Not available"))%>%
  mutate(age_missing = if_else(is.na(age), "Missing", "Not-missing") )




#forcats == for categorical variables
library(forcats)
#Count levels
class(gss_cat$marital)
fct_count(gss_cat$marital)

#Relevel manually
f <- fct_relevel(gss_cat$marital, 
                 c("Married", "Never married"))
fct_count(f)

#Recode levels
f <- fct_recode(gss_cat$marital,
                "NA" = "No answer",
                `Not married` = "Never married",
                `Not married` = "Separated", 
                `Not married` = "Divorced", 
                `Not married` = "Widowed"
)

fct_count(f)

#Unique levels
fct_unique(gss_cat$relig)

#Collapse levels 
f <- fct_collapse(gss_cat$marital, 
                  `Not married` = c("Never married", 
                                  "Separated", 
                                  "Divorced", 
                                  "Widowed"))
fct_count(f)

#Keep selected variables and others
f <-fct_other(gss_cat$marital, 
              keep = c("Married", "No answer"))

fct_count(f)

#Sort in frequency
f <- fct_infreq(gss_cat$relig)
fct_count(f)%>% head(n = 10)

#Lump together
f <- fct_lump(gss_cat$relig, n = 5) 
f <- fct_infreq(f)
fct_count(f)
