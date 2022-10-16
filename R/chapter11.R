
library(rvest)

pr_site <- "website_PR.html"
pr_html <- read_html(pr_site)
raw_text <- readRDS(file = "raw_text.rds")
#unemployment <- readRDS(file = "unemployment.rds")

source("utils.R")
Sys.setenv(LANG = "en")


options(tibble.print_max = 25, tibble.print_min = 5)

knitr::opts_chunk$set(fig.width=6, fig.height=4, fig.path='images/', cache = TRUE,
                      echo=TRUE, warning=FALSE, message=FALSE, eval=TRUE)

knitr::opts_chunk$set(
  fig.process = function(filename) {
    new_filename <- stringr::str_remove(string = filename,
                                        pattern = "-1")
    fs::file_move(path = filename, new_path = new_filename)
    ifelse(fs::file_exists(new_filename), new_filename, filename)
  }
)



#Set the engine for chapter 11 #####
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
library(PracticeR)

## # 11.1 PDF Files################################################################

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

#Regular expressions help to extract a string
str_extract(strings, "\\w")
str_extract(strings, "\\d")

#Search for four digits
str_extract(strings, "\\d\\d\\d\\d")

# A + indicate if a character appears one or more times
str_extract(strings, "\\d+")

# A ? matches a character 0 or 1 times
x <- c("Haïti", "Haiti", "Honduras")
str_extract(x, "Ha\\ï?i?ti")


# A * matches a character 0 or more times
x <- c("9", "99", "981")
str_extract(x, "9\\d*")

# A . matches any single character, e.g., to extract the username
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

knitr::include_graphics('images/Fig_1101.png')

#[:alpha:] == letters
str_extract(strings, "[:alpha:]+")
#[:digit:] == digits
str_extract(strings, "[:digit:]+")

#example strings
string <- c("123", "abc", "ABC", ",?()")

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

#Use a quantifier {}: exactly 1 (or n) times
str_extract(strings, "[0-9]{1}")
#1 (n) or more times
str_extract(strings, "[0-9]{1,}")
#Between n (1) and m (2)
str_extract(strings, "[0-9]{1,2}")

#Regex are case sensitive: [A-Z] for upper, [a-z] for lowercase 
str_extract(strings, "[0-9]{1,2} [A-Z][a-z]+")
str_extract(strings, "[:digit:]{1,2} [:upper:][:lower:]+")


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

## ## The `stringr` package########################################################

#str_split_fixed splits the string
dates |> 
  str_split_fixed(pattern = " ", n = 3)

#Example strings
days_str <- c("29", "19")
month_str <- c("May", "August") 
years_str <- c("2000", "1999")

#str_c combines strings (sep adds an string seperator)
str_c(days_str, month_str, years_str, sep = " ")

#Check if the code does what it supposed to do with fruits:
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
str_length(fruits)

#Sort strings
fruits <- c("banana", "apricot", "apple", "pear")
str_sort(fruits, decreasing = FALSE)

## head(PracticeR::unemployment)

#System.file returns the path of system files
oecd_table <- system.file("pdfs", "oecd_table.pdf", package = "PracticeR")

#Read the content of a pdf file via pdf_text
raw_text <- pdftools::pdf_text(oecd_table)

## #str_split splits the raw text after each new line
## text <- str_split(raw_text, "\n")
## text <- as_vector(text)
## head(text)

## #Inspect for irregularities
## text[17:18]

#Replace extra lines and |
text <- str_replace_all(raw_text, pattern = "\\|\n", "")
text <- str_replace_all(text, pattern = "\\|", "")

#Rerun first step
text <- str_split(text, "\n")
text <- as_vector(text)

#str_which returns at which position(s) the string appears
str_which(text, "Australia")
str_which(text, "United States")

start <- str_which(text, "Australia")
end <- str_which(text, "United States")
text_df <- text[start:end]

## #Use the position to extract the data
## start <- str_which(text, "Australia")
## end <- str_which(text, "United States")
## #Slice the data from the start to the end
## text_df <- text[start:end]
## head(text_df)

text_df <- str_replace_all(text_df, ":", "")
text_df <- str_trim(text_df)
text_df <- text_df[text_df != ""]

## #Discard :
## text_df <- str_replace_all(text_df, ":", "")
## #Trim blank spaces
## text_df <- str_trim(text_df)
## #Keep everything that is not (!=) empty
## text_df <- text_df[text_df != ""]
## head(text_df)

#Split vector
text_split <- str_split_fixed(text_df, " {2,}", n = 11)
df <- tibble::as_tibble(text_split)
head(df)

#Create a name vector
colum_names <- c("country", seq(2011, 2020, by = 1))
#For the column names
names(df) <- colum_names
head(df)

#The strings still include footnotes
str_subset(df$`2020`, "e")
#str_remove_all removes characters, here footnote signs
df$`2020`<- str_remove_all(df$`2020`, "[:alpha:]")

#Which country with the highest unemployment rates?
df |>
  select(country, `2020`)|>
  slice_min(order_by = `2020`, n = 5)

#Don't forget that we imported characters from a PDF ...
df$`2020` <- as.numeric(df$`2020`)

df |>
  select(country, `2020`)|>
  slice_min(order_by = `2020`, n = 5)


## # 11.2 Web scraping#############################################################

## #The PR website has a webscraping page:
## show_link("webscraping", browse = FALSE)

knitr::include_graphics('images/Fig_1102.png')

## #Get the website
## library(rvest)
## pr_site <- show_link("webscraping", browse = FALSE)
## 
## #read_html reads the website
## pr_html <- read_html(pr_site)

