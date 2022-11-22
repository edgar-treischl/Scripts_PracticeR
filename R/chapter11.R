# 11 Collect data ##############################################################

#Set the engine for chapter 11 #####
library(DemografixeR)
library(dplyr)
library(gapminder)
library(httr)
library(pdftools)
library(purrr)
library(PracticeR)
library(rvest)
library(stringr)
library(stringi)
library(tibble)
library(tidyr)

# 11.1 PDF Files################################################################

#Example strings
library(stringr)
strings <- c("Tom. 2000",
             "Olivia: 99")

#The search pattern
pattern <- "Tom"

#Extract a string
str_extract(strings, pattern)

#Subset a string
str_subset(strings, pattern)

#Extract a string with regular expressions
str_extract(strings, "\\w")
str_extract(strings, "\\d")

#Search for four digits
str_extract(strings, "\\d\\d\\d\\d")

# A + indicate if a character appears one or more times
str_extract(strings, "\\d+")

#Does a character appear? A ? matches a character 0 or 1 times
x <- c("Haïti", "Haiti", "Honduras")
str_extract(x, "Ha\\ï?i?ti")


#How often does it appear? A * matches a character 0 or more times
x <- c("9", "99", "981")
str_extract(x, "9\\d*")

# A . matches any single character, e.g., to extract the usernames
x <- c("edgar-doe@test.com", "jane.doe@test.com")
str_extract(x, "\\w+.\\w+")

#How R handles strings
shoppinglist <- "Cheese,
                 Fish/Chips,
                 Strawberries" 
writeLines(shoppinglist)

shoppinglist <- "Cheese\nFish/Chips\nStrawberries" 
writeLines(shoppinglist)

#Print the strings once more
strings

#Escape to identify strings with a period
str_extract(strings, "\\w+\\.")

#Otherwise, a . is a meta character
str_extract(strings, "\\w+.")

## #The str_view_all fun shows matched strings
## #Use a character class for vocals
## str_view_all(strings, "[aeiou]")



#[:alpha:] == letters
str_extract(strings, "[:alpha:]+")
#[:digit:] == digits
str_extract(strings, "[:digit:]+")

#Example string
string <- c("abc", "ABC", ",?()", "123")

#lowercase
str_extract(string, "[:lower:]+")
#uppercase
str_extract(string, "[:upper:]+")
#punctuation
str_extract(string, "[:punct:]+")
#letters and numbers
str_extract(string, "[:alnum:]+")

strings <- c("Tom is born on 29 May 2000.", 
             "Olivia has her birthday on 19 August 1999.")

#Create a range with -
str_extract(strings, "[0-9]")
str_extract(strings, "[:digit:]")

#Use a quantifier {}: exactly 1 (or n) times
str_extract(strings, "[0-9]{1}")
#1 (n) or more times
str_extract(strings, "[0-9]{1,}")
#Between n (1) and m (2)
str_extract(strings, "[0-9]{1,2}")

#Regex are case sensitive: [A-Z] for upper, [a-z] for lowercase 
str_extract(strings, "[0-9]{1,2} [A-Z][a-z]+")


#Extract and save the dates:
dates <- str_extract(strings, "[0-9]{1,2} [A-Z][a-z]+ [0-9]{2,}")
dates

#Start of a string: ^
str_extract(dates, "^[0-9]+")
#End of a string: $
str_extract(dates, "[0-9]+$")

#Further ado
day <- str_extract(dates, "^[0-9]+")
year <- str_extract(dates, "[0-9]+$")
month <- str_extract(dates, "[A-Z][a-z]+")
name <- str_extract(strings, "^[A-Z][a-z]+")

df <- data.frame(name, day, month, year)
df

## The stringr package##########################################################

#str_split_fixed splits the string
dates |> 
  str_split_fixed(pattern = " ", n = 3)

#Example strings
days_str <- c("29", "19")
month_str <- c("May", "August") 
years_str <- c("2000", "1999")

#str_c combines strings (sep adds an string seperator)
str_c(days_str, month_str, years_str, sep = " ")

#Some fruits?
head(fruit)
#Or sentences: 
head(sentences)

#Example fruits
fruits <- c("apple", "banana", "pear", "pineapple")

#Detect a search pattern
str_detect(fruits, "apple")
#Count how often the search pattern appears
str_count(fruits, "apple")

#Starts the string with a pattern
str_starts(fruits, "apple")
#And at which location
str_locate(fruits, "apple")

#Replace (all) strings
fruits <- c("apple", "banana", "pear", "pineapple")
str_replace(fruits, "a", "8")
str_replace_all(fruits, "a", "8")

#Lengths of strings
fruits <- c("banana", "apricot", "apple", "pear")
str_length(fruits)

#Sort strings
str_sort(fruits, decreasing = FALSE)

#The unemployment data
head(PracticeR::unemployment)

#System.file returns the path of system files
oecd_table <- system.file("pdfs", 
                          "oecd_table.pdf", 
                          package = "PracticeR")

