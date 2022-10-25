#Setup of Chapter 3 #####
#Remember you can install packages via: install.packages("name")
library(correlation)
library(corrplot)
library(DataExplorer)
library(effectsize)
library(forcats)
library(PracticeR)
library(summarytools)
library(tibble)



## #Take a glimpse at your data frame!
df <- PracticeR::gssm5
glimpse(df)

#Use $ for column vectors
str(df$sex)

#head shows the first 6 rows of the data as default
head(df)

#Last n elements
tail(df, n = 3)

#View the entire data set
#tibble::view(gssm5)

## # 3.1 Categorical variables ####################################################

#The first five observations of sex
df$sex[1:5]

#A simple table
table(df$sex)

#A frequency table
freq(df$sex)

#Count sex
count_sex <- table(df$sex)
#Left plot
barplot(count_sex)

#Right plot
#The bar plot with title and label adjustments
barplot(count_sex,
        main="Sex",
        ylab="Count")



#Plot several bar graphs
plot_bar(df)


## ggblanket################
library(ggplot2)
library(ggblanket)

#Left plot
gg_bar(df, x = sex)

#Right plot
gg_histogram(df, x = age)

#What does ggblanket return?
my_plot <- gg_bar(df, x = sex)
class(my_plot)
## ggblanket################


#Levels returns the levels of a factor variable
levels(df$sex)

#Typeof returns the R storage mode
typeof(df$sex)

#Create an example factor variable
fruit <- factor(c("pear", "apple", "apple", "cherry", "apple"))
fruit

#Create a rating variable
rating <- factor(c(rep("low", 10),
                   rep("high", 2),
                   rep("medium",7)
                   ))
#Inspect the order
levels(rating)

#Set the levels
rating <- factor(rating,
                 levels = c("low", "medium", "high"))

levels(rating)

#A messy factor variable
sex <- factor(c(rep("F", 10),
                rep("M",7)
                   ))
#A messy table
table(sex)

#Create or adjust the labels
sex <- factor(sex,
              levels = c("F", "M"),
              labels = c("female", "male"))

table(sex)

## # 3.2 Continuous variables #####################################################

#Minima
min(c(1, 5, 6, 8, 11))
#Median
median(c(1, 5, 6, 8, 11))
#Maxima
max(c(1, 5, 6, 8, 11))
#Standard deviation
sd(c(1, 5, 6, 8, 11))

#Mean age
mean(df$age)

#Missing values
min(3, 5, 6, 8, NA)

#The na.rm argument removes missing values
mean(df$age, na.rm = TRUE)

#Summary statistics of one variable
summary(df$age)

#Summary statistics of the first four variables
summary(df[1:4])


#FEHLER? Sprachlich ändern?
#The descr() function returns descriptive summary statistics
descr(gssm2016,
      stats = c("min", "mean", "sd", "max"),
      transpose = TRUE)



#Left plot
hist(df$age)

#Right plot
hist(df$age,
     breaks = 6,
     freq=FALSE,
     main="Density",
     xlab = "Age")


#Plot several histograms
DataExplorer::plot_histogram(df)


#Toy variable
x <-  factor(c("Female", "Male"))
y <- c(3.11, 2.7)

as.numeric(x)
as.character(y)

#Income as numeric
df$income <- as.numeric(gssm5$income16)

#Left plot
boxplot(df$income,
        horizontal = TRUE)

#Right plot
boxplot(income~sex,
        data=df)



#Create a data report
# library(DataExplorer)
# create_report(data,
#               output_file = "my_report.pdf",
#               output_format = "pdf_document")

## # 3.3 Explore effects ##########################################################

##FEHLER? Sprachlich ändern?
#DELETE HERE or Rewrite
levels(gssm2016$happy)

#Collapse level of a factor variable with fct_collapse
x<- forcats::fct_collapse(gssm2016$happy,
                               Happy = c("Pretty Happy", "Very Happy"))
levels(x)
##FEHLER? Sprachlich ändern?



#A simple table
table(df$sex, df$happy)

#A cross table
summarytools::ctable(x = df$sex,
                     y = df$happy,
                     prop = "r")

#Boxes are proportional to the number of observations
spineplot(happy ~ sex,
          data = df)

df$income16

#Create a scatter plot
plot(y = df$income, x = df$age,
     pch = 20, frame = FALSE)
#And a regression line
abline(lm(income ~ age, data = df),
       col = "red")


#By default, R returns Pearson's r if you use the `cor()` function
cor_value <- cor(df$income, df$age, use = "complete")
cor_value

#The effect size package interprets r
interpret_r(cor_value, rules = "cohen1988")

#The correlation function from the correlation package
results <- correlation(mtcars[1:5])
results

#A correlation plot example

corr_matrix <- cor(mtcars)

#Left plot
corrplot(corr_matrix)
##
##
## #Right plot
## #Estimate p-values
p_values <- cor.mtest(mtcars, conf.level = 0.95)
#Corrplot
corrplot(corr_matrix,
         p.mat = p_values$p,
         order = 'AOE',
         type = 'lower',
         diag=FALSE,
         addCoef.col ='black', number.cex = 0.8, tl.col = 'black')



