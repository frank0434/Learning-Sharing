---
title: Implenment physiological process in apsimx model
author: Frank
date: '2020-07-01'
slug: implenment-physiological-process-in-apsimx-model
categories:
  - apsimx
tags:
  - tricks
emoji: yes
output:
  blogdown::html_page:
    toc: yes
---

# Aim

Water stress has a significant effect on leaf area expansion rate. To implenment
the effects, one needs to modify the model or use manager script to update the model states. 

# Modify the plant model itself  

1. The process of the effect. Water stress hit the leaf and reduce the rate of expansion. This could be quantified by calculating the ratio of water demand and supply.  

2. Which stage of the crop gets the effect most and first?

3. Is it a minimum or a multiplication function?   
A multiplication function:

![](/post/2020-07-01-implenment-physiological-process-in-apsimx-model_files/modifyingmodel.PNG){width=70% height=70%}
