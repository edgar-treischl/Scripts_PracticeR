
# library(tidyverse)
# library(rvest)
# library(tidyverse)
# 
# pr_site <- "website_PR.html"
# pr_html <- read_html(pr_site)
# raw_text <- readRDS(file = "raw_text.rds")
# #unemployment <- readRDS(file = "unemployment.rds")




#Set the engine for chapter 11:
library(stringr)
library(stringi)
library(pdftools)
library(dplyr)
library(rvest)
library(DemografixeR)
library(httr)
library(purrr)
library(clipr)
library(tidyr)
library(gapminder)

## # PDF Files#####################################################################
## 

## ## Regular expressions##########################################################

library(stringr)
#Example strings
strings <- c("Tom. 2000",
             "Olivia: 99")

#The search pattern
pattern <- "Tom"

#Extract a string
str_extract(strings, pattern)

#Subset a string
str_subset(strings, pattern)

#Regular expressions might be needed to extract a string
str_extract(strings, "\\w")
str_extract(strings, "\\d")

#Search for four digits
str_extract(strings, "\\d\\d\\d\\d")

# + : Plus indicate if a character appears one or more times
str_extract(strings, "\\d+")

# ? matches 0 or 1 times
str_extract(c("Emily", "Emely"), "Em\\i?e?ly")

# * matches 0 or more times
str_extract(c("9", "99", "981"), "9\\d*")

# . matches any single character (without \n)
str_extract(c("edgar-treischl@mailadress.com"), "\\w+.\\w+")

shoppinglist <- "Cheese,
                 Fish/Chips,
                 Strawberries" 
writeLines(shoppinglist)

shoppinglist <- "Cheese\nFish/Chips\nStrawberries" 
writeLines(shoppinglist)

#Extract a string
str_extract(strings, "\\w+\\.")
str_extract(strings, "\\w+.")

# Use a character class []
#str_view_all shows the matching as an html file in the viewer
str_view_all(strings, "[aeiou]")


#[:alpha:] == letters
str_extract(strings, "[:alpha:]+")
#[:digit:] == digits
str_extract(strings, "[:digit:]+")

string <- c("123", "abc", "AB C", ",?()")
#lowercase
str_extract(string, "[:lower:]+")
#uppercase
str_extract(string, "[:upper:]+")
#punctuation
str_extract(string, "[:punct:]+")
#letters and numbers
str_extract(string, "[:alnum:]+")

strings <- c("Tom is born on 29 May 2000.", 
             "Olivia has her birthday on 9 August 1999.")

#Create a range with -
str_extract(strings, "[0-9]")

#Use a quantifier {}: exactly 1 (or n) times
str_extract(strings, "[0-9]{1}")
#1 (n) or more times
str_extract(strings, "[0-9]{1,}")
#between 1 (n) and 2 (m)
str_extract(strings, "[0-9]{1,2}")

#Regex are case sensitive: [A-Z] for upper, [a-z] for lowercase 
str_extract(strings, "[0-9]{1,2} [A-Z][a-z]+")

#Extract and save the dates:
dates <- str_extract(strings, "[0-9]{1,2} [A-Z][a-z]+ [0-9]{2,}")
dates

#start of string: ^
day <- str_extract(dates, "^[0-9]+")
day
#end of string: $
year <- str_extract(dates, "[0-9]+$")
year

#Further ado for the month and the name
month <- str_extract(dates, "[A-Z][a-z]+")
name <- str_extract(strings, "^[A-Z][a-z]+")

df <- data.frame(name, day, month, year)
df

## ## The `stringr` package########################################################

#str_split_fixed splits the string
dates_df <- dates |> 
  str_split_fixed(pattern = " ", n = 3)

dates_df

#str_c combines strings
str_c(dates_df[, 1], dates_df[, 2], dates_df[, 3], sep = " ")

#Try if the code does what it supposed to do with fruits or sentences: 
head(fruit)
head(sentences)

fruits <- c("apple", "banana", "pear", "pineapple")
#detect a search pattern
str_detect(fruits, "pp")
#count how often the search pattern appears
str_count(fruits, "pp")

#starts the string with a patterns
str_starts(fruits, "a")
#And at which location
str_locate(fruits, "apple")

#Replace (all) strings
fruits <- c("apple", "banana", "pear", "pineapple")
str_replace(fruits, "a", "X")
str_replace_all(fruits, "a", "X")

#Lengths of strings
str_length(fruits)

#Sort strings
fruits <- c("banana", "apricot", "apple", "pear")
str_sort(fruits, decreasing = FALSE)

#stri_unique returns unique strings
fruits <- c("apple", "apple", "apple", "pineapple")
stringi::stri_unique(fruits)


