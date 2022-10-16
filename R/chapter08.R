library(flextable)
set_flextable_defaults(fonts_ignore=TRUE)

#library(showtext)
#font_add("DGMetaScience", #"C:/Users/gu99mywo/AppData/Local/Microsoft/Windows/Fonts/DGMetaScience-Regular.otf") 
#showtext_auto()
#set_flextable_defaults(font.family = "DGMetaScience")


#options(max.print = 100)
options(tibble.print_max = 25, tibble.print_min = 5)



knitr::opts_chunk$set(
  fig.process = function(filename) {
    new_filename <- stringr::str_remove(string = filename,
                                        pattern = "-1")
    fs::file_move(path = filename, new_path = new_filename)
    ifelse(fs::file_exists(new_filename), new_filename, filename)
  }
)

knitr::opts_chunk$set(
  fig.width = 6, fig.height = 4, fig.path = "images/", cache = TRUE,
  echo = TRUE, warning = FALSE, message = FALSE, eval = TRUE
)

ggplot2::theme_set(ggplot2::theme_minimal()) # sets a default ggplot theme

library(huxtable)
options(huxtable.knit_print_df = FALSE)

#data###
source("regression_results.R")

cat(htmltools::includeText("inline.Rmd"))

#The Setup for Chapter 8 #####
library(stargazer)
library(huxtable)
library(HoRM)
library(jtools)
library(flextable)
library(summarytools)

## # 8.1 The basics of rmarkdown ##################################################

knitr::include_graphics('images/fig_81.png')

knitr::include_graphics('images/fig_82.png')

knitr::include_graphics('images/fig_83.png')

cat(htmltools::includeText("chunk0.Rmd"))

cat(htmltools::includeText("chunk.Rmd"))

cat(htmltools::includeText("setup2.Rmd"))

## #the setup chunk: all code will be printed by default
## knitr::opts_chunk$set(echo = TRUE)

## # 8.2 Create a document ########################################################


knitr::include_graphics('images/fig_84.png')


knitr::include_graphics('images/fig_85.png')

#The rmarkdown website
#https://rmarkdown.rstudio.com/

## #Install a latex distribution to create pdf files!
## tinytex::install_tinytex()

cat(htmltools::includeText("setup.Rmd"))

## knitr::opts_chunk$set(eval=TRUE,
##                       echo=FALSE,
##                       warning=FALSE,
##                       message=FALSE
##                       )
## 

## knitr::opts_chunk$set(eval=TRUE, echo=FALSE,warning=FALSE, message=FALSE,
##                       fig.width=7,
##                       fig.height=5,
##                       fig.path='images/'
##                       )
## 

## #Use source to run R script in the background
## source("regression_results.R")

#Show the regression_plot to visualize the main results
regression_plot

## # 8.3 Create a template ########################################################

#Sys.Date() returns the date
Sys.Date()

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

#Show my models, but as text
library(stargazer)
stargazer(bond_data, type="text")

## #Add flextable() to get an flextable
## library(flextable)
## bond_data |>
##   group_by(Bond) |>
##   summarise(across(where(is.numeric), ~ round(mean(.x), 2)))|>
##   flextable()

#DEL ##
library(flextable)
bond_data |> 
  group_by(Bond) |> 
  summarise(across(where(is.numeric), ~ round(mean(.x), 2)))|> 
  flextable()|> 
  fontsize(size = 10, part = "all")
#DEL ##

library(summarytools)

#Calculate summary stats
table <- descr(bond_data, 
               stats = c("n.valid", "min", "mean", "max", "sd"),
               transpose = TRUE)

table <- as.data.frame(table)
table

## #Round results and add rowname to the data
## table <- table |>
##   round(digits = 2) |>
##   tibble::rownames_to_column(var = "Variable")
## 
## #Make a flextable
## table |>
##   flextable() |>
##   autofit()
## 

#DEL#####
table <- table |> 
  round(digits = 2) |> 
  tibble::rownames_to_column(var = "Variable")

table |> 
  flextable() |>
  autofit()|> 
  fontsize(size = 10, part = "all")|> 
  fit_to_width(max_width = 6, unit = "in")
#DEL#####

#Two example analysis
m1 <- lm(Rating ~ Conquests, data=bond_data)
m2 <- lm(Rating ~ Conquests + Martinis, data=bond_data)

#Show my models via huxreg()
library(huxtable)
huxreg(m1, m2, error_pos = "right")

#create a list with models and labels
modelfits <- list("Model 1" = m1, 
                  "Model 2" = m2)

#The improved table:
huxreg(modelfits,
       omit_coefs = "(Intercept)",
       statistics = c(`Number of observations` = "nobs", 
                      `R²` = "r.squared"),
       number_format = 2,
       note = "Note: Some important notes.")

## #The huxreg vignette shows more options how to adjust the table
## vignette("huxreg", package = "huxtable")

## #Use report_latex_dependencies to inspect the LaTeX packages
## huxtable::report_latex_dependencies()
## #The install_latex_dependencies function install them via R
## huxtable::install_latex_dependencies()

## #Export, for example as .html, .pptx, or Word (docx) file:
## flextable::save_as_docx(table, path = "./table.docx")

## #The bookdown website:
## show_link("bookdown_website")
## 
## #Bookdown
## show_link("bookdown")
## 
## #R Markdown Cookbook:
## show_link("rmarkdown_cookbook")
## 

Sys.time()
