#Clone the Github repository of this chaper:
#https://github.com/edgar-treischl/penguins_report.git


#setup of chapter XX
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
library(report)
library(tidyr)

#how many distinct years has the penguins data? 
dplyr::distinct(penguins, year)

## #An example scatter plot
penguins %>%
  filter(year == 2007) %>% #here comes the filter...
  ggplot(aes(bill_length_mm , body_mass_g, color = species))+
  geom_point()+
  ggtitle("2007")

#The default value of params$continent is:
#params$year <- "2007"
#This is not working, Bert ;)

#IMPORTANT##################
#Create a data frame with the paramter to inspect the code
params <- data.frame(data = "penguins",
                     year = "2007",
                     x = "bill_length_mm",
                     y = "body_mass_g")
params$year
#IMPORTANT##################


#We can use params to filter the data
penguins %>% 
  filter(year == params$year) %>% #insert the params
  ggplot(aes(bill_length_mm, body_mass_g, color = species))+
  geom_point()+
  ggtitle(params$year)


penguins


## #create data with params
df <- penguins %>%
  filter(year ==  params$year)%>%
  group_by(species)%>%
  drop_na()%>%
  summarise(`body mass` = round(mean(body_mass_g), 1)
            )



#create table
df %>%
  flextable()

df <- penguins %>%
  filter(year ==  params$year)%>%
  group_by(species)%>%
  drop_na()%>%
  summarise(`body mass` = round(mean(body_mass_g), 1)
            )

df %>% 
  flextable()%>%
  colformat_num(big.mark="", decimal.mark = "." )

#highlight value if x > threshold
threshold <- 5000L

#Do some fancy stuff here...
df %>% flextable()%>%
colformat_num(big.mark="", decimal.mark = "." )%>%
  highlight(i = ~ `body mass`  > threshold, 
            color = "yellow", 
            j = c("species"))

#get returns the values of the object 
df <- get(params$data)
head(df)

#Keep in mind what a param returns
class(params$x)

#cor needs a numerical input
#cor(params$x, params$y)

#correlation let us select variable as strings 
cor_xy <- penguins %>% 
  correlation(select = params$x, select2 = params$y)

cor_xy

#insert params via the aes_string function
ggplot(penguins, aes_string(x = params$x,
                            y = params$y)) +
  geom_point()


#as.formula understands the input as a formula 
f <- as.formula(
  paste(params$y, 
        paste(c(params$x, params$z), collapse = " + "), 
        sep = " ~ "))
print(f)


#run the model with params
model <- lm(f, data = penguins)
model

## #rmarkdown::render knits/renders the document
## rmarkdown::render("template.Rmd",
##                   params = list(year = 2009)
##                   )

## #The clean and output_file option
## rmarkdown::render("my_template.Rmd",
##                   clean = TRUE,
##                   output_file = "report",
##                   params = list(year = 2009)
##                   )

#Create a vector with unique years
years <- distinct(penguins, year)%>%
  pull(year)
years

#The paste function pastes strings together with
report_names <- paste0(years, "_report.pdf")
report_names

# #Give the output_file a unique label for each document
#   rmarkdown::render('template.Rmd',
#     output_file = paste0(year, '_report.pdf'),
#     clean = TRUE,
#     params = list(year = year)
#   )

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

#here() helps you to find files
here::here()

#create relative file paths
here("report_files")


#Render the document for each continent
# render_report <- function(year) {
#   setwd(here("Rmds"))
#   rmarkdown::render(
#     'template.Rmd',
#     output_file = paste0(year, '_report.pdf'),
#     output_dir = here::here("report_files"),
#     clean = TRUE,
#     params = list(year = year)
#   )
# }

# #Let's try not repeat ourselves (too much) ...
# render_report(2007)
# render_report(2008)
# render_report(2009)

#For loops: Loop through a task
for(i in 1:5) {
  print(i)
}

#Apply render_report for each year
for(year in years) {
  render_report(year)
}

## #beepr plays a sound if the job is done, for example:
## for(year in years) {
##   render_report(year)
## };beepr::beep("ping") #pinnnng
## 

#list.files list all files of a directory
# reports <- list.files(path="~/Documents/GitHub/penguins_report/report_files", 
#                       pattern=".pdf", full.names=FALSE)
# 
# reports

#calculate the number for params$species: Adelie
param_specie <- "Adelie"
number <- penguins %>%
  filter(species == param_specie)%>%
  summarise(number = n())%>%
  pull(number)

number

#Glue the text, the param, and the number together
glue::glue("- We observed {param_specie} {number} times.")

#To include a sentence in the document, add results ='asis' as a chunk-option:
glue("- We observed {param_specie} {number} times.")

#Tell us about the data
report::report(penguins)%>% 
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



#And calculate the correlation between X and Y
corr_estimate <- penguins %>%
  correlation(select = "flipper_length_mm", select2 = "body_mass_g")

corr_estimate


#interpret_r interprets Pearson's r
corr_interpret <- interpret_r(corr_estimate$r, rules = "cohen1988")
corr_interpret

