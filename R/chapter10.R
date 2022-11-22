params <-
list(data = "penguins", species = "Adelie", x = "flipper_length_mm", 
    y = "body_mass_g", z = "bill_length_mm", year = 2007L)

# 10. Automate work ############################################################

## #Get the link to the repository
## 
## penguins_report <- PracticeR::show_link("penguins_report",
##                                         browse = F)
## 
## #Clone the Github repository of this chapter:
## usethis::create_from_github(penguins_report,
##   destdir = "~/path/to/the/local/repository/"
## )

#Setup of chapter 10 #####
library(beepr)
library(blastula)
library(correlation)
library(dplyr)
library(effectsize)
library(flextable)
library(ggplot2)
library(glue)
library(here)
library(palmerpenguins)
library(purrr)
library(PracticeR)
library(report)
library(tibble)
library(tidyr)

# 10.1 Reports #################################################################

#How many distinct years has the penguins data? 
dplyr::distinct(penguins, year)

## #An example scatter plot
## penguins |>
##   filter(year == 2007) |> #here comes the filter...
##   ggplot(aes(bill_length_mm , body_mass_g, color = species))+
##   geom_point()+
##   ggtitle("2007")

## #Your R Script needs some params to illustrate (or create a Rmd):
## params <- list(data = "penguins", species = "Adelie", x = "flipper_length_mm",
##                y = "body_mass_g", z = "bill_length_mm", year = 2007L)

#The default value of params$year is:
params$year

#Insert a parameter to filter the data
penguins |> 
  filter(year == params$year) |> #insert the params
  ggplot(aes(bill_length_mm, body_mass_g, color = species))+
  geom_point()+
  ggtitle(params$year)


#Create data with params
df <- penguins |>
  filter(year ==  params$year)|> # here comes the params
  group_by(species)|>
  drop_na()|>
  summarise(`body mass` = round(mean(body_mass_g), 1)
            )

#A table
df |> 
  flextable()







#Get returns the values of the object 
df <- get(params$data)
glimpse(df)

## #Keep in mind what a param returns
## class(params$x)
## #> [1] "character"
## 
## #The cor function needs a numerical input
## cor(params$x, params$y)
## #> Error in cor(params$x, params$y) : 'x' must be numeric

## #The correlation function let us select variable as strings
## cor_xy <- penguins |>
##   correlation(select = params$x, select2 = params$y)
## 
## cor_xy
## 
## #> # Correlation Matrix (pearson-method)
## #>
## #> Parameter1        |  Parameter2 |    r |       95% CI | t(340) |         p
## #> --------------------------------------------------------------------------
## #> flipper_length_mm | body_mass_g | 0.87 | [0.84, 0.89] |  32.72 | < .001***
## #>
## #> p-value adjustment method: Holm (1979)
## #> Observations: 342

#Insert params via the aes_string function
ggplot(penguins, aes_string(x = params$x, 
                            y = params$y)) +
  geom_point()


#The as.formula function understands the input as a formula 
f <- as.formula(
  paste(params$y, 
        paste(c(params$x, params$z), collapse = " + "), 
        sep = " ~ "))
print(f)


#Run the model with params
model <- lm(f, data = penguins)
model



## params:

##   data: penguins

##   year:

##     label: "Year"

##     value: 2007

##     input: select

##     choices: [2007, 2008, 2009]


## #rmarkdown::render knits/renders the document
## rmarkdown::render("template.Rmd",
##                   params = list(year = 2007)
##                   )

## #The clean and output_file option
## rmarkdown::render("my_template.Rmd",
##                   clean = TRUE,
##                   output_file = "report",
##                   params = list(year = 2007)
##                   )

#Create a vector with unique years
years <- distinct(penguins, year)|>
  pull(year)

years

#The paste function pastes strings together with
report_names <- paste0(years, "_report.pdf")
report_names

