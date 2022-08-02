#Chapter 8
library(HoRM)
library(dplyr)
data("JamesBond")

#Select variables from JamesBond (and give the nicer name)
bond_data <- select(JamesBond, 
                  movie = "Movie", 
                  bond = "Bond", 
                  conquests = "Conquests", 
                  martinis = "Martinis",
                  killings = "Kills_Bond", 
                  rating = "Avg_User_IMDB") 


#Group by each Bond, give me the mean of each variable 
bond_data |> 
  group_by(bond) |> 
  summarise(across(where(is.numeric), ~ round(mean(.x), 2)))

library(stargazer)

#show my models, but as text with stargazer
stargazer(bond_data, type="text")

library(flextable)

#add flextable() to get an flextable
bond_data |> 
  group_by(bond) |> 
  summarise(across(where(is.numeric), ~ round(mean(.x), 2)))|> 
  flextable()|> 
  fontsize(size = 10, part = "all")

#add a theme and use autofit for the same flextable
bond_data |> 
  group_by(bond) |> 
  summarise(across(where(is.numeric), ~ round(mean(.x),2)))|> 
  flextable()|> 
  theme_vanilla()|> 
  autofit()|> 
  fontsize(size = 10, part = "all")

library(summarytools)
library(tidyverse)

#calculate summary stats
table <- descr(bond_data, 
               stats = c("n.valid", "min", "mean", "max", "sd"),
               transpose = TRUE)

table <- as.data.frame(table)
table

#round results and add rowname to the data
table <- table |> 
  round(digits = 2) |> 
  tibble::rownames_to_column(var = "Variable")

#Make a flextable
table |> 
  flextable() |>
  autofit()|> 
  fontsize(size = 10, part = "all")


library(huxtable)

#Two example analysis
m1 <- lm(rating ~ conquests, data=bond_data)
m2 <- lm(rating ~ conquests + martinis + 
           killings , data=bond_data)

#Show my models via huxreg()
huxreg(m1, m2)

#create a list with models and labels
modelfits <- list("Model 1" = m1, 
                  "Model 2" = m2)

#The improved table:
huxreg(modelfits,
       omit_coefs = "(Intercept)",
       statistics = c(`Number of observations` = "nobs", 
                      `R-squared` = "r.squared"),
       number_format = 2,
       note = "Note: Some important notes.") |> 
  as_flextable()|> 
  fontsize(size = 10, part = "all")

## #the huxreg vignette shows more options how to adjust the table
## vignette("huxreg", package = "huxtable")

## #use the report_latex_dependencies to inspect the LaTex packages
## huxtable::report_latex_dependencies()
## #install_latex_dependencies installs them from R
## huxtable::install_latex_dependencies()

## #Export via flextable::saves_as_
## save_as_docx(table, path = "./table.docx")
## save_as_pptx(table, path = "./table.pptx")
## save_as_html(table, path = "./table.html")