## #Body node with all children
## pr_html |>
##   html_node("body") |>
##   html_children()

#Extract elements
pr_html |> html_elements("h1")

## pr_html |> html_elements("p")

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
  html_table()|>
  head()

#Get elements with attributes
pr_html |> 
  html_elements("a") |>        
  html_attr("href") |>
  head()

## <!-- All <p> elements get a black text color -->

## <head>

## <link rel="stylesheet" href="CSS_File.css">

## </head>

## <body>

##    <h1>My Blog</h1>

##       <p>This is my first paragraph.</p>

##       <p class="alert">This is an important paragraph.</p>

##       <p id="unique">This is a unique paragraph.</p>

## </body>


## <!-- All <p> elements get a red text color -->

## p {

##   color: red;

## }


## <!-- Elements with the class (.) = "alert" will be red  -->

## .alert {

##   color: red;

## }


## <!-- All p elements with the class (.) = "alert" will be red  -->

## p.alert {

##   color: red;

## }


## <!-- Apply rules uniquely with id attributes:  -->

## #title {

##   color: red;

## }


#Get class via .
pr_html |> html_elements(".table")

#Get id attribute via #
pr_html |> 
  html_elements("#table2") |>
  html_table()

## #The genderize API
## library(DemografixeR)
## names <- c('Edgar', 'James', 'Veronica', 'Marta', 'Fritz')
## genderize(names, simplify = FALSE)

#Inspect the API via the browser:
#https://api.genderize.io/?name=edgar
#My browser returns:

## PracticeR::show_script()

#Inspect the GitHub API
#https://api.github.com/

knitr::include_graphics('images/Fig_1103.png')

gitlink <- "https://api.github.com/search/code?q=repo:"

author <- "edgar-treischl"
repository <- "Scripts_PracticeR"

git_url <- paste0(gitlink, 
                  author, "/", 
                  repository, "/", 
                  "+extension:R")

## #Build the link for the API
## gitlink <- "https://api.github.com/search/code?q=repo:"
## 
## author <- "edgar-treischl"
## repository <- "Scripts_PracticeR"
## 
## git_url <- paste0(gitlink,
##                   author, "/",
##                   repository, "/",
##                   "+extension:R")
## 
## git_url

response <- httr::GET(git_url)

## #GET a response from the Github API
## response <- httr::GET(git_url)
## response

#Parse the content
response_parsed <- httr::content(response, as="parsed") 
class(response_parsed)

#Prepare data
parsed_tree <- response_parsed$items
df <- dplyr::bind_rows(parsed_tree)

## parsed_tree <- response_parsed$items
## df <- dplyr::bind_rows(parsed_tree)
## df

#stringi::stri_unique returns unique strings
git_scripts <- stringi::stri_unique(df$name)
head(git_scripts)

#A test run for my_ghscripts
which_gitscripts("Graphs") |> head()

#The weather API
#https://www.weatherapi.com/

key <- "key=6a6b8919bce04b4e80591026221905&q="

#Create url
weather1 <- "http://api.weatherapi.com/v1/current.json?"
place <- "Munich"
weather2 <- "&aqi=no"

#Insert also a valid key
weather_url <- paste0(weather1, key, place, weather2)

#Get response 
response <- httr::GET(weather_url)
response_text <- httr::content(response, as="parsed")

#Prepare response
df <- response_text$current
df <- as.data.frame(df)


#Today is 
Sys.Date()
#The temperature (in Celsius)
df$temp_c
#And how is the weather?
df$condition.text

## library(dplyr)
## library(gapminder)
## 
## return_gdp <- function(x) {
##   gapminder  |>
##   filter(
##     year == 2007,
##     country == x
##   ) |>
##   summarize(gdp = round(pop * gdpPercap, 2))
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

## # 11.3 Combining data ##########################################################

## #Long and wide###
## long_wide()

knitr::include_graphics('images/Fig_1105.pdf')

library(gapminder)
head(gapminder)

## #how many countries
## country <- dplyr::distinct(gapminder, country)|> pull(country)
## length(country)
## 
## start <- min(dplyr::distinct(gapminder, year))
## start
## end <- max(dplyr::distinct(gapminder, year))
## end

#A data frame (df) to illustrate:
df <- tribble(
  ~country, ~outcome, ~measurement,
  "Germany",   "gdp", 3.8,
  "Germany",   "pop", 83.24,
  "UK",   "gdp", 2.7,
  "UK",   "pop", 67.22
)


#pivot_wider convert long data into the wide format
library(tidyr)

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


#Add names prefix
df |>
  pivot_wider(
    names_from = "outcome",
    names_prefix = "outcome_",
    values_from = "measurement"
  )

df <- tibble::tribble(
  ~continent, ~country, ~time, ~x , ~y,
  "Europe",    "UK",          1,  0.78,  0.77,
  "Europe",    "UK",          2,  0.63,  0.98,
  "Europe",    "UK",          4,  0.07,  0.18,
  "Asia",      "Japan",       1,  0.26,  0.69,
  "Asia",      "Japan",       2,  0.07,  0.11,
  "Asia",      "Japan",       3,  0.16,  0.13
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
  ) |> 
  head()

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

## #rightleft_join()
## mutate_data()

knitr::include_graphics('images/Fig_1106.pdf')

## #rightleft_join()
## mutate_joins1()

knitr::include_graphics('images/Fig_1107.pdf')

## #rightleft_join()
## mutate_joins2()

knitr::include_graphics('images/Fig_1108.pdf')

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
