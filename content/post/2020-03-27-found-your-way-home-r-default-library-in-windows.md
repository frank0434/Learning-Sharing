---
title: Found your way home - R default library in windows
author: Frank
date: '2020-03-27'
slug: found-your-way-home-r-default-library-in-windows
categories:
  - R configuration
tags:
  - tricks
emoji: yes
output:
  blogdown::html_page:
    toc: yes
---


# Reason about this post

Many R learner (including myself) probably came across the default R library issues in windows system, especially when you are using a company laptop/PC. There are lots of discussion about changing the default directories in R on [StackOverFlow](https://stackoverflow.com/questions/15170399/change-r-default-library-path-using-libpaths-in-rprofile-site-fails-to-work) and other [websites](https://www.accelebrate.com/library/how-to-articles/r-rstudio-library). However, I found using **Environment variables** seems to be the easiest way to go. 


# Change the default library via environment variables 

1. `Windows` key to trigger the start menu. 
2. Type `Edit system environment variables`.  
3. Click the icon shows in the menu.  
4. Click `Environment variables`. 
5. On the bottom half of the dialog, create a new by click `New`. 
6. Variable name will be `HOME` if there is no `HOME` existing already.  
7. Variable value will be the desired default directory for R library.  
8. OK and restart R. 

P.S. Admin right will probably be handy for this job. :stuck_out_tongue_winking_eye: