#Source file Practice R: Chapter 2
#Author: Edgar Treischl
#Source file from: GitHub
#Updates: None

## # 2.1 Introducing R and RStudio ################################################

#Download and install R:
#https://www.r-project.org/

# Basic operations: +,-,*,/
5 * 5
#Powers
3^2
#Square root
sqrt(16)
#Natural logarithm
log(1)
#Exponential function
exp(1)

#Let R talk
print("Hello world")

#Install RStudio (from Posit):
#https://posit.co/downloads/


#Run code via the shortcut (Windows/Mac):
#Press: <Ctlr/Cmd> + <Enter>


#Do not forget the quotation marks ("" or '') to print a string
#print(Hello)

#The getwd() function returns the current working directory
getwd()



#Windows
#setwd("C:/Users/Edgar/R/Scripts")
#Mac
#setwd("~/R/Scripts/")

#Copy and run the following code to generate a bar plot!
barplot(c(a = 22, b = 28, c = 33, d = 40, e = 55))



#Install a package with:
#install.packages("package_name")
#Caution: The package name needs to be enclosed in quotation marks



#Packages need to be installed only once
#But: Load a package each time you start a new R session!
library(palmerpenguins)



#The devtools package let you install packages from GitHub
#install.packages("devtools")

#Install the PracticeR package
#devtools::install_github("edgar-treischl/PracticeR")




#Load a chapter script with show_script()
#library(PracticeR)
#show_script("chapter02")

#Show_link opens a browser with the link
show_link("pr_website", browse = FALSE)

#Run examples from the online help (press ESC to abort)
example(barplot)

#Ask for help
?barplot
#Search for keywords
#help.search("keyword")

# Infobox: Vignettes and Rstudio’s Addins ######################################
#Browse vignettes from a package:
browseVignettes("dplyr")
#Inspect a vignette in the viewer by calling its name:
vignette("dplyr")
#Edit the code from a vignette:
edit(vignette("dplyr"))


# 2.2 Base R ###################################################################

#The object result refers to 5*5
result <- 5 * 5
result

#R does not print the result of the assignment
(result <- "Hello from the other side!")


#AB(C) of the assignment operator
a <- 5
b <- 6

#The result
result <- a + b
result

#Compare objects:
#Is a less (<) than (or equal to =) b
a <= b

#Is a greater (>) than (or equal to =) b
a >= b

#Is a equal to (==) b
a == b

#Is a not equal to (!=) b
a != b

#Assign like a Pro, press:
#<Alt> + <-> (Windows)
#<Option> + <-> (Unix/Mac)
#The assignment operator will appear out of nothing

#No numbers
make.names(names="1.wave")

#No special characters as names
make.names(names="income_$")

#Even if a name is valid, try to provide a descriptive, short name
make.names(names="an_object_should_describe_its_content")

#RStudio suggests also the input of a function (e.g. object name)
my_string <- "Hello"
print(my_string, quote = FALSE)

#Combine function
running_number <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
running_number

#Set a start and endpoint
running_number <- c(1:10)
running_number

#The sequence function
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
return_input<- function(x){
  return(x)
}
#3. Call and feed the function
return_input(data)


#Build the sum
sum(c(1,2,3))

#The length
length(c(1,2,3))

#The mean_function
mean_function <- function(data){
  mean <- sum(data)/length(data) #save and create mean
  return(mean)
}

mean_function(data)

#The "real" mean
round(mean(data), digits = 2)

# 2.3 Data types and structures ###############################################

#Inspect the class of vector x
x <- "Hello world"
class(x)

x <- c(TRUE, FALSE)
class(x)

#Create two vectors of identical length
sex <- c("Men", "Women")
age <- c(19, 28)

#Combine them as data.frame
df <- data.frame(sex, age)
df

#Create a tibble
library(tidyr)
tibble(sex = c("Men", "Women"),
       age = c(19, 28)
       )


#Transposed tibbles
tribble(
  ~sex, ~age,
  "Men", 19,
  "Women", 28
)

#R recycles vectors
data.frame(a = 1:6, b = 1:3, c = 1:2)

#A tibble does not recycle vectors, unless ...
tibble(a = 1:6, b = 1:3, c = 1:2)

#A list may combine heterogeneous input
my_list <- list("numbers" = 1:10,
                "letters" = letters[1:3],
                "names" = c("Bruno", "Justin", "Miley", "Ariana") )
my_list

#How do we slice a vector?
x <- c("Bruno", "Justin", "Miley", "Ariana")

#The first element
x[1]
#The third element
x[3]
#All elements except the third
x[-3]
#From the second to the third element
x[2:3]

#Example data
df <- tibble::tribble(
    ~names, ~year,     ~sex,
   "Bruno",  1985,   "male",
  "Justin",  1994,   "male",
   "Miley",  1992, "female",
  "Ariana",  1993, "female"
)


#The first row and the first column
df[1, 1]

#The first row
df[1, ]

#The first column
df[ , 1]

#Start and endpoint
df[1:2, ]
#All elements except the first row
df[-1, ]

#Get (slice) a column vector with $
df$names

#Consider what my_list contains
my_list

#my_list[1] returns the first element (list), not the vector!
my_list[1]


#Get the values of the first list
my_list[[1]]

#First three elements of the first list
my_list[[1]][1:3]

#You need to take the nested structure of a list into account
my_list[1][1:3]

#Slice/subset of the data
adelie_data <- penguins[penguins$species == "Adelie", ]

#Number of rows
nrow(adelie_data)

#Number of columns
ncol(adelie_data)

#The dplyr::filter function
#library(dplyr)
#adelie_data <- filter(penguins, species == "Adelie")

