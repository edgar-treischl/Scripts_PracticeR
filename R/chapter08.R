#Source file Practice R: Chapter 8
#Author: Edgar Treischl
#Source file from: GitHub
#Updates: None

# 8. Communicate research findings #############################################

#The Setup for Chapter 8
library(dplyr)
library(flextable)
library(HoRM)
library(huxtable)
library(jtools)
library(PracticeR)
library(stargazer)
library(summarytools)
library(tibble)

# 8.1 The basics of rmarkdown ##################################################

# 8.2 Create a document ########################################################


#The rmarkdown website
#https://rmarkdown.rstudio.com/

#Install a latex distribution
#tinytex::install_tinytex()

#Example setup
# knitr::opts_chunk$set(eval=TRUE,
#                       echo=FALSE,
#                       warning=FALSE,
#                       message=FALSE
#                       )


#Improved example setup
# knitr::opts_chunk$set(
#   #further options ...
#   fig.width=7,
#   fig.height=5,
#   fig.path='images/'
# )

#opts_chunk$get() returns chunk options and defaults
str(knitr::opts_chunk$get())

# 8.3 Create a template ########################################################

library(HoRM)
library(dplyr)
data("JamesBond")

#Select variables from JamesBond
bond_data <- select(JamesBond,
                    Movie, Bond, Conquests, Martinis,
                    Killings = "Kills_Bond",
                    Rating = "Avg_User_IMDB")


#Group by each Bond, give me the mean of each variable
bond_data |>
  group_by(Bond) |>
  summarise(across(where(is.numeric), ~ round(mean(.x), 2)))

#Stargazer returns a table for summary statistics
library(stargazer)
stargazer(bond_data, type="text")

#Some options to improve the table
# stargazer(bond_data, type="latex",
#           digits = 2,
#           title = "Summary statistics",
#           summary.stat =  c("sd", "min", "max", "n"))



#Calculate summary stats
library(summarytools)
table <- descr(bond_data,
               stats = c("n.valid", "min", "mean", "max", "sd"),
               transpose = TRUE)

table <- as.data.frame(table)
table

#Round results and add rowname to the data
table <- table |>
  round(digits = 2) |>
  tibble::rownames_to_column(var = "Variable")

table

#Make a flextable
table |>
  flextable::flextable()



#Two example models
m1 <- lm(Rating ~ Conquests, data=bond_data)
m2 <- lm(Rating ~ Conquests + Martinis, data=bond_data)

#Show my models via huxreg()
library(huxtable)
huxreg(m1, m2, error_pos = "right")



#create a list with models and labels
modelfits <- list("Model 1" = m1,
                  "Model 2" = m2)

#The improved table (see Tab. 8.4):
huxreg(modelfits,
       omit_coefs = "(Intercept)",
       statistics = c(`Number of observations` = "nobs", `R²` = "r.squared"),
       number_format = 2,
       note = "Note: Some important notes.")



#The huxreg vignette shows more options how to adjust the table
#vignette("huxreg", package = "huxtable")

#Export, for example as .html, .pptx, or Word (docx) file:
#flextable::save_as_docx(table, path = "./table.docx")

#Use source to run an R script in the background
#source("regression_results.R")



#Use report_latex_dependencies to inspect the LaTeX packages
#huxtable::report_latex_dependencies()
#The install_latex_dependencies function installs them via R
#huxtable::install_latex_dependencies()

# Summary ######################################################################

#The bookdown website:
#show_link("bookdown_website")

#Bookdown
#show_link("bookdown")

#R Markdown Cookbook:
#show_link("rmarkdown_cookbook")

