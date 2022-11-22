# 9. GitHub ####################################################################



#In this chapter, we use the following packages:
library(devtools)
library(gitcreds)
library(gh)
library(PracticeR)
library(usethis)

# 9.1 The Git(Hub) basics ######################################################





## #source_url runs code from GitHub
## script <- "./raw.githubusercontent.com/username/file.R"
## devtools::source_url(script)

## #The titanic-app illustrates how logistic regression work
## shiny::runGitHub("titanic-app",
##           username = "edgar-treischl",
##           ref="main")

## #Practice R repository
## show_link("pr_github")

# 9.2 Install Git ##############################################################

#Install Git on:
#https://git-scm.com/downloads







## #Introduce yourself with use_git_config
## library(usethis)
## use_git_config(user.name = "Jane Doe",
##                user.email = "jane@example.org")





# 9.3 GitHub and RStudio #######################################################

## #The create_github_token opens the following website to create a token:
## #https://GitHub.com/settings/tokens
## usethis::create_github_token()

## #Give RStudio your token
## gitcreds::gitcreds_set()

gh::gh_whoami()









## #Clone a repository from Github
## usethis::create_from_github(
##   "https://github.com/username/repository.git",
##   destdir = "~/local/path/repo/"
## )







#GitHub Docs:
#https://docs.github.com/en

## #Get a situation report on your current Git/GitHub status
## usethis::git_sitrep()
## #> * GitHub user: 'edgar-treischl'
## #> * Token scopes: 'gist, repo, workflow'
## #> x Token lacks recommended scopes:
## #>   - 'user:email': needed to read user's email addresses
## #>   Consider re-creating your PAT with the missing scopes.
## #>   `create_GitHub_token()` defaults to the recommended scopes.
## #> x Can't retrieve registered email addresses from GitHub.
## #>   Consider re-creating your PAT with the 'user' or at least 'user:email'..





## #Pro Git
## show_link("pro-git")
