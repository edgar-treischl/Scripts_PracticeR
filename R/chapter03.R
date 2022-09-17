#Practice R Chapter 3

#the library and data######
#install packages via: install.packages("name")
#Install and load further packages to explore data
library(tidyverse)
library(correlation)
library(corrplot)
library(GGally)
library(summarytools)
library(DataExplorer)
library(PracticeR)
library(socviz)
library(forcats)
library(effectsize)
library(socviz)
gssm2018 <- socviz::gss_sm



#The first 10 observations of sex
gssm2018$sex[1:10]

fct_count(gssm2018$sex)

#a simple table
table(gssm2018$sex)
#a simple cross table
table(gssm2018$sex, gssm2018$happy)

#A frequency table
freq(gssm2018$sex)

#smoker_count <- table(tobacco$smoker)
count_sex <- fct_count(gssm2018$sex)


barplot(n ~ f, data = count_sex)

barplot(n ~ f, data = count_sex,
        main="Sex",
        xlab="Participants",
        ylab="Count") 



## library(DataExplorer)

plot_bar(gssm2018[7:9])

#class returns the class of an object
class(gssm2018$sex)

#levels returns the levels of a factor variable
levels(gssm2018$sex)

#typeof returns the R storage mode
typeof(gssm2018$sex)

#how to create a factor variable
fruit <- factor(c("pear", "apple", "apple", "cherry", "apple"))
fruit

#show me (unique) levels of the factor variable
levels(fruit)

#how to create a simple rating variable
rating <- factor(c(rep("low", 10), 
                   rep("high", 2), 
                   rep("medium",7)
                   ))
#inspect the order
levels(rating)

#set the levels
rating <- factor(rating, 
                 levels = c("low", "medium", "high"))

levels(rating)

levels(tobacco$gender)

table(tobacco$gender)

#create or adjust the labels
tobacco$gender <- factor(tobacco$gender, 
                         levels = c("F", "M"),
                         labels = c("female", "male"))

table(tobacco$gender)



# Minima
min(c(1, 5, 6, 8, 11))
# Median
median(c(1, 5, 6, 8, 11)) 
# Maxima
max(c(1, 5, 6, 8, 11))
# Standard deviation
sd(c(3, 5, 6, 8, 11))

mean(gssm2018$age)

min(3, 5, 6, 8, NA)

#na.rm removes missing values (NA)
mean(gssm2018$age, na.rm = TRUE)

#summary statistics for one variable
summary(gssm2018$age)

#summary statistics for the entire data
summary(gssm2018)


#fine-grained via quantile
quantile(gssm2018$age, 
         na.rm = TRUE,
         probs = seq(from = 0, to = 1, by = 0.2))

#descr() returns descriptive summary statistics

descr(gssm2018, 
      stats = c("min", "mean", "sd", "max"),
      transpose = TRUE)

#A histogram
hist(gssm2018$age) 

hist(gssm2018$age, 
     main="Density",
     xlab = "Age",
     breaks = 6,
     freq=FALSE) 


plot_histogram(gssm2018)



fct_count(gssm2018$income16)
levels_income16 <- fct_unique(gssm2018$income16)
length(levels_income16)

x <-  factor(c("Female", "Male"))
y <- c(3.11, 2.7)

as.numeric(x)
as.character(y)


gssm2018$income <- as.numeric(gssm2018$income16)


## boxplot
boxplot(gssm2018$income) 

boxplot(income~sex, data=gssm2018, 
        main="BMI by Sex",
        xlab="Sex", 
        ylab="BMI",
        horizontal = FALSE) 

## library(DataExplorer)
## #create_report create a report for a data set
## create_report(penguins,
##               output_file = "my_report.pdf",
##               output_format = "pdf_document")

fct_count(gssm2018$happy)

gssm2018$happy <- fct_collapse(gssm2018$happy, Happy = c("Very Happy", "Pretty Happy"))
fct_count(gssm2018$happy)

#a simple table
table(gssm2018$sex, gssm2018$happy)

#A cross table
ctable(x = gssm2018$sex, 
       y = gssm2018$happy,
       prop = "r")

ctable(x = tobacco$smoker, 
       y = tobacco$diseased,
       prop = "c")


#mosaicplot
spineplot(diseased ~ smoker,
           data = tobacco)


#create a scatter plot
plot(y = gssm2018$income, x = gssm2018$age)
#and a regression line
abline(lm(income ~ age, data = gssm2018), 
       col = "red")


#by default, R returns Pearson's r if you use the `cor()` function
cor_value <- cor(gssm2018$income, gssm2018$age, use = "complete")
cor_value

#the effect size package helps you to interpret r and other indices
interpret_r(cor_value, rules = "cohen1988")



#the correlation function from the correlation package
results <- correlation(mtcars[1:3])
results


#A correlation plot example
corr_matrix <- cor(mtcars)

corrplot(corr_matrix, 
         method = 'color', 
         order = 'AOE',
         type = 'lower',
         tl.col = 'black')


