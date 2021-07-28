---
title: 'Manual validation of ApsimNG-Lucerne '
author: Frank
date: '2020-04-05'
slug: manual-validation-of-apsimng-lucerne
categories:
  - apsimx
tags:
  - tricks
emoji: yes
output:
  blogdown::html_page:
    toc: yes
---

# The case 

ApsimNG is a great tool for climate change studies once we have a comprehensive plant model with realibale climate data and detailted soil propterties. However, it will be waste of time if the simulation results make no biological sense. The validation of a model is a key step before we ran the massive simulations for climate change scenarios. 

This post is a simplified example of manually validating the ApsimNG-Lucerne model to ensure the model is doing what we expected. 


# The software and version 

It is recommended to use the latest version of ApsimNG. Due to some practical problems, a previous version of ApsimNG is used here. The commit hash is `f65c2cedc2d17a40daab33a361d69061058d4790` for this particular version. Apsim.shared is required to be built for this version as well. The date of the last commit in the Apsim.shared repository has to be similar to the ApsimNG repository. _Trial and error_ approach is probably needed to get it working. So the easiest way is just use the latest version of ApsimNG. :joy:  

The `.apsimx` file can be found in the prototype folder. 

## Visulisation tool - ApsimNG build in tools 

Coming....  :joy:

## Potential automated validation - R/Python
