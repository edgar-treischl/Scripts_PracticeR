#Source file Practice R: Chapter 5
#Author: Edgar Treischl
#Source file from: GitHub
#Updates: None

# 5. Prepare data ##############################################################

#The setup of Chapter 5
library(dplyr)
library(forcats)
library(janitor)
library(naniar)
library(readr)
library(tibble)
library(tidyr)


# 5.1 Data import and export ####################################################

#Import a csv file
# library(readr)
# my_data <- read_csv("path_to_the_file/data.csv")

#Import a stata (spss) file
#haven::read_stata("my_stata.dta")


#system.file returns the path of system files
overweight_path <- system.file("files", "overweight_world.csv",
                          package = "PracticeR")

overweight_world <- read_csv(overweight_path)

#Export data
#write_csv(my_new_data, "my_new_data.csv")

#Info box: The datapasta package #################################################
#Go to:
#PracticeR::show_link("webscraping")
#Copy a table and paste via:
#datapasta::tribble_paste()


#A messy variable
x <- c("9", 9, 9, 2, 3, 1, 2)
class(x)

#As numeric
as.numeric(x)

#As character
y <- c(3.11, 2.7)
as.character(y)

#A real example, what a mess!
#overweight_world <- read_csv("data/overweight_world.csv")
head(overweight_world)

#Inspect the column specification
spec(overweight_world)

#Guess_parser reveals the parser to encode data
guess_parser(c("Hello world"))
guess_parser(c("2000,5", "2005,44", "2010,3"))
guess_parser(c("TRUE", "FALSE"))

#Adjust the column specification if it is necessary
# overweight_world <- read_csv("data/overweight_world.csv",
#     col_types = cols(code = col_skip(),
#                     `2016` = col_integer())
#     )

#Refer to NA indicators with the na option
# read_excel("data.xlsx",
#            na = "99")

#This code returns an error:
# data.frame(
#   measurement 1 = 1,
#   2016 = 1)

#Insert backticks
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
tibble::is_tibble(overweight_world)

#The iris data
iris <- as_tibble(iris)
names(iris)

#snake_case
my_var <- 1

#SCREAMING_SNAKE_CASE
MY_VAR <- 1

#camelCase
myVar <- 1

#Upper_Camel
MyVar <- 1

#kebab-case (hmm-mmmm)
my-var <- 1

#Rename variable: new_name = variable
#dplyr::rename(iris, sepal_length = Sepal.Length)

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



library(gapminder)
head(gapminder)

#A data frame (df) to illustrate:
df <- tibble::tribble(
   ~country, ~outcome, ~measurement,
  "Germany",    "gdp",          3.8,
  "Germany",    "pop",        83.24,
       "UK",    "gdp",          2.7,
       "UK",    "pop",        67.22
  )

#tidyr::pivot_wider converts long data into the wide format
df |>
  pivot_wider(names_from = outcome,
              values_from = measurement)

df <- tibble::tribble(
   ~country, ~outcome, ~measurement,
  "Germany",        1,          3.8,
  "Germany",        2,        83.24,
       "UK",        1,          2.7,
       "UK",        2,        67.22
  )

#Add names_prefix
df |>
  pivot_wider(
    names_from = "outcome",
    names_prefix = "outcome_",
    values_from = "measurement"
  )

df <- tibble::tribble(
  ~continent, ~country, ~time,   ~x,   ~y,
    "Europe",     "UK",     1, 0.78, 0.77,
    "Europe",     "UK",     2, 0.63, 0.98,
    "Europe",     "UK",     3, 0.07, 0.18,
      "Asia",  "Japan",     1, 0.26, 0.69,
      "Asia",  "Japan",     2, 0.07, 0.11,
      "Asia",  "Japan",     4, 0.16, 0.13
  )

#Include time-varying variables in values_from
df |>
  pivot_wider(
    names_from = time,
    values_from = c(x, y), names_sep = "_"
  )

#Fill in missing values with, for example, 99:
df |>
  pivot_wider(
    names_from = time,
    values_from = c(x, y),
    values_fill = 99
  )

#Wide data frame
df <- tibble::tribble(
  ~continent,  ~country,  ~x1,  ~x2,  ~x3,  ~x4,  ~x5,
    "Europe", "Germany", 0.18, 0.61, 0.39,   NA, 0.34,
    "Europe",      "UK", 0.81, 0.35, 0.69, 0.22,   NA
  )


#pivot_longer converts wide data into the long format
df |>
  pivot_longer(
    cols = c(`x1`, `x2`, `x3`, `x4`, `x5`),
    names_to = "time",
    values_to = "outcome"
  )

#Starts_with searches for variables strings
#Adjust prefixes with names_prefix
df |>
  pivot_longer(
    cols = starts_with("x"),
    names_to = "time",
    names_prefix = "x",
    values_to = "outcome"
  ) |>
  head()


#Two example data sets
df1 <- tibble::tribble(
  ~country,  ~gdp,
  "Brazil",  1.44,
   "China", 14.72,
      "UK",  2.67
  )

df2 <- tibble::tribble(
   ~country,  ~pop,
  "Germany", 83.24,
    "Italy", 59.03,
       "UK", 67.22
  )


#Inner join
inner_join(df1, df2, by = "country")

#Full join
full_join(df1, df2, by = "country")

#Left join
left_join(df1, df2, by = "country")

#Right join
right_join(df1, df2, by = "country")

#Two messy data sets
df1 <- tibble::tribble(
   ~country,  ~gdp,
    "China", 14.72,
  "Germany",  3.85,
       "UK",  2.67
  )

df2 <- tibble::tribble(
   ~country, ~gdp,
   "Brazil", 1.44,
  "Germany", 3.85,
       "UK", 2.67
  )


#Semi join
semi_join(df1, df2, by = "country")


#Anti join
anti_join(df1, df2, by = "country")

#An union combines data frames and drops duplicates
union(df1, df2)

# 5.2 Missing data #############################################################

#NAs in summary functions
x <- c(1, 2, NA, 4, 5, 99)
mean(x)

#is.na checks if a value is NA
is.na(x)

#na.rm removes NAs
mean(x, na.rm = TRUE)

#Shall we include na.rm?
x[x == 99] <- NA
mean(x, na.rm=TRUE)

#Summary of the simulated data
head(rubin_simdata)


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

#Select all variables, except -x
df |>
  select(-c(age_child2, country))

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

#Keep selected levels and others
f <-fct_other(df$marital,
              keep = c("Married", "No answer"))

fct_count(f)

#Sort in frequency
f <- fct_infreq(df$relig)
fct_count(f)|> head(n = 6)

#Lump together
f <- fct_lump(df$relig, n = 5)
f <- fct_infreq(f)
fct_count(f)



#Info box: The copycat package #################################################
#Install CopyCat from GitHub:
#devtools::install_github("edgar-treischl/CopyCat")

#Explore the copycat addin
library(copycat)
#copycat::copycat_addin()

#Or copy code snippets from CopyCatCode
#copycat("fct_count")
#> [1] "Copied that: fct_count(gss_cat$race)"
