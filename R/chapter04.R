# 4 Data Manipulation ##########################################################

#Chapter 4 needs the following packages
library(dplyr)
library(magrittr)
library(PracticeR)
library(tidyr)
library(tibble)
library(usethis)

# 4.1 The five key functions of dplyr ##########################################





#The mtcars data set
df <- tibble::as_tibble(mtcars)
head(df)

#Use one or more conditions to filter your data
filter(df, hp > 100)

#Filter with logical and relational operators
#Toy peanuts data
peanuts <- tibble::tribble(
  ~names, ~height_cm, ~sex, ~married,
  "Charlie", 181, "male", 0,
  "Sally", 176, "female", 1,
  "Schroeder", 180, "male", 1,
  "Peppermint Patty", 175, "female", 0
)

#Equal to ==
peanuts |> filter(sex == "female")

#Not equal to: Negation (!=)
#peanuts |> filter(sex != "female")

#AND & (for scalars &&)
peanuts |> filter(sex == "female" & married == 1)

#OR | (for scalars ||)
peanuts |> filter(sex == "female" | married == 1)

#Greater than >
peanuts |> filter(sex == "male" & height_cm > 180)

#Or greater than or equal to >=
#peanuts |> filter(sex == "male" & height_cm >= 180)

#Less than <
peanuts |> filter(sex == "male" & height_cm < 181)

#Or less than or equal to <=
#peanuts |> filter(sex == "male" & height_cm <= 181)

#Arrange the data in an ascending order 
arrange(df, hp)

#Arrange the data in a descending order 
arrange(df, desc(hp))

#Select mpg and hp
select(df, mpg, hp)

#Select variable by providing a start and an endpoint
select(df, mpg:hp)

#Reverse the selection
select(df, -(mpg:hp))

#Select returns a data frame
hp <- select(df, hp)
class(hp)
is.data.frame(hp)

#Use pull to extract a variable/column vector
hp <- pull(df, hp)
is.vector(hp)

#Create a small(er) subset
df_small <- select(df, hp) 
head(df)

#Mutate and create new variables
mutate(df_small, 
       kw = hp * 0.74570,
       hp_new = round(kw * 1.34102, 2))

#Transmute keeps only new (or listed) variables
conversion <- 0.74570

transmute(mtcars,
          hp,
          kw = hp * conversion)|> 
  head()

#Summarize variables
df |> 
  summarize(mean_hp = mean(hp))

#Group by variables
compare_group <- group_by(df, am)

#And summarize for the groups
summarize(compare_group, hp_mean = mean(hp))

#Use the pipe operator to combine steps
df |> 
  group_by(am) |>
  summarize(
    mean_hp = mean(hp)
  )

# 4.2 Data manipulation with dplyr #############################################

#The gssm2016 data
library(PracticeR)
head(gssm2016)

#First attempts ...
gssm2016 |> 
  mutate(age_mean = mean(age))|> 
  head()

#Select variables that are needed ...
gssm2016 |> 
  select(age, income_rc, partners, happy)|> 
  mutate(age_mean = mean(age)
  )|> 
  head()

#An example data
missing_example <- data.frame(x = c(1, NA, 3, NA)) 

#Drop_na drops NA
tidyr::drop_na(missing_example, x)

#Combine steps ...
df <- gssm2016 |> 
  select(age, income_rc, partners, happy) |> 
  drop_na() |>
  mutate(age_mean = mean(age)
  )

head(df)

#Relocate variables to get a better overview
df |> 
  relocate(age_mean, .after = age) 
  

#Instead of selecting variables, create a variable list 
varlist <- c("income_rc", "partners", "happy", "age")

#Include relocate in the mutate step
df |> 
  select(all_of(varlist)) |> 
  drop_na() |> 
  mutate(age_mean = round(mean(age), 2), .before = age
  )


#The chocolate bar stock
chocolate <- 3

#If else statement
if(chocolate > 5){
  print("Don't panic, there is enough chocolate, you may not starve!")
} else {
  print("Jeeez, go and get some chocolate!")
}

#Example data
sex <- c("f", "m", "f")
sex

#The dplyr::if_else function
if_else(sex == "f", 0, 1)

#if_else with numerical input
sex <- c(0, 1, 0)
if_else(sex == 0, "female", "male")

#Insert if_else in the mutation step
df |> 
  select(age, age_mean)|> 
  mutate(older = if_else(age > age_mean, "older", "younger"), 
         .after = age_mean)

#Chain steps with gssm2016 data
gssm2016 |> 
  drop_na(age)|>
  transmute(age, 
            older = if_else(age > mean(age), TRUE, FALSE))


#First case_when attempt
df |> 
  transmute(age,
            older_younger = case_when(
              age <= 17             ~ "younger",
              age > 17  & age <= 64 ~ "in-between",
              age >=  65            ~ "older"))

