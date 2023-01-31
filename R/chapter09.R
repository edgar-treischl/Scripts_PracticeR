#Source file Practice R: Chapter 9
#Author: Edgar Treischl
#Source file from: GitHub
#Updates: None

# 9. GitHub ####################################################################

#Chapter 9 needs the following packages:
library(devtools)
library(gitcreds)
library(gh)
library(PracticeR)
library(usethis)

# 9.1 The Git(Hub) basics ######################################################

#source_url runs code from GitHub
#script <- "./raw.githubusercontent.com/username/file.R"
#devtools::source_url(script)

#Inspect a GitHub repository. For example:
#show_link("pr_github")

# 9.2 Install Git ##############################################################

#Create a GitHub account
#https://github.com/

#Install Git on:
#https://git-scm.com/downloads


#Introduce yourself with R
# library(usethis)
# use_git_config(user.name = "Jane Doe",
#                user.email = "jane@example.org")





# 9.3 GitHub and RStudio #######################################################

#Go to the GitHub website to create a token:
#https://github.com/settings/tokens
#usethis::create_github_token()

#Give RStudio your token
#gitcreds::gitcreds_set()

#Check who you are
#gh::gh_whoami()



#Clone a repository with R
# usethis::create_from_github(
#   "https://github.com/username/repository.git",
#   destdir = "~/local/path/repo/"
# )



#GitHub Docs:
#https://docs.github.com/en

#Get a situation report on your current Git/GitHub status
#usethis::git_sitrep()


#Summary########################################################################

#Pro Git
#show_link("pro-git")