head(PracticeR::unemployment)


#read the content of a pdf file via pdf_text
#raw_text <- pdftools::pdf_text("My_file.pdf")
raw_text <- PracticeR::unemployment_raw
text <- str_split(raw_text, "\n")
text <- as_vector(text)

## #str_split splits the raw text after each new line
## #txt <- raw_text
## text <- str_split(raw_text, "\n")
## text <- as_vector(text)
## head(text)

## #Inspect for irregularities
## text[17:18]

#replace extra lines and |
#extralines <- c("\\|\n", "\\|")
text <- str_replace_all(raw_text, pattern = "\\|\n", "")
text <- str_replace_all(text, pattern = "\\|", "")

#Split file
text <- str_split(text, "\n")
text <- as_vector(text)

#str_which returns at which position(s) the string appears
str_which(text, "Australia")
str_which(text, "United States")

start <- str_which(text, "Australia")
end <- str_which(text, "United States")
text_df <- text[start:end]


text_df <- str_replace_all(text_df, ":", "")
text_df <- text_df[text_df != ""]



text_split <- str_split_fixed(text_df, " {2,}", n = 11)
df <- tibble::as_tibble(text_split)
df

#Create a vector for the column names
colum_names <- c("country", seq(2011, 2020, by = 1))
#colum_names <- append(year_sequence, "country", after = 0)
names(df) <- colum_names
names(df)

str_subset(df$`2020`, "e")
#str_remove_all removes characters, here footnote signs
df$`2020`<- str_remove_all(df$`2020`, "[:alpha:]")

#which country with the highest unemployment rates?
df |>
  select(country, `2020`)|>
  slice_min(order_by = `2020`, n = 5)

#Don't forget that we imported characters from a PDF ...
df$`2020` <- as.numeric(df$`2020`)

df |>
  select(country, `2020`)|>
  slice_max(order_by = `2020`, n = 5)




#Go and visit the website:
#https://edgar-treischl.github.io/PracticeR/articles/webscraping.html



#the practice r website
library(rvest)
pr_site <- "https://edgar-treischl.github.io/PracticeR/articles/web_only/webscraping.html"

#read_html reads the website
pr_html <- read_html(pr_site)

#body node with all children
pr_html |> 
  html_node("body") |> 
  html_children()

#extract elements
pr_html |> html_elements("h1")
pr_html |> html_elements("p")

pr_html |> 
  html_elements("a") |>        
  html_attr("href") |>
  head()

#tables
pr_html |> 
  html_element("table") |> 
  html_table()|>
  head()

