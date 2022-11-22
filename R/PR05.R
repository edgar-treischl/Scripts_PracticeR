# 5. First steps of data preparation ###########################################

#The setup of Chapter 5 #####
library(dplyr)
library(forcats)
library(janitor)
library(naniar)
library(readr)
library(tibble)
library(tidyr)


# 5.1 Data import and export ####################################################

## #The readr package reads txt/csv files
## library(readr)
## #Import a csv file
## my_data <- read_csv("path_to_the_file/data.csv")

## #The haven package reads SPSS/Stata files
## haven::read_stata("my_stata.dta")



## #Copy the code to import data from the code preview
## overweight_world <- read_csv("~/data/overweight_world.csv")
## View(overweight_world)

## #Export data
## write_csv(my_new_data, "my_new_data.csv")

## #Info box: The datapasta package #################################################
## #Go to:
## show_link("webscraping")
## #Copy a table and paste via:
## datapasta::tribble_paste()

#A messy variable
x <- c("9", 9, 9, 2, 3, 1, 2)
class(x)

#The as.*() functions convert input, here into a numeric vector
x <- as.numeric(x)
class(x)

#A real example, what a mess!
overweight_world <- read_csv("data/overweight_world.csv")
head(overweight_world)

#Inspect the column specification
spec(overweight_world)

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
## 
## #> Error: unexpected numeric constant in:
## #> "data.frame(
## #>   measurement 1"

#Insert backticks
data.frame(
  `measurement 1` = 1, 
  `2016` = 1
)

#Tibble lets us break name conventions
tibble(
  `measurement 1` = 1, 
  `2016` = 2
)

#Is x a tibble?
tibble::is_tibble(overweight_world)

iris <- as_tibble(iris)

#The iris data
names(iris)

## #snake_case
## my_var <- 1
## 
## #SCREAMING_SNAKE_CASE
## MY_VAR <- 1
## 
## #camelCase
## myVar <- 1
## 
## #Upper_Camel
## MyVar <- 1
## 
## #kebab-case (hmm-mmmm)
## my-var <- 1

## #Rename variable: new_name = variable
## dplyr::rename(iris, sepal_length = Sepal.Length)

#Include rename() in select
iris |> 
  select(
    new_var = Sepal.Length
    )

#The janitor package cleans data 
iris |> 
  janitor::clean_names()

#Another messy data set
messy_data <- data.frame(firstName   = 1:2, 
                         Second_name  = 1:2, 
                         `income in €`  = 1:2,
                         `2009`      = 1:2, 
                         measurement = 1:2, 
                         measurement = 1:2)
names(messy_data)

#Tibble checks duplicates and warns us
tibble(measurement = 1:2,
       measurement = 1:2)

#Janitor gets rid of many crude names
names(messy_data |> janitor::clean_names())

# 5.2 Missing data #############################################################

#NAs in summary functions
x <- c(1, 2, NA, 4, 5, 99)
mean(x)

#is.na checks if value is NA
is.na(x)

#na.rm removes NA
mean(x, na.rm = TRUE) 

#Shall we include na.rm?
x[x == 99] <- NA
mean(x, na.rm=TRUE)









#Tiny data with NAs
df <- tribble(
  ~person, ~country, ~age, ~children, ~age_child2,     ~sex,
       1L,     "US",   NA,        NA,          NA,   "Male",
       2L,     "US",   33,         1,          NA,     "NA",
       3L,     "US",  999,         1,          NA, "Female",
       4L,     "US",   27,         1,          NA,   "Male",
       5L,     "US",   51,        NA,          NA,       NA
  )

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

#Inspect the data frame one more time
df

#Select all variables, except x with a minus (-) sign
df |> 
  select(-age_child2)

#coalesce replaces NAs
children <- c(1, 4, NA, 2, NA)
coalesce(children, 0)

#Drop (all) NAs
library(tidyr)
df |> 
  select(-c(age_child2, country)) |> 
  drop_na()

#na_if takes care of alternative missing values
x <- c(1, 999, 5, 7, 999)
dplyr::na_if(x, 999)

#Replace values
df <- df |> 
  select(-c(age_child2, country)) |> 
  mutate(age = replace(age, age == "999", NA),
         sex = replace(sex, sex == "NA", NA))
df

#Replace NAs
df |> replace_na(list(sex = "Not available"))

#Replace NAs with if_else
df |> replace_na(list(sex = "Not available"))|>
  mutate(age_missing = if_else(is.na(age), "Missing", "Not-missing") )





# 5.3 Categorical variables ####################################################

#forcats == for categorical variables
library(forcats)

df <- gss_cat |> 
  select(marital, relig)

head(df)

#Count levels
fct_count(df$marital)

#Relevel manually
f <- fct_relevel(df$marital, 
                 c("Married", "Never married"))
fct_count(f)

#Recode levels
f <- fct_recode(df$marital,
                "NA" = "No answer",
                `Not married` = "Never married",
                `Not married` = "Separated", 
                `Not married` = "Divorced", 
                `Not married` = "Widowed"
)

fct_count(f)

#Unique levels
fct_unique(df$relig)

#Collapse levels 
f <- fct_collapse(df$marital, 
                  `Not married` = c("Never married", 
                                  "Separated", 
                                  "Divorced", 
                                  "Widowed"))
fct_count(f)

#Keep selected variables and others
f <-fct_other(df$marital, 
              keep = c("Married", "No answer"))

fct_count(f)

#Sort in frequency
f <- fct_infreq(df$relig)
fct_count(f)|> head(n = 10)

#Lump together
f <- fct_lump(df$relig, n = 5) 
f <- fct_infreq(f)
fct_count(f)

## #Info box: The copycat package #################################################
## #Install CopyCat from GitHub:
## #devtools::install_github("edgar-treischl/CopyCat")
## 
## #Explore addin
## copycat::copycat_addin()
## #Or copy code snippet
## library(copycat)
## copycat("fct_count")
