---
title: Preparing data for Apsim Classic
author: Stephanie Langer
date: '2020-04-18'
slug: preparing-data-for-apsim-classic
categories:
  - apxim classic
tags:
  - tricks
emoji: yes
output:
  blogdown::html_page:
    toc: yes
---

**Contributed By [Stephanie Langer](https://github.com/StephanieLanger)**


# Key comments 

The data should be organised in a way Apsim can read it.  The screenshots below show examples for different templates. First some general comments:

-	Data can be stored one file or separated, even csv is fine;  
-	Some optional comments in the top (comments start with a “!”);    
-	A row of headers, these should be something that make clear what they are (not too long and they need to be unique), if the table gets too big, we might make different files;  
-	A row with units, between brackets (each cell must have something, if not unit is available then use empty brackets);
-	First column with date (there can be gaps, but no repetitions);  
-	Missing data should be marked (using  “?”, or “*”, or “NA”);  
-	I’d recommend round the numbers so that we don’t get silly values (like 2.00000000013 when it should be 2.0), but careful not to round too much (suggest one decimal place for pasture DM, three for SWC);  
-	Data should include a brief description of the experiment and/or site:  
-	Add information about the data (collections method, was it cleaned?, etc)   

# Example 1: Weather data 

Weather data should be organised like shown in the example below. To import weather data to Apsim the file should be stored as a “met” file. Often weather data should be collected over a long period not only for the time the experiment is running. Weather data is available on the cliflo weather database from NIWA.   

![](/post/2020-04-18-preparing-data-for-apsim-classic_files/steph1.png){width=100% height=100%} 

# Example 2: Site data

Incoming lab data can be summarised in the following template. The collected data can be easily copied and pasted in corresponding tables in APSIM.

![](/post/2020-04-18-preparing-data-for-apsim-classic_files/steph2.png){width=100% height=100%}



# Example 3: Dry matter and soil water content data


Dry matter data is often recorded under field and lab data. The measured dry matter data can be used to validate the predicted pasture/crop production.

![](/post/2020-04-18-preparing-data-for-apsim-classic_files/steph3.png){width=100% height=100%} 

The soil water content is often measured by soil moisture probes (e.g. TDR). It is important to know what data is be used (hourly, daily average, or minutes), often the soil moisture measured at 23:00 o`clock is used but it depends on the user and research question.  Furthermore soil water content can be measured using a neutron probe. 

![](/post/2020-04-18-preparing-data-for-apsim-classic_files/steph4.png){width=80% height=80%}  