## #Give the output_file a unique label for each document
##   rmarkdown::render('template.Rmd',
##     output_file = paste0(year, '_report.pdf'),
##     clean = TRUE,
##     params = list(year = year)
##   )

## #Create a function to render the report
## render_report <- function(year) {
##   rmarkdown::render('template.Rmd',
##     output_file = paste0(year, '_report.pdf'),
##     clean = TRUE,
##     params = list(year = year)
##   )
## 
## }
## 

## #here() helps you to find files
## here::here()
## #> [1] "/Users/edgar/Practice R/Chapters/10_Automation"

## #create relative file paths
## here("report_files")
## #> [1] "/Users/edgar/Practice R/Chapters/10_Automation/report_files"

## #Render the document for each continent
## render_report <- function(year) {
##   setwd(here("Rmds")) #here is the template
##   rmarkdown::render(
##     'template.Rmd',
##     output_file = paste0(year, '_report.pdf'),
##     output_dir = here::here("report_files"), #here will be the result
##     clean = TRUE,
##     params = list(year = year)
##   )
## }

#For loops: Loop through a task
for(i in 1:5) {
  print(i)
}

## #Apply render_report for each year
## for(year in years) {
##   render_report(year)
## }

## #The beepr package informs you if the job is done:
## for(year in years) {
##   render_report(year)
## };beepr::beep("ping") #pinnnng ;)
## 

# 10.2 Text ####################################################################

#Calculate the number for params$species: Adelie
param_specie <- "Adelie"
number <- penguins |>
  filter(species == param_specie)|>
  summarise(number = n())|>
  pull(number)

number

#Glue them together
glue::glue("- We observed {param_specie} {number} times.")



#Glue them together with chunk-option: results='asis'
glue("- We observed {param_specie} {number} times.")

#Describe the data
report::report(penguins)|> 
  summary()

#Create a small data frame
df <- data.frame(
  "Age" = c(22, 23, 54, 21, 8, 42),
  "Sex" = c("F", "F", "M", "M", "M", "F"),
  "Education" =  c("Bachelor", "PhD", "Highschool",
                   "Highschool", "Bachelor", "Bachelor")
)

#Describe the participants
report_participants(df, age = "Age", 
                    sex = "Sex",
                    education = "Education")







#Calculate the correlation between param X and Y
x <- "flipper_length_mm"
y <- "body_mass_g"

corr_estimate <- penguins |>
  correlation(select = x, 
              select2 = y)

corr_estimate$r


#The interpret_r function interprets the effect
effect <- interpret_r(corr_estimate$r, rules = "cohen1988")
effect

#Round() the calculation for the text
r_xy <- round(corr_estimate$r, 2)

