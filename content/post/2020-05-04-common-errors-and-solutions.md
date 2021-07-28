---
title: 'Common Errors and solutions '
author: Frank
date: '2020-05-04'
slug: common-errors-and-solutions
categories:
  - apsimx
tags:
  - tricks
emoji: yes
output:
  blogdown::html_page:
    number_sections: TRUE
    toc: yes
---

**This page is the FAQ which contains random errors and potential solutions of [ApsimX](https://www.apsim.info/)** 

# Invalid report variables

```
Error in report Output: Invalid report variables found:
RUEshoot
```
**Possible Cause:** 0 or other numeric values divided by 0.  
**Solution:** Add a small number into the denominator. `[ExtraVariables].Script.AverageInterceptedRadiation + 0.00000001`


# Radiation Units

Contributed by [Edmar](https://github.com/ed2014)

Note: Units in the paper were in MJ of PAR ... 
APSIM works in global radiation so we can multiply it by 2x

# `no such column: T.Zone` - _Unsloved_

Run `apimx` in visual studio to figure out where the error from. 

`Common Lanuage Runtime Exceptions` must be ticked to trace the error source. 


# `System.NullReferenceException: 'Object reference not set to an instance of an object.'`
Potential casue 1:  

![](/post/2020-05-04-common-errors-and-solutions_files/Object referenece not set to an instance of an object1.png){width=100% height=100%}
Solution is to delete the empty line in between the script.  


# Number of soil layers in SoilWater is different to number of layers in SoilWater.Crop



# Object reference not set to an instance of an object.

could be 
1. Soil layer issue: mismatch.... 


# 'xcopy' is not recognized as an internal or external command

This is a build warning, which won't crush the build and the usage of apsimx. 

# System.InvalidCastException: Object cannot be cast from DBNull to other types.

Could be input data has `null` type. 
[#3488](https://github.com/APSIMInitiative/ApsimX/issues/3488)

