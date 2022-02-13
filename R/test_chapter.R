library(tidyverse)
library(palmerpenguins)


knitr::opts_chunk$set(echo = FALSE)

#options(max.print = 100)
options(tibble.print_max = 25, tibble.print_min = 5)

#knitr::opts_chunk$set(echo = FALSE)


knitr::opts_chunk$set(
  fig.process = function(filename) {
    new_filename <- stringr::str_remove(
      string = filename,
      pattern = "-1"
    )
    fs::file_move(path = filename, new_path = new_filename)
    ifelse(fs::file_exists(new_filename), new_filename, filename)
  }
)

knitr::opts_chunk$set(
  fig.width = 6,
  fig.height = 4,
  fig.path = "images/",
  cache = TRUE,
  echo = TRUE,
  warning = FALSE,
  message = FALSE,
  eval = TRUE
)

theme_set(theme_minimal()) # sets a default ggplot theme

#data###

knitr::opts_chunk$set(tidy = "styler")

#english environment
Sys.setenv(LANG = "en")


knitr::include_graphics('images/Fig21.png')

#Use R as a calculator!
# Apply basic operations: +,-,*,/ 
5 * 188 
#Powers
3^2              
#Square root
sqrt(16)
#Logarithm (base: Euler's number e)
log(1)
#Logarithm (base: 10)
log10(10)
#Exponential function
exp(1)

#Let R talk
print("Hello world")

knitr::include_graphics('images/Fig22.png')

#Press Ctlr + Enter on windows or Cmd + Enter on a mac to run code

knitr::include_graphics('images/Fig23.png')

#Do not forget the quotation marks ("" or '') to print the string!
print(Hello)

#getwd() returns the current working directory
getwd()

knitr::include_graphics('images/Fig24.png')

## #Windows
## setwd("C:/Users/edgar/R/Scripts")
## #Mac
## setwd("~/R/Scripts/")

## #Copy and run the following code to generate a bar plot!
## barplot(c(a = 22, b = 28, c = 33, d = 40, e = 55))

knitr::include_graphics('images/Fig25.png')

## #Install a package with install.packages("name")
## #Caution: The package name needs to be enclosed in quotation marks
## install.packages("palmerpenguins")
## install.packages("tidyverse")
## 
## 
## #>Try URL 'https://cran.rstudio.com/bin/4.0/palmerpenguins_0.1.0.tgz'
## #>Content type 'application/x-gzip' length 3001738 bytes (2.9 MB)
## #>==================================================
## #>downloaded 2.9 MB
## 
## #>The downloaded binary packages are in
## #>	/var/folders/0v/T//Rtmp4z29rO/downloaded_packages
## 

#Load the package
library(palmerpenguins)

## install.packages("devtools")

## library(devtools)
## install_github("edgar-treischl/PracticeR")

## #Load the library first
## library(PracticeR)
## #Load the tutorial
## practice("preview")

knitr::include_graphics('images/Fig26.png')

## #Ask for help
## ?barplot
## #Search for keywords within the help files
## help.search("keywords")
## 

## library(copycat)
## copycat_code("pivot_longer")

knitr::include_graphics('images/copycat_sticker.png')
knitr::include_graphics('images/pr_sticker.png')

#The object a refers now to 5
a <- 5
a

#R does not print the results of the assignment
(a <- "Hello!")


## #Everything is an object, for example, the bar plot from the beginning:
## g1 <- barplot(c(a = 22, b = 28, c = 33, d = 40, e = 55))
## 

#ABC of the assignment operator
a <- 5
b <- 6
c <- a + b
c

#Compare objects: 
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


#######################################################
# Assign like a pro, press: 
# <Alt> + <->
# The assignment operator will appear out of nothing.
#######################################################

#List objects of the environment
ls()

# Rstudio suggests also the input of a function 
# Give it a try and press TAB within the brackets of a function

#Combine function
running_number <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
running_number

#Set a start and endpoint
running_number <- c(1:10) 
running_number

#The sequence function
seq(1:10)
seq(1,10, by=2)

df <- data.frame(
  id = seq(1:4),
  group = c(
    "Group Reds", "Group Reds",
    "Group Blues", "Group Blues"
  ),
  group_number = rep(1:2, each = 2)
)
df

#The repetition function
rep(1:2, each=5)
rep(1:2, times=5)

## #The basic structure of a non-functioning ;) function:
## function(x){
## #  build the sum of x and divided by n
##   }

#1. Save the input
x <- c(3, 2, 1, 5, 8, 12, 1)

#2. Generate and save function
return_function<- function(x){
  return(x)
}
#3. Call and feed the function with the input
return_function(x)


#The sum function:
sum(c(3,2,1))
#The length function:
length(c(3,2,1))


#The mean function
mean_function <- function(data){
  mean <- sum(data)/length(data) #save and create mean
  return(mean)
}

data <- c(3, 2, 1, 5, 8, 12, 1)
mean_function(data)

#The real mean function
round(mean(c(3, 2, 1, 5, 8, 12, 1)), 
      digits = 2)

x <- c(3.21, 7.21, 4.8, "3.88")
mean(x)

#The class() function tells you the type of an object
#here it reveals that x is not numeric, but ...
class(x)

#And how to fix it
x <- c(3.21, 7.21, 4.8, 3.88)
class(x)
#The typeof function tells you the storage mode of an object
typeof(x)

## #This code does not work, but shows how data can be imported
## dataset <- read_my_data(path_to_file)

#Create some vectors
x<- c(1, 2, 3, 4)
y<- c("a", "a", "a", "a")

#Combine vectors with the data.frame function
df <- data.frame(x, y)
df

#Create a tibble
tibble(x = c(1, 2, 3, 4), 
       y = c("a", "a", "a", "a"))


#Transposed tibbles
tribble(
  ~sex, ~y, ~birth,
  "Men", 16.2, "1976-10-09",
  "Women", 22.7, "1981-01-06"
)

#Recycling vectors
data.frame(a = 1:6, b = 1:2, c = 1)

#Tibbles do not recycle vectors, unless ...
tibble(a = 1:6, b = 1:2, c = 1)

#lists combine heterogeneous output in one object
my_list <- list("numbers" = 1:10, 
              "letters" = LETTERS[1:3], 
              "names" = c("John", "Paul", "George", "Ringo") )
my_list

df <- data.frame(names = c("Bruno", "Justin", "Miley", "Ariana"),
                 x = seq(1:4), 
                 sex = rep(c("male", "female"), each = 2))
df

#So, how do we slice a vector?
x<- df$names
x

#The third element
x[3]
#The same works with $
df$names[3]
#All elements except the third element
x[-3]
#From the second to the third element
x[2:3]

#The first row
df[1, ]

#The first row and the first column
df[1, 1]
#The first column
df[ , 1]

#Start and endpoint
df[1:2, ]
#All elements except the first row
df[-1, ]

#my_list[1] returns the list, the first element of the list and not the vector!
my_list[1]


#Returns the values of the first list
my_list[[1]]

#First three element of the first list
my_list[[1]][1:3]

#You must take the nested structure of a list into account
my_list[1][1:3]

penguins

library(palmerpenguins)
gentoo_df <- penguins[penguins$species == "Adelie", 1:4]
gentoo_df
nrow(gentoo_df)

ncol(gentoo_df)

gentoo_df <- subset(penguins, species == "Adelie")


library(dplyr)
filter(penguins, species == "Gentoo")