#Glue() them together
cor_sentence <- glue("There is a {effect} effect between {x} and {y}.
                     (r = {r_xy}).")

cor_sentence

#Check if effect is positive/negative
effect_direction <- "positive"

if (r_xy < 0) {
    effect_direction <- "negative"
} 


#Bring all steps together:
report_correlation <- function(data, x, y) {
  
  corr_estimate <- data |>
    correlation(select = x, select2 = y)
  r_xy <- interpret_r(corr_estimate$r)
  r_round <- round(corr_estimate$r, 2)
  
  effect_direction <- "positive"
  
  if (r_round < 0) {
    effect_direction <- "negative"
  } 

  
  cor_sentence <- glue("There is a {r_xy} {effect_direction} effect between 
                       {x} and {y} (r = {r_round}).")
  cor_sentence
  
}

#Does the function work?
report_correlation(data = iris, 
                   x = "Sepal.Length", 
                   y = "Sepal.Width")

#t-statistic
corr_estimate$t
#confidence intervals: CI_low and CI_high
corr_estimate$CI_low
#number of observations
corr_estimate$n_Obs

#An example model
model <- lm(body_mass_g ~ flipper_length_mm, data = penguins)

#What kind of model do we have?
report_model(model)

#What about the performance?
report_performance(model)

#Report package returns reports for several procedures
#t-test:
penguins_tt <- t.test(penguins$body_mass_g ~ penguins$sex)
report(penguins_tt)

# 10.3 Emails ##################################################################

#Create/Compose a (first) mail
email <- blastula::compose_email(
  body = "Hello,
  I just wanted to give you an update of our work.
  Cheers, Edgar")

email



## #For a gmail user only
## #create_smtp_creds_key creates a system key-value
## 
## create_smtp_creds_key(
##   id = "gmail",
##   user = "user_name@gmail.com",
##   provider = "gmail"
## )

## #Create smtp credentials file
## create_smtp_creds_file(
##   file = "my_mail_creds",
##   user = "user_name@gmail.com",
##   host = "smtp.gmail.com",
##   port = 465,
##   use_ssl = TRUE
## )

## #Send the email with smtp_send
## email |>
##   smtp_send(
##     to = "john.doe@test.com",
##     from = "edgar.doe@test.com",
##     subject = "Update on X",
##     credentials = creds_file("my_mail_creds")
##   )

#Create any plot, for example:
plot <- penguins |> 
  ggplot(aes(bill_length_mm , body_mass_g))+
  geom_point()

#Create a plot for the mail
mail_plot <- blastula::add_ggplot(plot_object = plot)

#Who gets the email
recipient <- "Mr. Smith"

#The improved email:
body_text <-
  md(glue(
    "
## Dear {recipient},

I just wanted to send you an update of my work, see the corresponding
graph (and file in the attachment).

{mail_plot}

Best regards,
Edgar
"    
  ))

#Compose the email again
email <- compose_email(body = body_text)
email



## #add_attachment before the file is send
## email |>
##   add_attachment(file = "report.pdf") |> ## add attachment
##   smtp_send(
##     to = "jane.doe@test.com",
##     from = "edgar.doe@test.com",
##     subject = "Update on X",
##     credentials = creds_file("mail_creds")
##   )

## #Make a function
## send_mails <- function(mail, report) {
##   email |>
##     add_attachment(file = report) |>
##     smtp_send(
##       to = mail,
##       from = "edgar.doe@test.com",
##       subject = paste0("Update on ", report),
##       credentials = creds_file("mail_creds")
##     )
## }

#Example data
df <- tibble::tribble(
                    ~emails,          ~report,
     "oliver.brown@aol.com", "2007_report.pdf",
      "emma.davies@aol.com", "2008_report.pdf",
  "elizabeth.jones@aol.com", "2009_report.pdf"
  )



#list.files list all files of a directory
#insert a path on your computer
list.files(
  path="~/Documents/GitHub/penguins_report/report_files", 
  pattern=".pdf", 
  full.names=FALSE)

#A for loop is getting complicated ...
for (row in 1:nrow(df)) {
  name <- df$emails[row]
  report_name <- df$report[row]
  report <- paste("Send", report_name, "to:", name)
  print(report)
}


#Estimate a model for male (penguins)
male_penguins <- penguins %>% 
  filter(sex == "male") %>% 
  lm(body_mass_g ~ bill_length_mm, data = .)

#Apply a map function to apply a function for each input 
penguins %>% 
  split(.$sex) %>% 
  map(~ lm(body_mass_g ~ bill_length_mm, data = .))

#Use the pipe and the map function 
#Here: run a model, apply a summary, and get R² for each model
penguins %>% 
  split(.$sex) %>% 
  map(~ lm(body_mass_g ~ bill_length_mm, data = .)) %>% 
  map(summary) %>% 
  map_dbl("r.squared")

## #map2 takes two inputs and applies a function
## map2(mail_adresses, reports, send_mails)

#Visit the purrr website
#https://purrr.tidyverse.org/

# 10 Summary ###################################################################

## #R for Data Science
## show_link("r4ds")
## #Hands-On Programming
## show_link("hands_on_R")
