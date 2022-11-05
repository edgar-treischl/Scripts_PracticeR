#In this chapter, we use the following packages:
library(devtools)
library(gitcreds)
library(gh)
library(PracticeR)
library(usethis)



#source_url runs code from GitHub
# script <- "./raw.GitHubusercontent.com/username/file.R"
# devtools::source_url(script)

#For example, Gapminderplot
# script <- "https://raw.githubusercontent.com/edgar-treischl/Graphs/main/inst/graphs/gapminder.R"
# devtools::source_url(script)
# showplot()

#The titanic-app illustrates how logistic regression work
# shiny::runGitHub("titanic-app",
#           username = "edgar-treischl",
#           ref="main")

#Practice R repository
#show_link("pr_github")

#Install Git on:
#https://git-scm.com/downloads


#which git version is running?
#git --version


#Introduce yourself: name and email
#git config --global user.name "User Name"
#git config --global user.email "email@address.com"


#list global settings
#git config --global --list


#Introduce yourself with use_git_config
# library(usethis)
# use_git_config(user.name = "Jane Doe",
#                user.email = "jane@example.org")


#The next code just illustrates how it works ....
# Add a new_file
# git add new_file.txt

# Add commit message
# git commit --message "I finally add new_file"

# And puuuush....
# git push



#The create_GitHub_token opens the following website to create a token:
#<https://GitHub.com/settings/tokens>
#usethis::create_github_token()

#Give RStudio your token
#gitcreds::gitcreds_set()

#gh::gh_whoami()



#Clone a repository
#git clone https://github.com/edgar-treischl/PracticeR.git

#Clone a repository from Github
# usethis::create_from_github(
#   "https://github.com/username/repository.git",
#   destdir = "~/local/path/repo/"
# )



#GitHub Docs:
#https://docs.github.com/en

#Get a situation report on your current Git/GitHub status
#usethis::git_sitrep()

#inspect status or differences
#git status
#git diff

#Pro Git
#show_link("pro-git")

