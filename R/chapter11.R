#Source file Practice R: Chapter 11
#Author: Edgar Treischl
#Source file from: GitHub
#Updates: None

# 11 Collect data ##############################################################

#Set the engine for Chapter 11
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

#shoppinglist contains new lines (\n)
shoppinglist <- "Cheese\nFish/Chips\nStrawberries"
writeLines(shoppinglist)

#Print the strings once more
strings

#Escape to identify strings with a period
str_extract(strings, "\\w+\\.")

#Otherwise, a . is a meta character
str_extract(strings, "\\w+.")

#The str_view_all function shows matched strings
#[aeiou] is a character class for lower vocals
#NEW: str_view_all returns strings as HTML or via the console
str_view_all(strings, "[aeiou]")
str_view_all(strings, "[aeiou]", html = TRUE)





#[:alpha:] == letters
str_extract(strings, "[:alpha:]+")
#[:digit:] == digits
str_extract(strings, "[:digit:]+")

#Example string
string <- c("abc", "ABC", "123", ",?()")

#Lowercase
str_extract(string, "[:lower:]+")
#Uppercase
str_extract(string, "[:upper:]+")
#Letters and numbers
str_extract(string, "[:alnum:]+")
#Punctuation
str_extract(string, "[:punct:]+")


strings <- c("Tom is born on 29 May 2000.",
             "Olivia has her birthday on 19 August 1999.")

#Create a range with -
str_extract(strings, "[0-9]")
#Or use character classes
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

#str_c combines strings (sep adds a string separator)
str_c(days_str, month_str, years_str, sep = " ")

#Some fruits?
head(fruit)
#Or sentences:
head(sentences)

#Example fruits
fruits <- c("apple", "banana", "pear", "pineapple")

#Detect a search pattern
str_detect(fruits, "apple")
#How often appears the search pattern
str_count(fruits, "apple")

#Strings that start with a pattern
str_starts(fruits, "apple")
#And at which location
str_locate(fruits, "apple")

#Replace (all) strings
fruits <- c("banana", "apricot", "apple", "pear")
str_replace(fruits, "a", "8")
str_replace_all(fruits, "a", "8")

#Lengths of strings
str_length(fruits)

#Sort strings
str_sort(fruits, decreasing = FALSE)

#The unemployment data
head(PracticeR::unemployment)

#system.file returns the path of system files
oecd_table <- system.file("files", "oecd_table.pdf",
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



#Discard colons
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

#The strings include footnotes, for example:
str_subset(df$`2020`, "e")
#Remove footnote signs
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



# 11.2 Web scraping#############################################################

#The PR website has a web scraping page:
#show_link("webscraping", browse = FALSE)



#SQL info box #######################

#An example data preparation step
mtcars |>
  group_by(am) |>
  summarise(mpg = mean(mpg, na.rm = TRUE))

#Establish a connection
library(DBI)
con <- dbConnect(RSQLite::SQLite(), dbname = ":memory:")
dbWriteTable(con, "mtcars", mtcars)
mtcars_sql <- tbl(con, "mtcars")

#Save the data preparation steps as an object
library(dbplyr)
data_prep <- mtcars_sql |>
  group_by(am) |>
  summarise(mpg = mean(mpg, na.rm = TRUE))
#Inspect the SQL query for the last data preparation step
data_prep |> show_query()



#Get the website address
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


#The rvest website
#https://rvest.tidyverse.org/

# 11.3 Combining data ##########################################################

# Inspect the API via the browser:
# https://api.genderize.io/?name=edgar
# My browser returns:
#{"name":"edgar","gender":"male","probability":0.99,"count":16632}


#show_script knows which scripts are available
#PracticeR::show_script()

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



#GET a response from the GitHub API
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
git_scripts <- df$name |>
  stringi::stri_unique() |>
  stringr::str_sort()

head(git_scripts)

#Create your own wrapper function

which_gitscripts <- function(repository) {
  #Make URL
  author <- "edgar-treischl"
  git_url <- paste0("https://api.github.com/search/code?q=repo:",
                    author, "/",
                    repository, "/",
                    "+extension:R")

  #Get response
  response <- httr::GET(git_url)
  response_parsed <- httr::content(response, as="parsed")
  parsed_tree <- response_parsed$items

  #Prepare response
  df <- dplyr::bind_rows(parsed_tree)
  git_scripts <- df$name
  git_scripts_unique <- stringi::stri_unique(git_scripts)
  listed_script <- stringr::str_sort(git_scripts_unique)
  return(listed_script)
}


#A test run
which_gitscripts("penguins_report") |> head()

#The weather API
#https://www.weatherapi.com/



## #Info box: The plumber package#################################################
#This code does not work here, create first a new plumber API and insert the
#following code as a minimal example
# library(dplyr)
# library(gapminder)

# return_gdp <- function(x) {
#   gapminder  |>
#     filter(
#       year == 2007,
#       country == x
#     ) |>
#     summarize(gdp = gdpPercap)
# }

#Which country?
#return_gdp("Spain")

#library(plumber)
# A description
#* @apiTitle Test API
#* @apiDescription Getting GDP from the Gapminder Data
#*
#* Returns most recent GDP for a country
#* @param country
#* @post /calculate_gdp
#Insert FUN here



#Inspect the stringr website
#https://stringr.tidyverse.org/
