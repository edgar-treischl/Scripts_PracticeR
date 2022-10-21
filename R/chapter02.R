

## # 2.1 Introducing R and RStudio ################################################

#Install R:
#https://www.r-project.org/


# Basic operations: +,-,*,/
5 * 5
#Powers
3^2
#Square root
sqrt(16)
#Logarithm (base: Euler's number e)
log(1)
#Exponential function
exp(1)

#Let R talk
print("Hello world")

#Install RStudio (from Posit):
#https://rstudio.com/


#Run code via the shortcut (Windows/Mac):
#Press: <Ctlr/Cmd> + <Enter>


#Do not forget the quotation marks ("" or '') to print a string
print(Hello)

## #The getwd() function returns the current working directory
## getwd()

knitr::include_graphics('images/Fig24.png')

## #Windows
## setwd("C:/Users/edgar/R/Scripts")
## #Mac
## setwd("~/R/Scripts/")

## #Copy and run the following code to generate a bar plot!
barplot(c(a = 22, b = 28, c = 33, d = 40, e = 55))


## #Install a package with install.packages("name")
## #Caution: The package name needs to be enclosed in quotation marks!
## install.packages("palmerpenguins")
## install.packages("tidyverse")
## #>Try URL 'https://cran.rstudio.com/bin/4.0/palmerpenguins_0.1.0.tgz'
## #>Content type 'application/x-gzip' length 3001738 bytes (2.9 MB)
## #>==================================================
## #>downloaded 2.9 MB
##
## #>The downloaded binary packages are in
## #>	/var/folders/0v/T//Rtmp4z29rO/downloaded_packages
##

#Remember: Package need to be installed only once.
#But: Load a package each time you start a new R session!
library(palmerpenguins)

## #The devtools package let you install packages from GitHub
## install.packages("devtools")

## #Install the PracticeR package
## devtools::install_GitHub("edgar-treischl/PracticeR")
##

knitr::include_graphics('images/Fig26.png')

## #Load a chapter script with show_script()
## library(PracticeR)
## show_script("chapter02")

#Show_link opens a browser with the link
library(PracticeR)
show_link("pr_website", browse = FALSE)

## #Ask for help
## ?barplot
## #Search for keywords within the help files
## help.search("keywords")
##

## # 2.2 Base R ###################################################################

#The object result refers to 5*5
result <- 5*5
result

#R does not print the results of the assignment
(result <- "Hello from the other side!")


## #Everything is an object, for example, a bar plot:
## my_plot <- barplot(c(a = 22, b = 28, c = 33, d = 40, e = 55))
##

#ABC of the assignment operator
a <- 5
b <- 6

#The result
result <- a + b
result

#Compare objects:
#Is a greater (>) than (or equal to) b
a >= b

#Is a less (<) than (or equal to) b
a <= b

#Is a equal to (==) b
a == b

#Is a not equal to (!=) b
a != b

# Assign like a Pro, press:
# <Alt> + <-> (Windows)
# <Option> + <-> (Unix/Mac)
# The assignment operator will appear out of nothing

#Keep in mind: No numbers
make.names(names="1.wave")

#No special characters
make.names(names="income_$")

#Try to be specific and provide a descriptive name
make.names(names="an_object_should_describe_its_content")

# RStudio suggests also the input of a function (e.g. object name)
# Give it a try and press <TAB> within the brackets of a function
print("Hello", quote = FALSE)

#Combine function
running_number <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
running_number

#Set a start and endpoint
running_number <- c(1:10)
running_number

#The sequence function
seq(1:10)

#The by option
seq(0, 10, by=2)

#Repeat five times
rep(1:2, times=5)

#Repeat each element five times
rep(1:2, each=5)

## #The basic structure of a non-functioning function:
##
## my_fun <- function(x){
## #  build the sum of x, divided by n
##   }

#1. The input
data <- c(3, 2, 1, 5, 8, 12, 1)

#2. Create a function
return_function<- function(x){
  return(x)
}
#3. Call and feed the function
return_function(data)


#Build the sum
sum(c(1,2,3))

#Count the length
length(c(1,2,3))


#The mean_function
mean_function <- function(data){
  mean <- sum(data)/length(data) #save and create mean
  return(mean)
}

mean_function(data)

#The "real" mean
round(mean(data), digits = 2)

## # 2.3 Data types and structures# ###############################################

#Create two vectors of identical length
x<- c(1, 2, 3, 4)
y<- c("a", "a", "a", "a")

#Combine them as data.frame
df <- data.frame(x, y)
df

#Create a tibble
library(tidyr)
tibble(x = c(1, 2, 3, 4),
       y = c("a", "a", "a", "a"))


#Transposed tibbles
tribble(
  ~sex, ~y, ~birth,
  "Men", 16.2, "1976-10-09",
  "Women", 22.7, "1981-01-06"
)

#Rgh, R recycles vectors
data.frame(a = 1:6, b = 1:3, c = 1:2)

#Tibbles do not recycle vectors, unless ...
tibble(a = 1:6, b = 1:3, c = 1:2)

#A list may combine heterogeneous input
my_list <- list("numbers" = 1:10,
                "letters" = LETTERS[1:3],
                "names" = c("Bruno", "Justin", "Miley", "Ariana") )
my_list

#Example data
df <- tibble::tribble(
  ~names, ~birthyear, ~sex,
  "Bruno", 1985, "male",
  "Justin", 1994, "male",
  "Miley", 1992, "female",
  "Ariana", 1993, "female"
)

#So, how do we slice x?
x <- c("Bruno", "Justin", "Miley", "Ariana")

#The first element
x[1]
#The third element
x[3]
#All elements except the third
x[-3]
#From the second to the third element
x[2:3]
#Get (slice) a column vector with $
df$names

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

#Consider what my_list contains
my_list

#my_list[1] returns the first element (list), not the vector!
my_list[1]


#Returns the values of the first list
my_list[[1]]

#First three elements of the first list
my_list[[1]][1:3]

#You need to take the nested structure of a list into account
my_list[1][1:3]

#Slice/subset of the data
adelie_df <- penguins[penguins$species == "Adelie", ]

#Number of rows
nrow(adelie_df)

#Number of columns
ncol(adelie_df)

## #The dplyr::filter function
## library(dplyr)
## adelie_df <- filter(penguins, species == "Adelie")
##

Sys.time()
