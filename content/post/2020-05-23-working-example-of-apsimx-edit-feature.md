---
title: Working example of ApsimX `Edit` feature
author: Frank
date: '2020-05-23'
slug: working-example-of-apsimx-edit-feature
categories:
  - apsimx
tags:
  - tricks
emoji: yes
output:
  blogdown::html_page:
    number_sections: TRUE
    toc: yes
bibliography: [bibliography.bib]
biblio-style: "apalike"
link-citations: true
---

In the previous [post](https://frank0434.github.io/2020/03/13/multiply-apsimx-files-via-models-exe/) about using ApsimX built-in feature to do multiplication of simulation files, the `Edit` flag was briefly discussed with basic instruction. This post explores different approaches to integrate the feature into a workflow. 

# A simple workflow

- [Load prepared data](# Load prepared soil parameters). For example, a set of soil parameters consists of DUL, LL and initial soil water for each layer.  
- [Set constants](# Set directory structure in an R environment). The path to source `Models.exe` and the configuration file. 
- [Set the structure](# Construct the configuration) of configuration file for `Edit`
- [Invoke **Edit**](# Invoke Apsimx) 


# Load prepared data for 3 soil parameters

Table \@ref(tab:tab1) shows an example of soil parameters for lucerne grown on a particular soil type [@sim2014water]. The data has been prepared in a way that can capture all depths for different sowing dates of the crop. Conventionally, these values for each parameter would be manually entered to the simulation file (`.apsim` for classic or `.apsimx` for next-generation) via the UI. Alternatively, [programming tools](https://frank0434.github.io/2020/03/13/multiply-apsimx-files-via-models-exe/) have been used to automate the process. However, both approaches require users to have extensive knowledge of data structure and basic programming skills. The built-in [`Edit` feature in ApsimX](https://apsimnextgeneration.netlify.app/usage/editfile/) should be sufficient to remove the pressure of comprehensive a programming language. Instead, the user can customise a particular established workflow to achieve their goals. 

```{r tab1, echo=FALSE}
library(magrittr)
library(kableExtra)
Soilparas <- readRDS("../../static/data/soilParams.rds")
knitr::kable(head(Soilparas[, 1:7]), align = "c",
             col.names = c("Location","Sowing Date", "Date", "Depth", "SW","DUL", "LL"),
             caption = "Initial soil parameters for 22 layers in 10 different sowing dates.") %>%
  kable_styling(bootstrap_options = c("striped", "hover"))

```

# Set directory structure in an R environment

It is intuitive to proceed with the modification of `.apsimx` file in the R environment since the value extraction of soil parameters was completed in R. The 3 essential paths are:  
1. The path to "Models.exe".   
2. The path to the template `.apsimx` which one wants to change.   
3. The path to the configuration file which contains the address to the desired parameter and the values. 

Some optional paths could be:  
1. The flag name - `Eidt`  
2. A path to store all the modified `.apsimx` files 

```{r, eval=FALSE}
#path to apsimx 
apsimx <- "../../ApsimxLatest/ApsimX/Bin/Models.exe"
apsimx_sims_temp <- "../03processed-data/apsimxFiles/temp.apsimx"
apsimx_config <- "../03processed-data/configSoilWat"

apsimx_flag <- "/Edit"
apsimx_sims_dir <- "../03processed-data/apsimxFiles/"


```

# Construct the configuration

The easiest way to obtain the addresses for certain parameters is to use the `Copy path to node` functionality in the UI to copy the address into the clipboard. However, this approach won't copy the last bit of the address. For example, the `Copy path to node` only returns the parent node address to `".Simulations.New Zealand.AshleyDene.Factors.SowingDate.SD.ADsoils.InitialConditions` when one copy the `InitialConditions` node in the UI. The last bit, `.SW`, has to be manually added in. The Apsim team is working on improvement. More details [here](https://github.com/APSIMInitiative/ApsimX/issues/4905#issuecomment-631834777). 

Currently, users either have to know the name of the parameter or use the `tooltip` in the **Report** to obtain the last piece of the address. Please note that the path to parameter values are case sensitive. A wrong name triggers `Invalid path` error message. 

The chunk below demonstrates 5 parameters in the soil model. A `for` loop was written to construct the **configuration file**. We do not have to output the configuration file if one is certain about the correctness of the configuration file. 

```{r, eval=FALSE}
# Node Path - copied from ApsimX UI

initialSW <- ".Simulations.New Zealand.AshleyDene.Factors.SowingDate.SD.ADsoils.InitialConditions.SW = "
DUL <- ".Simulations.New Zealand.AshleyDene.Factors.SowingDate.SD.ADsoils.Physical.DUL = "
LL <- ".Simulations.New Zealand.AshleyDene.Factors.SowingDate.SD.ADsoils.Physical.LucerneSoil.LL = "
LL15 <- ".Simulations.New Zealand.AshleyDene.Factors.SowingDate.SD.ADsoils.Physical.LL15 = "
SAT <- ".Simulations.New Zealand.AshleyDene.Factors.SowingDate.SD.ADsoils.Physical.SAT = "

# Keys
sites <- unique(SW_DUL_LL$Experiment)
SDs <- paste0("SD", 1:10)

# Vectorise the values and stuff them into the configuration files
for(j in sites){
  for(i in SDs){
    # Filter the right values 
    SDsw <- SW_DUL_LL[SowingDate == i & Experiment == j]$SW
    SDDUL <- SW_DUL_LL[SowingDate == i & Experiment == j]$DUL
    SDLL <- SW_DUL_LL[SowingDate == i & Experiment == j]$LL
    apsimx_sw <- paste0(initialSW,
                        paste(SDsw,collapse = ","))
    apsimx_DUL <- paste0(DUL,
                         paste(SDDUL,collapse = ","))
    apsimx_LL <- paste0(LL,
                        paste(SDLL,collapse = ","))
    apsimx_LL15 <- paste0(LL15,
                          paste(SDLL,collapse = ","))
    apsimx_SAT <- paste0(SAT,
                         paste(SDDUL,collapse = ","))
    # Open a text file
    f <- file(paste0(apsimx_config, j, i, ".txt"), "w")
    # Write values into the file 
    cat(apsimx_sw,
        apsimx_DUL,
        apsimx_LL,
        apsimx_LL15,
        apsimx_SAT,"\r",
        sep = "\r", 
        file = f, 
        append = TRUE)
    # Close the file and clean it from memory 
    close(f)
    rm(f)
    gc()
  }

}

```

# Invoke Apsimx

A second `for` loop can be used to integrate the `Edit` feature into the workflow with two steps. The first step is to trigger the modification process based on the configuration file. The second step is to save the modified file into a different name. R might not be the most efficient tool to proceed with these steps because of the efficiency. A Window Powershell script could be developed to process the modification for maximising the efficiency. A bash-script could be more productive in the Linux environment. 

```{r, eval=FALSE}
for(j in sites){
   for(i in SDs){
     # Edit the base apsimx file and save it to a new name
     ## modify the apsimx file 
     system(paste(apsimx, apsimx_file, apsimx_flag, paste0(apsimx_config, j, i,".txt")))
     ## rename the modified one
     system(paste("cp", apsimx_file, paste0(apsimx_sims_dir, "Modified", j, i, ".apsimx")))
     ## delete the temp apsimx 
     # system(paste("rm", paste0(apsimx_sims_dir, "temp*")))
   }
  }
```


# Reference