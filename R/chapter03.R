#Source file Practice R: Chapter 3
#Author: Edgar Treischl
#Source file from: GitHub
#Updates: None

# 3 Data exploration ###########################################################

#Setup of chapter 3
#Remember you can install packages via: install.packages("name")
library(correlation)
library(corrplot)
library(DataExplorer)
library(effectsize)
library(forcats)
library(PracticeR)
library(summarytools)
library(tibble)

# 3.1 Categorical variables ####################################################

#Take a glimpse at your data frame!
df <- PracticeR::gss5
glimpse(df)

#Inspect the structure of a variable with $
str(df$sex)

#head shows the first 6 rows of the data as default
head(df, n = 3)

#View the data set
#View(gss5)

#The first five observations of sex
df$sex[1:5]

#A simple table
table(df$sex)

#A frequency table
library(summarytools)
freq(df$sex)

#Count sex
count_sex <- table(df$sex)

#Left bar plot
barplot(count_sex)

#Right bar plot
barplot(count_sex,
        main="Sex",
        ylab="Count")



#Plot several bar graphs
library(DataExplorer)
plot_bar(df)

#Inspect the levels of a factor variable
levels(df$sex)

#typeof returns the storage mode
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

# 3.2 Continuous variables #####################################################

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

#The descr() function returns descriptive summary statistics
library(summarytools)
descr(df,
      stats = c("min", "mean", "sd", "max"))

#Left histogram
hist(df$age)

#Right histogram
hist(df$age,
     breaks = 6,
     freq=FALSE,
     main="Density",
     xlab = "Age")



#Plot several histograms
DataExplorer::plot_histogram(df)


#Left box plot
boxplot(df$income,
        horizontal = TRUE)

#Right box plot
boxplot(income~sex,
        data=df)




#Create a data report
# library(DataExplorer)
# create_report(insert_data,
#               output_file = "my_report.pdf",
#               output_format = "pdf_document")

# Infobox: The ggblanket package ###############################################
library(ggplot2)
library(ggblanket)

#Left plot
gg_bar(df, x = sex)

#Right plot
gg_histogram(df, x = age)

#What does ggblanket return?
my_plot <- gg_bar(df, x = sex)
class(my_plot)



# 3.3 Explore effects ##########################################################

#The levels of happy
levels(df$happy)

#Collapse levels of a factor variable with fct_collapse
x <- c("Pretty Happy", "Not happy", "Very Happy")

forcats::fct_collapse(x,
                      Happy = c("Pretty Happy", "Very Happy")
                      )

#A simple table
table(df$sex, df$happy)

#A cross table
summarytools::ctable(x = df$sex,
                     y = df$happy,
                     prop = "r")

#Boxes are proportional to the number of observations
spineplot(happy ~ sex,
          data = df)

#Create a scatter plot (with filled circles and without a frame)
plot(y = df$income, x = df$age,
     pch = 20, frame = FALSE)
#And a red regression line
abline(lm(income ~ age, data = df),
       col = "red")


#By default, the cor function returns Pearson's r
cor_value <- cor(df$income, df$age, use = "complete")
cor_value

#The effect size package interprets r
library(effectsize)
interpret_r(cor_value, rules = "cohen1988")

#Estimate several correlation coefficients on the fly
library(correlation)
correlation(mtcars[1:3])

#Left plot: A correlation plot example
library(corrplot)
corr_matrix <- cor(mtcars)
corrplot(corr_matrix)


#Estimate p-values
p_values <- cor.mtest(mtcars, conf.level = 0.95)

#Right plot
corrplot(corr_matrix,
         order = 'AOE',
         p.mat = p_values$p,
         type = 'lower',
         diag=FALSE)

## # Info box: The rpivotTable package ###############################################
# library(palmerpenguins)
# library(rpivotTable)
# rpivotTable(penguins)