#Let us assign variable names to objects
x <- "flipper length"
y <- "body mass"

#round the calculation for the text
cor_value <- round(corr_estimate$r, 2)
#glue them together
cor_sentence <- glue(
  "There is a {corr_interpret} effect between {x} and {y} (r = {cor_value})."
  )

cor_sentence

#check if effect is positive/negative
effect_direction <- "positive"

if (cor_value < 0) {
    effect_direction <- "negative"
} 

effect_direction

#bring the last steps all together within a function
report_correlation <- function(data, x, y) {
  
  corr_estimate <- data %>%
    correlation(select = x, select2 = y)
  corr_interpret <- interpret_r(corr_estimate$r)
  cor_value <- round(corr_estimate$r, 2)
  
  effect_direction <- "positive"
  
  if (cor_value < 0) {
    effect_direction <- "negative"
  } 

  
  cor_sentence <- glue("There is a {corr_interpret} {effect_direction} effect 
                 between {x} and {y} (r = {cor_value}).")
  cor_sentence
}

#does the function work?
report_correlation(data = iris, 
                   x = "Sepal.Length", 
                   y = "Sepal.Width")

#t-statistic
corr_estimate$t
#confidence intervals
corr_estimate$CI_low
corr_estimate$CI_high
#number of observations
corr_estimate$n_Obs

#an example linear model
model <- lm(body_mass_g ~ flipper_length_mm, data = penguins)

#What kind of model do we have?
report_model(model)

#What about the performance of the model?
report_performance(model)




#report gives us reports for several statistical procedures
penguins <- penguins %>% 
  drop_na(sex)

report(t.test(penguins$body_mass_g ~ penguins$sex))

#Create/Compose a (first) mail
email <- blastula::compose_email(
  body = "Hello,
  I just wanted to give you an update of our work.
  Cheers, Edgar")

email


## # create_smtp_creds_key creates a system key-value for a gmail account
## # system's key-value store with
## # `provider = "gmail"`
## create_smtp_creds_key(
##   id = "gmail",
##   user = "user_name@gmail.com",
##   provider = "gmail"
## )

## #Create smtp credentials file
## create_smtp_creds_file(
##   file = "gmail_creds",
##   user = "user_name@gmail.com",
##   host = "smtp.gmail.com",
##   port = 465,
##   use_ssl = TRUE
## )

## #Send the email with smtp_send, but insert a real mail address
## email %>%
##   smtp_send(
##     to = "john.doe@test.com",
##     from = "edgar.joe@test.com",
##     subject = "Update on project X",
##     credentials = creds_file("mail_creds")
##   )

## ## The email message was sent successfully.

#create a plot
plot <- penguins %>% 
  ggplot(aes(bill_length_mm , body_mass_g))+
  geom_point()

#create a plot for the mail
mail_plot <- blastula::add_ggplot(plot_object = plot)
class(mail_plot)

#An improved mail example:
recipient <- "Mr. Smith"

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

#Compose the mail again
email <- compose_email(body = body_text)
email


## #add_attachment before the file is send/before smtp_send
## email %>%
##   add_attachment(file = "report.pdf") %>% ## add attachment
##   smtp_send(
##     to = "john.doe@test.com",
##     from = "edgar.joe@test.com",
##     subject = "Update on project X",
##     credentials = creds_file("mail_creds")
##   )

## #Make a function
## send_mails <- function(mail, report) {
##   email %>%
##     add_attachment(file = report) %>%
##     smtp_send(
##       to = mail,
##       from = "edgar@edgar-treischl.de",
##       subject = paste0("Update on ", report),
##       credentials = creds_file("mail_creds")
##     )
## }

## #To send mails
## send_mails("user@provider.com", "report.pdf")

emails <- c("oliver.brown@aol.com" , "emma.davies@aol.com","elizabeth.jones@aol.com")
report <- c("2007_report.pdf", "2008_report.pdf", "2009_report.pdf")

df <- data.frame(emails, report)
df


#list.files list all files of a directory
# report <- list.files(path="~/Documents/GitHub/penguins_report/report_files", 
#                       pattern=".pdf", full.names=FALSE)



#for loop are getting quickly complicated ...
for (row in 1:nrow(df)) {
  name <- df$emails[row]
  report_name <- df$report[row]
  report <- paste("Send", report_name, "to:", name)
  print(report)
}


#estimate a model for mail (penguins)
penguins %>%
  filter(sex == "male") %>%
  lm(body_mass_g ~ bill_length_mm, data = .)
  

#apply a map function to apply a function for each input 
penguins %>%
  split(.$sex) %>%
  map(~ lm(body_mass_g ~ bill_length_mm, data = .))

#use the pipe and the map function 
#here we run a model, apply a summary and get R² for each input
penguins %>%
  split(.$sex) %>%
  map(~ lm(body_mass_g ~ bill_length_mm, data = .)) %>%
  map(summary) %>%
  map_dbl("r.squared")

#map2 takes two inputs and applies the send_mails function
#map2(emails, report, send_mails)

