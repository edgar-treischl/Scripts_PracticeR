#Practice R
#The Setup for Chapter 4########
library(dplyr)
library(magrittr)
library(tidyr)
library(tibble)
library(socviz)


#The Data
str(mtcars)

#use one or more conditions to filter your data
filter(mtcars, hp > 100) %>% head() 

#Compare objects:
a <- 5
b <- 6
#R returns a boolean expression (TRUE/FALSE/NA)
#Is a greater than (or equal to) b
a >  b
a >= b
#Is a less than (or equal to) b
a <  b
a <= b
#Is a exactly equal to b
a == b
#Is a not equal to b
a != b


#arrange your data in an ascending order 
arrange (mtcars, hp) %>% 
  head()

#arrange your data in a descending order 
arrange (mtcars, desc(hp)) %>% 
  head()

#select variables by name
select(mtcars, mpg, hp) %>% 
  head()

#select variable by providing a start and an endpoint
select(mtcars, mpg:hp) %>% 
  head()

#reverse your selection
select(mtcars, -(mpg:hp)) %>% 
  head()

#select returns always a data frame
hp <- select(mtcars, hp) 
class(hp)

#use pull to extract a variable/column vector
hp <- pull(mtcars, hp) 
class(hp)

#to see what happens, we need a subset of the data set first
df <- select(mtcars, hp) 
head(df)

#use mutate to create new variables
conversion <- 0.74570
reconversion <- 1.34102

mutate(df, 
       kw = hp * conversion,
       hp_new = round(kw * reconversion, 2)) %>% 
      head()

#transmute keeps only new (or listed) variables
transmute(mtcars,
          hp,
          kw = hp * conversion) %>% 
  head()

mtcars %>% 
  summarise(mean_hp = mean(hp))

compare_group <- group_by(mtcars, am)
compare_group

summarise(compare_group, hp_mean = mean(hp))

mtcars |> 
  group_by(am) |>
  summarise(
    mean_hp = mean(hp)
  )

head(mtcars) 

mtcars %>% 
  rownames_to_column(var = "car") %>% 
  head()

mtcars %>% 
  select(mpg)%>% 
  arrange(mpg)%>% 
  mutate(running_number = 1:nrow(mtcars)
         ) %>%
  head()



########GSS DATA###########
head(gss_sm)


gss_sm %>% 
  mutate(age_mean = mean(age))%>% 
  head()

gss_sm %>% 
  select(age, income_rc, partners, happy)%>% 
  mutate(age_mean = mean(age)
  )%>% 
  head()

missing_example <- data.frame(x = c(1, 3, 7, NA, 3, NA)) 

tidyr::drop_na(missing_example, x)

df <- gss_sm %>% 
  select(age, income_rc, partners, happy) %>% 
  drop_na() %>%
  mutate(age_mean = mean(age)
  )

head(df)

df <- df %>% 
  relocate(age_mean, .after = age) 
  
head(df)

varlist <- c("income_rc", "partners", "happy", "age")

gss_sm %>% 
  select(varlist) %>% 
  drop_na() %>% 
  mutate(age_mean = round(mean(age), 2), .before = age
  ) %>% 
  head()


chocolate <- 3

if(chocolate > 5){
  print("Don't panic, there is enough chocolate, you may not starve!")
} else {
  print("Jeeez, go and get some chocolate!")
}

sex <- c("f", "m", "f")
sex

#base R
ifelse(sex == "f", 0, 1)
#dplyr 
if_else(sex == "f", 0, 1)

sex <- c(0, 1, 0)
if_else(sex == 0, "female", "male")

df %>% 
  select(age, age_mean)%>% 
  mutate(older = if_else(age > age_mean, "older", "younger"), 
         .after = age_mean) %>% 
  head()

df <- df %>% 
  select(!age_mean) %>%
  mutate(older = if_else(age > mean(age), TRUE, FALSE))

head(df)

df %>% 
  transmute(age,
            age_cat = case_when(age <= 17  ~ "younger",
                                   age >  65  ~ "older")
         )%>% 
  head()

df %>% 
  transmute(age,
            older_younger = case_when(age <= 17             ~ "younger",
                                      age > 17  | age <= 64 ~ "in-between",
                                      age >  65             ~ "older")
  )%>% 
  head()

df %>% 
  transmute(age,
            older_younger = case_when(age <= 17   ~ "younger",
                                      age >  65   ~ "older",
                                      TRUE        ~ "in-between")
  )%>% 
  head()

df %>% 
  mutate(age,
        older_younger = case_when(age <= 17 & happy =="Pretty Happy"     ~ "young_happy",
                                      age >  65 & happy =="Pretty Happy" ~ "old_happy",
                                      TRUE                               ~ "others")
  )%>% 
  head()

df %>% 
  mutate(age_range65 = between(age, 18, 65))%>% 
  head()

df %>% 
  mutate(age_range65 = between(age, 18, 65))%>% 
  filter(age_range65 == "TRUE") %>% 
  head()

male <- c("m", "f", "m")
male <- ifelse(male == "m", "male", "female")
male

df <- data.frame(male = c("m", "f", "m", NA),
                 male_num = c(1, 2, 1, NA)) 
df 


recode_factor(df$male , m = "Men", f = "Women")
recode(df$male_num , `1` = 1, `2` = 0)

df %>% 
  select(male)%>% 
  mutate(male_new = if_else(male == "f", "Women", "Men"))

df <- data.frame(country = c("Germany", "UK", "Ituly")) 

df %>% 
  mutate(country = recode(country , Ituly = "Italy"))

summarise(mtcars, mpg= mean(mpg),
                  cyl= mean(cyl),
                  disp= mean(disp))

summarise(mtcars, across(mpg:disp, mean))

summarise(mtcars, across(everything(), mean))


#Workflow#################

df <- tibble(
  x1 = c(3.3, 3.5, 3, 4.4, 5),
  x2 = c(3.1, 7.2, 8, 5.5, 4.3),
  x3 = c(3, 3.1, 6, 6, 8),
  x4 = c(8.4, 1.4, 2, 8.1, 9.0)
)

mean(df$x1)

colMeans(df)

sapply(df, mean)

# Use the # sign to make comments!

## ########################################################
## # Pro Tip: Turn multiple lines into comments and back again:
## # Ctrl/Cmd + Shift + C
## ########################################################

## #01 Packages####
## library(tidyverse)
## library(ggplot2)

## #00 About ####
## #01 Packages ####
## #02 Data Preparation ####
## #03 Data Analysis ####
## #04 Visualization ####
## #05 Further ado ####



#Version A: 
df <- data.frame(
  group = c("Treatment", "Control"),
  outcome = c(3.6, 4.4)
)

#Version B: 
df <- data.frame(
  group = c("Treatment", "Control"), outcome = c(3.6, 4.4)
)

#Version A: 
df<-mtcars%>%group_by(am)%>%
  summarise(
    median_hp = median(hp), count = n(), sd = sd(hp), min = min(hp)
  )

#Version B:
df <- 
  mtcars %>% 
  group_by(am) %>%
  summarise(
    median_hp = median(hp),
    count = n(),
    sd = sd(hp),
    min = min(hp)
  )

## #set the working directory
## setwd("/Users/edgar/my_scripts/")
## #import data
## df <- read_csv("my_data.csv")

#List objects of the environment
ls()
#remove all objects with 
#rm(list=ls())


## #insert fun and press TAB to insert the function snippet
## name <- function(variables) {
## 
## }


## snippet fun
## 	${1:name} <- function(${2:variables}) {
## 		${0}
## 	}

## snippet my_base_hist
## 	hist(${1:variable},
## 		main="${2:title}",
## 		xlab="${3:label}",
## 		col="darkgray",
## 		freq=FALSE
## 		)


## #Use edit_rstudio_snippets() to edit your snippets directly
## usethis::edit_rstudio_snippets()
