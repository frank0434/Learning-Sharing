---
title: Install R package from private repository via `token`
author: Frank
date: '2020-04-07'
slug: install-r-package-from-private-repository-via-key
categories: []
tags: []
emoji: yes
output:
  blogdown::html_page:
    toc: yes
---


# Aim 

To install a R package that is in a private repository on GitHub. 

# Prerequisite

1. A Github account.  
2. The account has been authorised to access the private repository where the package is located.  
3. R and Rstudio.  :joy:   
4. R package `devtools`.  
5. R package `usethis`.  

# Step by Step

Using a personal access token is probably the easiest way to achieve the aim, although it might not be the safest. :joy: 

1. Generate [a personal access](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line) token through the Github. A detailed step by step how to is provided by [GitHub help](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line).

2. Open Rstudio.  

3. Type `usethis::edit_r_environ()` below into the console. The command will open a R environment file named `.Renviron`.

4. Type `auth_token=` in the first line.

5. Paste the 40 digits token from GitHub on the the right hand side of the equal sign and press enter.

6. Save and close the file. 

7. `Ctrl + Shift + F10` to restart R. 

8. Type `devtools::install_github("PlantandFoodResearch/pfrticles", auth_token = Sys.getenv("auth_token"))` and press enter. The installation should start.   


P.S. More information about authentication on GitHub and how organisation repository works

[Authenticating to GitHub](https://help.github.com/en/github/authenticating-to-github)
[Keeping your organization secure](https://help.github.com/en/github/setting-up-and-managing-organizations-and-teams/keeping-your-organization-secure)