#Read the content of a pdf file via pdf_text
raw_text <- pdftools::pdf_text(oecd_table)

#str_split splits the raw text after each new line
text <- str_split(raw_text, "\n")
text <- as_vector(text)
head(text)



#Inspect for irregularities
text[17:18]



#Replace extra lines and |
text <- str_replace_all(raw_text, pattern = "\\|\n", "")
text <- str_replace_all(text, pattern = "\\|", "")

#Rerun first step
text <- str_split(text, "\n")
text <- as_vector(text)

#str_which returns at which position(s) the string appears
str_which(text, "Australia")
str_which(text, "United States")

#Use the position to extract the data
start <- str_which(text, "Australia")
end <- str_which(text, "United States")
#Slice the data from the start to the end
text_df <- text[start:end]
head(text_df)



#Discard
text_df <- str_replace_all(text_df, ":", "")
#Trim blank spaces
text_df <- str_trim(text_df)
#Keep everything that is not (!=) empty
text_df <- text_df[text_df != ""]
head(text_df)



#Split vector
text_split <- str_split_fixed(text_df, " {2,}", n = 11)
#Create data
df <- tibble::as_tibble(text_split)
head(df)

#Create a vector
colum_names <- c("country", seq(2011, 2020, by = 1))
#For the column names
names(df) <- colum_names
head(df)

#The strings include footnotes
str_subset(df$`2020`, "e")
#str_remove_all removes characters, here footnote signs
df$`2020`<- str_remove_all(df$`2020`, "[:alpha:]")

#Which country has the highest unemployment rates?
df |>
  select(country, `2020`)|>
  slice_min(order_by = `2020`, n = 5)

#Don't forget that we imported characters from a PDF!
df$`2020` <- as.numeric(df$`2020`)

df |>
  select(country, `2020`)|>
  slice_min(order_by = `2020`, n = 5)


#SQL info box #######################
#Establish a connection to the local memory
library(DBI)

con_myDB <- dbConnect(drv = RSQLite::SQLite(), dbname = ":memory:")

#write a table into the database
dbWriteTable(conn = con_myDB, 
             name = "mtcars", 
             value = mtcars)

#list all tables
dbListTables(con_myDB)


#Get SQL Queries
dbGetQuery(con_myDB, 'SELECT mpg FROM mtcars LIMIT 3;')
#Disconnect after the job is finished
dbDisconnect(con_myDB)


# 11.2 Web scraping#############################################################

#The PR website has a web scraping page:
show_link("webscraping", browse = F)
#> [1] "https://edgar-treischl.github.io/PracticeR/articles/web_only/
#> webscraping.html"



#Get the website
library(rvest)
pr_site <- show_link("webscraping", browse = FALSE)

#read_html reads the website
pr_html <- read_html(pr_site)

#Body node with all children
pr_html |> 
  html_node("body") |> 
  html_children()

#Extract elements h1
pr_html |> html_elements("h1")

#Extract elements p
pr_html |> html_elements("p")

#A minimal html website
html <- minimal_html(
"<body>
  <p>A unordered list:<p>
  <ul>
  <li>Tom is 15 years old.</li>
  <li>Pete is 20 years old.</li>
  <li>Ingrid is 21 years old.</li>
  </ul>"
)

#Get elements
html |> 
  html_elements("li")

#Get text
txt <- html |> 
  html_elements("li")|> 
  html_text2()

txt

#Extract names
stringr::str_extract(txt, "[A-Z][a-z]+")
#Extract age
stringr::str_extract(txt, "[0-9]+")

#Get tables
pr_html |> 
  html_element("table") |> 
  html_table()


#Get elements with attributes
pr_html |> 
  html_elements("a") |>        
  html_attr("href") |>
  head()











#Get class via .
pr_html |> html_elements(".table")

#Get id attribute via #
pr_html |> 
  html_elements("#table2") |>
  html_table()





#Inspect the API via the browser:
#https://api.genderize.io/?name=edgar
#My browser returns:

## The httr package ############################################################

PracticeR::show_script()

#Inspect the GitHub API
#https://api.github.com/



gitlink <- "https://api.github.com/search/code?q=repo:"

author <- "edgar-treischl"
repository <- "Scripts_PracticeR"

git_url <- paste0(gitlink, 
                  author, "/", 
                  repository, "/", 
                  "+extension:R")

git_url



#GET a response from the Github API
response <- httr::GET(git_url)
response



#Parse the content
response_parsed <- httr::content(response, as = "parsed") 
class(response_parsed)

#Prepare data
parsed_tree <- response_parsed$items
df <- dplyr::bind_rows(parsed_tree)
df

#stringi::stri_unique returns unique strings
git_scripts <- stringi::stri_unique(df$name)
head(git_scripts)

