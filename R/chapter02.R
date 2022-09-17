#PracticeR Chapter 2

#library#######
library(tidyverse)
library(palmerpenguins)



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


#Pro Tip:
#Run code via the shortcut:
#Press <Ctlr/Cmd> + <Enter>

#Do not forget the quotation marks ("" or '') to print a string
print(Hello)

#getwd() returns the current working directory
getwd()


## #Windows
## setwd("C:/Users/edgar/R/Scripts")
## #Mac
## setwd("~/R/Scripts/")

## #Copy and run the following code to generate a bar plot!
barplot(c(a = 22, b = 28, c = 33, d = 40, e = 55))


## #Ask for help
?barplot
## #Search for keywords within the help files
#help.search("keywords")
## 

#The object results refers to 5*5
results <- 5*5
results

#R does not print the results of the assignment
(results <- "Hello!")


## #Everything is an object, for example, the bar plot from the beginning:
#my_plot <- barplot(c(a = 22, b = 28, c = 33, d = 40, e = 55))
## 

#ABC of the assignment operator
a <- 5
b <- 6
c <- a + b
c

# Assign like a Pro, press: 
# <Alt> + <-> (Windows)
# <Option> + <-> (Unix/Mac)
# The assignment operator will appear out of nothing.

# R Studio suggests also the input of a function 
# Give it a try and press <TAB> within the brackets of a function

#Combine function
running_number <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
running_number

#Set a start and endpoint
running_number <- c(1:10) 
running_number

#The sequence function
seq(1:10)
seq(0, 10, by=2)

df <- data.frame(
  id = seq(1:4),
  group = c(
    "red", "red",
    "blue", "blue"
  ),
  group_number = rep(1:2, each = 2)
)

df

#The repetition function
rep(1:2, each=5)
rep(1:2, times=5)

#Function

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

#The "real" mean function
round(mean(c(3, 2, 1, 5, 8, 12, 1)), 
      digits = 2)


#Load the packages
#take a glimpse at your data!
glimpse(penguins)

## str(penguins)

#head shows the first 6 rows of the data as default
head(penguins)

head(penguins$species)

#last n elements
tail(penguins$species, n = 3)

## #View the entire data set
## tibble::view(penguins)

#Create some vectors
x<- c(1, 2, 3, 4)
y<- c("a", "a", "a", "a")

#Combine vectors with the data.frame function
df <- data.frame(x, y)
df

#is_tibble checks if an object is a tibble
library(tidyr)
is_tibble(penguins)

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
#First, we may create a vector with $
x <- df$names
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

#my_list[1] returns the first element (list)
#the first element of a list is not a vector!
my_list[1]


#Returns the values of the first list
my_list[[1]]

#First three element of the first list
my_list[[1]][1:3]

#You must take the nested structure of a list into account
my_list[1][1:3]

gentoo_df <- penguins[penguins$species == "Adelie", 1:4]
gentoo_df
nrow(gentoo_df)

ncol(gentoo_df)

gentoo_df <- subset(penguins, species == "Adelie")


library(dplyr)
filter(penguins, species == "Gentoo")

