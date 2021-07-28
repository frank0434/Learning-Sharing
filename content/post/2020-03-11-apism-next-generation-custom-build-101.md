---
title: ' Apism Next Generation Custom build 101'
author: Frank
date: '2020-03-11'
slug: apism-next-generation-custom-build-101
categories:
  - apsimx
tags:
  - tricks
emoji: true
output:
  blogdown::html_page:
    toc: true
---


# Ingredients
 
 - [Visual Studio](https://visualstudio.microsoft.com/) is essential.  
 - [Git](https://git-scm.com/) has been built into visual studio IDE from 2013 update 1. So not necessary to install git independently. But it is necessary to have some basic understanding of git.  
 - [Github account](https://github.com/) to clone the repository to local machines. Github is a great platform that host all the repository for many projects. _[Happy Git and Github for the useR](https://happygitwithr.com/)_ maybe a good starting point to learn how to use git and github, although it is a bit R-centered :satisfied:.
 

# How to clone the ApsimX repository

1. Copy the repoitory address from the Github repository page. 

![](/post/2020-03-10-apism-next-generation-custom-build-101_files/Annotation 2020-03-10 133427.png){width=120% height=120%}

2. Open Visual Studio and click the `Clone or check out code` tab on the welcome panel. 

![](/post/2020-03-10-apism-next-generation-custom-build-101_files/img (4).png){width=100% height=100%}

3. Paste the repository address to the `Repository location` and modify the `Local path` if needed. 

![](/post/2020-03-10-apism-next-generation-custom-build-101_files/setuprepo.png){width=100% height=100%}

# How to build

1. Once the repository has been cloned to the local storage. Double click on the bold text located under the `Local Git Repositories`. 

![](/post/2020-03-10-apism-next-generation-custom-build-101_files/opensln.png){width=80% height=80%}

2. The folder will have a `.sln` file to compile the downloaded APSIM Next Generation. Double click on `ApsimX.sln` to open the solution. 

![](/post/2020-03-10-apism-next-generation-custom-build-101_files/Annotation 2020-03-10 095239.png){width=80% height=80%}

3. The shortcut key to build the solution is **F6**. Alternatively, the command can be found under the `Build` tag. 

![](/post/2020-03-10-apism-next-generation-custom-build-101_files/img (6).png){width=80% height=80%}


Easy as that. :smiley:

PS:

There are some situations that we might need to access a previous version of APSIM next generation. The strategy here is use `git reset/rebase` to go back in time. It can be troublesome becasue some older versions require the support from the [APSIM.Shared](https://github.com/APSIMInitiative/APSIM.Shared). To compile APSIM.Shared, the same logic applied. 