html <- minimal_html("<body>
  <p>A unordered list:<p>
  <ul>
  <li>Tom is 15 years old.</li>
  <li>Pete is 20 years old.</li>
  <li>Ingrid is 21 years old.</li>
  </ul>
                     ")

html |> 
  html_elements("li")

txt <- html |> 
  html_elements("li")|> 
  html_text2()

txt

stringr::str_extract(txt, "[A-Z][a-z]+")
stringr::str_extract(txt, "[0-9]+")




#class via .
pr_html |> html_elements(".all_tables")

pr_html |> 
  html_elements("#company") |>
  html_table()

library(DemografixeR)
names <- c('Edgar', 'James', 'Veronica', 'Marta', 'Fritz')
genderize(names, simplify = FALSE)

#Inspect the API via the browser:
#https://api.genderize.io/?name=edgar
#My browser returns:

PracticeR::show_script()

#The Github API
#https://api.github.com/search/code?q=
#Which repository
#repo:edgar-treischl/Scripts_PracticeR/
#Which files?
#+extension:R


#Build the link for the API
author <- "edgar-treischl"
repository <- "Scripts_PracticeR"

git_url <- paste0("https://api.github.com/search/code?q=repo:", 
                  author, "/", 
                  repository, "/", 
                  "+extension:R")


#GET a respone from the Github API
response <- httr::GET(git_url)
response

response_parsed <- httr::content(response, as="parsed") 
class(response_parsed)

parsed_tree <- response_parsed$items
df <- dplyr::bind_rows(parsed_tree)
df

git_scripts <- df$name
git_scripts <- stringi::stri_unique(git_scripts)
#query_results <- stringr::str_subset(git_scripts_unique, "R/\\w+\\.R$")
#tidyr::as_tibble(query_results)
git_scripts

#A test run for my_ghscripts
#my_ghscripts("Graphs") |> head()



#Wheater API#######
key <- "Insert a KEY"

#Create url
weather1 <- "http://api.weatherapi.com/v1/current.json?"
place <- "Munich"
weather2 <- "&aqi=no"

#Insert a valid key to scrape the data
weather_url <- paste0(weather1, key, place, weather2)

#Get response 
response <- httr::GET(weather_url)
response_text <- httr::content(response, as="parsed")

#Data preparation
df <- response_text$current
df <- as.data.frame(df)


#Today is 
Sys.Date()
#The temperature (in Celsius)
df$temp_c
#And how is the weather?
df$condition.text



#Combine data#####
library(gapminder)
as_tibble(gapminder)

dplyr::distinct(gapminder, country)
min(dplyr::distinct(gapminder, year))
max(dplyr::distinct(gapminder, year))

df <- tribble(
  ~country, ~outcome, ~measurement,
  "Germany",   "gdp", 3.8,
  "Germany",   "pop", 83.24,
  "UK",   "gdp", 2.7,
  "UK",   "pop", 67.22
)


library(tidyr)

#pivot_wider convert long data into the wide format
df |>
  pivot_wider(names_from = outcome, 
              values_from = measurement)

df <- tribble(
  ~country, ~outcome, ~measurement,
  "Germany",   1, 3.8,
  "Germany",   2, 83.24,
  "UK",   1, 2.7,
  "UK",   2, 67.22
)


df |>
  pivot_wider(
    names_from = "outcome",
    names_prefix = "outcome_",
    values_from = "measurement"
  )

df <- tibble::tribble(
  ~continent, ~country, ~time, ~x , ~y,
  "Europe",    "Austria",     1,  0.65,  0.11, 
  "Europe",    "Austria",     2,  0.12,  0.66,
  "Europe",    "Austria",     3,  0.92,  0.68,
  "Asia",      "Japan",       1,  0.26,  0.69,
  "Asia",      "Japan",       2,  0.07,  0.11,
  "Asia",      "Japan",       3,  0.16,  0.13,
  "Europe",    "UK",          1,  0.78,  0.77,
  "Europe",    "UK",          2,  0.63,  0.98,
  "Europe",    "UK",          4,  0.07,  0.18
  )


df |>
  pivot_wider(
    names_from = time,
    values_from = c(x, y), names_sep = "_"
  )

df |>
  pivot_wider(
    names_from = time,
    values_from = c(x, y), 
    values_fill = 99
  )

df <- tibble::tribble(
  ~continent, ~country, ~x1 , ~x2, ~x3, ~x4, ~x5,
  "Europe",    "Germany", 0.18,  0.61,  0.39, NA, 0.34,
  "Europe",    "UK",      0.81,  0.35,  0.69, 0.22, NA

)

df |>
  pivot_longer(
    cols = c(`x1`, `x2`, `x3`, `x4`, `x5`),
    names_to = "time",
    values_to = "outcome"
  ) |>
  print(n = 6)

#include all countries but -c(continent, country)
df |>
  pivot_longer(-c(continent, country),
    names_to = "time",
    values_to = "outcome"
  ) |>
  print(n = 6)

## #or use a range: x1:x5
df |>
  pivot_longer(x1:x5,
    names_to = "time",
    values_to = "outcome"
  )

df |>
  pivot_longer(
    cols = starts_with("x"),
    names_to = "time",
    names_prefix = "x",
    values_to = "outcome"
  )



#Joins
stars1 <- tribble(
  ~name, ~birth_year,
  "Miley Cyrus", 1992,
  "Ed Sheeran", 1991,
  "Taylor Swift", 1989
)


stars2 <- tribble(
  ~name, ~birth_place,
  "Miley Cyrus", "Nashville, Tennessee",
  "Shawn Mendes", "Toronto"
)

#inner_join
inner_join(stars1, stars2, by = "name")

#full_join
full_join(stars1, stars2, by = "name")

#left_join
left_join(stars1, stars2, by = "name") 

#right_join
right_join(stars1, stars2, by = "name")

#semi_joins checks both data frame 
#and returns observations that are included
#in the first ...
semi_join(stars1, stars2, by = "name")


#or the second data frame
semi_join(stars2, stars1, by = "name")

#anti_join shows you which observations are not listed ..
#in the second one
anti_join(stars1, stars2, by = "name")

df1 <- tribble(
  ~name, ~birthyear,
  "Miley Cyrus", 1992,
  "Ed Sheeran", 1991,
  "Taylor Swift", 1989
)
df2 <- tribble(
  ~name, ~birthyear,
  "Miley Cyrus", 1992,
  "Shawn Mendes", NA
)


#union combines data frame and drops duplicate 
union(df1, df2)

#an intersection reveals duplicate 
intersect(df1, df2)

#set difference reveals unique cases
#in the first
setdiff(df1, df2)