#Gitfunction
which_gitscripts <- function(repository) {
  author <- "edgar-treischl"
  
  git_url <- paste0("https://api.github.com/search/code?q=repo:", 
                    author, "/", 
                    repository, "/", 
                    "+extension:R")
  
  response <- httr::GET(git_url)
  
  response_parsed <- httr::content(response, as="parsed") 
  
  parsed_tree <- response_parsed$items
  df <- dplyr::bind_rows(parsed_tree)
  
  git_scripts <- df$name
  git_scripts_unique <- stringi::stri_unique(git_scripts)
  git_scripts_unique
  
}


#A test run for which_gitscripts function
which_gitscripts("Graphs") |> head()

#The weather API
#https://www.weatherapi.com/







## #Info box: The plumber package#################################################
## #This code does not work here, create first a new plumber API and insert the
## #following code as a minimal example
## library(dplyr)
## library(gapminder)
## 
## return_gdp <- function(x) {
##   gapminder  |>
##     filter(
##       year == 2007,
##       country == x
##     ) |>
##     summarize(gdp = gdpPercap)
## }
## #Which country?
## return_gdp("Spain")
## 
## library(plumber)
## # A description
## #* @apiTitle Test API
## #* @apiDescription Getting GDP from the Gapminder Data
## #*
## #* Returns most recent GDP for a country
## #* @param country
## #* @post /calculate_gdp
## #Insert FUN here
## #Info box: The plumber package#################################################

# 11.3 Combining data ##########################################################





library(gapminder)
head(gapminder)



#A data frame (df) to illustrate:
df <- tribble(
  ~country, ~outcome, ~measurement,
  "Germany",   "gdp", 3.8,
  "Germany",   "pop", 83.24,
  "UK",   "gdp", 2.7,
  "UK",   "pop", 67.22
)


#pivot_wider converts long data into the wide format
library(tidyr)

df |>
  pivot_wider(names_from = outcome, 
              values_from = measurement)

df <- tribble(
   ~country, ~outcome, ~measurement,
  "Germany",        1,          3.8,
  "Germany",        2,        83.24,
       "UK",        1,          2.7,
       "UK",        2,        67.22
  )



#Add names prefix
df |>
  pivot_wider(
    names_from = "outcome",
    names_prefix = "outcome_",
    values_from = "measurement"
  )

df <- tribble(
  ~continent, ~country, ~time, ~x , ~y,
  "Europe",    "UK",          1,  0.78,  0.77,
  "Europe",    "UK",          2,  0.63,  0.98,
  "Europe",    "UK",          3,  0.07,  0.18,
  "Asia",      "Japan",       1,  0.26,  0.69,
  "Asia",      "Japan",       2,  0.07,  0.11,
  "Asia",      "Japan",       4,  0.16,  0.13
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
  ~continent, ~country, ~x1 , ~x2, ~x3, ~x4, ~x5,
  "Europe",    "Germany", 0.18,  0.61,  0.39, NA, 0.34,
  "Europe",    "UK",      0.81,  0.35,  0.69, 0.22, NA

)

#pivot_longer convert wide data into the long format
df |>
  pivot_longer(
    cols = c(`x1`, `x2`, `x3`, `x4`, `x5`),
    names_to = "time",
    values_to = "outcome"
  )

## #Include all countries but -c(continent, country)
## df |>
##   pivot_longer(-c(continent, country),
##     names_to = "time",
##     values_to = "outcome"
##   ) |>
##   head()

## #Use a running numbers
## df |>
##   pivot_longer(x1:x5,
##     names_to = "time",
##     values_to = "outcome"
##   )

#Starts_with search variables that start with ...
#Adjust prefixes with ...
df |>
  pivot_longer(
    cols = starts_with("x"),
    names_to = "time",
    names_prefix = "x",
    values_to = "outcome"
  ) |> 
  head()













#Two example data sets
df1 <- tribble(
  ~country, ~gdp,
  "Brazil",  1.44,
  "China",  14.72,
  "UK", 2.67,
)


df2 <- tribble(
  ~country, ~pop,
  "Germany", 83.24,
  "Italy", 59.03,
  "UK", 67.22
)


#Inner join
dplyr::inner_join(df1, df2, by = "country")

#Full join
dplyr::full_join(df1, df2, by = "country")

#Left join
dplyr::left_join(df1, df2, by = "country") 

#Right join
dplyr::right_join(df1, df2, by = "country")

#Semi joins
dplyr::semi_join(df1, df2, by = "country")


#Anti join
dplyr::anti_join(df1, df2, by = "country")

#Two example data sets with similar observations
df1 <- tribble(
  ~country, ~gdp,
  "China",  14.72,
  "Germany", 3.85,
  "UK", 2.67,
)


df2 <- tribble(
  ~country, ~gdp,
  "Brazil",  1.44,
  "Germany", 3.85,
  "UK", 2.67,
)

#An union combines data frame and drops duplicates 
dplyr::union(df1, df2)

#An intersection reveals duplicate 
dplyr::intersect(df1, df2)

#Set difference via ...
dplyr::setdiff(df1, df2)

Sys.time()