#The case_when logic
x <- data.frame(age = c(17, 77, 51, NA))

x |> 
  transmute(age,
            older_younger = case_when(
              age <= 17   ~ "younger",
              age >=  65   ~ "older",
              TRUE        ~ "in-between"))

#Build the case_when statement
df |> 
  mutate(age,
        older_younger = case_when(
          age <= 17 & happy =="Pretty Happy" ~ "young_happy",
          age >  65 & happy =="Pretty Happy" ~ "old_happy",
          TRUE                               ~ "others"))

#Between selects observation between a certain range
df |> 
  mutate(age_filter = between(age, 18, 65))

#Restrict the analysis sample
df |> 
  mutate(age_filter = between(age, 18, 65))|> 
  filter(age_filter == "TRUE")

#Recode with ifelse
male <- c("m", "f", "m")
male <- ifelse(male == "m", "male", "female")
male

#Example df
df <- tribble(
  ~male, ~male_num,
  "m", 1,
  "f", 2,
  "m", 1,
   NA, NA,
)


#Recode (factor) variables
recode_factor(df$male , m = "Men", f = "Women")
recode(df$male_num , `1` = 1, `2` = 0)

#Create new variables to check if any errors are introduced
df |> 
  select(male)|> 
  mutate(male_new = if_else(male == "f", "Women", "Men"))

summarize(mtcars, mpg = mean(mpg),
                  cyl = mean(cyl),
                  disp = mean(disp))

#Apply a mean across variables
summarize(mtcars, across(mpg:disp, mean))

#Give me everything (if possible)
summarize(mtcars, across(everything(), mean))

#rownames
head(mtcars)

#Augment your dplyr skills with further packages
mtcars |> 
  tibble::rownames_to_column(var = "car") |> 
  head()

mtcars |> 
  select(mpg)|> 
  arrange(mpg)|> 
  mutate(running_number = 1:nrow(mtcars)
         ) |>
  head()

#Info box: Data manipulation approaches ########################################
#Dplyr: filter data
mtcars |> filter(am == 0)
#Base: subset data
subset(mtcars, am == 0)

#Dplyr: Pull a vector
mtcars |>  pull(hp)
#Base: Extract the vector
hp <- mtcars$hp

#Column names
colnames(mtcars)

#Dplyr: Change a variable name during the select step
mtcars |> select(horsepower = hp)
#Base: Assign horsepower in the names column
names(mtcars)[names(mtcars) == "hp"] <- "horsepower"

# 4.3 Workflow #################################################################

#A small df
df <- tibble(
  x1 = c(3.3, 3.5, 3, 4.4, 5.4),
  x2 = c(3.1, 7.2, 8, 5.5, 4.3),
  x3 = c(3.4, 3.1, 6, 6.2, 8.8)
)

mean(df$x1)

#Column means
colMeans(df)

#Apply a function over a list or a vector
lapply(df, mean)
#Simplify the result, if possible
sapply(df, mean)

#Comments, comments comments!
#Add useful comments that describe what the code does

#Pro tip
#Turn multiple lines into comments and back again:
#Press: Ctrl/Cmd + Shift + C

#00 About ####
#01 Packages ####
#02 Data preparation ####
#03 Data analysis ####
#04 Visualization ####
#05 Further ado ####





#https://style.tidyverse.org/

#Version A: 
df<-mtcars|>group_by(am)|>
  summarize(
    median_hp = median(hp), count = n(), sd = sd(hp), min = min(hp)
  )

#Version B:
df <- 
  mtcars |> 
  group_by(am) |>
  summarize(
    median_hp = median(hp),
    count = n(),
    sd = sd(hp),
    min = min(hp)
  )

## #Set the working directory
## setwd("/Users/edgar/my_scripts/")
## #Import data
## df <- read_csv("my_data.csv")



## #Create a blank slate:
## usethis::use_blank_slate()
## #> Setting RStudio preference save_workspace to 'never'
## #> Setting RStudio preference load_workspace to FALSE

## #Use source to outsource your R script
## source("my_script.R")

## #A simple histogram
## hist(data$x)

## # A histogram with adjusted options
## hist(mpg,
##      main="My title",
##      xlab="The x label",
##      col="darkgray",
##      freq=FALSE
## )

## #Insert fun and press Tab to insert the function snippet
## name <- function(variables) {
## 
## }

## #Use edit_rstudio_snippets() to edit your snippets directly
## usethis::edit_rstudio_snippets()

## #The structure of the fun snippet
## snippet fun
## 	${1:name} <- function(${2:variables}) {
## 		${0}
## 	}



# Summary ######################################################################

## #The dplyr website
## show_link("dplyr")

## #What They Forgot to Teach You About R:
## show_link("forgot_teach")
## #R for Data Science
## show_link("r4ds")
