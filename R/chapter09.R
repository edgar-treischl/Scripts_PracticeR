library(tidyverse)
library(palmerpenguins)
library(gapminder)

source("utils.R")
Sys.setenv(lang = "en_US")
theme_set(theme_minimal()) # sets a default ggplot theme

knitr::opts_chunk$set(
  fig.process = function(filename) {
    new_filename <- stringr::str_remove(string = filename,
                                        pattern = "-1")
    fs::file_move(path = filename, new_path = new_filename)
    ifelse(fs::file_exists(new_filename), new_filename, filename)
  }
)

options(tibble.print_max = 25, tibble.print_min = 5)

knitr::opts_chunk$set(fig.width=6, fig.height=4, fig.path='images/', cache = TRUE,
                      echo=TRUE, warning=FALSE, message=FALSE, eval=TRUE)


#eval = has_bash
has_bash <- Sys.which('bash') != '' && .Platform$OS.type != 'windows'


knitr::include_graphics('images/Fig_0901.png')

#In this chapter, we use the following packages:
library(devtools)
library(gitcreds)
library(gh)
library(PracticeR)
library(usethis)

## #show me the gapminder plot
## gapminder_plot()

knitr::include_graphics('images/Fig_0901a.pdf')

## #source_url runs code from GitHub
## script <- "./raw.GitHubusercontent.com/username/file.R"
## devtools::source_url(script)

## #The titanic-app illustrates how logistic regression work
## shiny::runGitHub("titanic-app",
##           username = "edgar-treischl",
##           ref="main")

#Practice R repository
show_link("pr_github", browse = F)

#Install Git on:
#https://git-scm.com/downloads

## #which git version is running?

## git --version


## #Introduce yourself: name and email

## git config --global user.name "User Name"

## git config --global user.email "email@adress.com"


## #list global settings

## git config --global --list


## #Introduce yourself with use_git_config
## library(usethis)
## use_git_config(user.name = "Jane Doe",
##                user.email = "jane@example.org")

## #Add a new_file

## git add new_file.txt

## #Add commit message

## git commit --message "I finally add new_file"

## #And puuuush....

## git push


knitr::include_graphics('images/Fig_0902.png')

## #The create_GitHub_token opens the following website to create a token:
## #<https://GitHub.com/settings/tokens>
## usethis::create_GitHub_token()

## #Give RStudio your token
## gitcreds::gitcreds_set("insert_token")

gh::gh_whoami()

knitr::include_graphics('images/Fig_0903.png')

knitr::include_graphics('images/Fig_0904.png')

## #Clone a repository

## git clone https://github.com/edgar-treischl/PracticeR.git


knitr::include_graphics('images/Fig_0905.png')

## #Clone a repository from Github
## usethis::create_from_github(
##   "https://github.com/username/repository.git",
##   destdir = "~/local/path/repo/"
## )

knitr::include_graphics('images/Fig_0906.png')

knitr::include_graphics('images/Fig_0907.png')

#GitHub Docs:
#https://docs.github.com/en

## #Get a situation report on your current Git/GitHub status
## usethis::git_sitrep()

## #inspect status or differences

## git status

## git diff


knitr::include_graphics('images/Fig_0908.png')

#Pro Git
show_link("pro-git", browse = F)

Sys.time()
