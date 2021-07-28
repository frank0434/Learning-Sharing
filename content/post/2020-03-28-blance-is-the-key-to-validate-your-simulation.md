---
title: Balance is the key to validate ApsimX simulations
author: Frank
date: '2020-03-28'
slug: blance-is-the-key-to-validate-your-simulation
categories:
  - apsimx
tags:
  - tricks
emoji: yes
output:
  blogdown::html_page:
    toc: yes
    toc_depth: 2
---

# Introduction

It is critical to inspect the simulation result from a Apsim model so that we are confidence to say the model does what is expected. For a beginner, it might feel hopeless when we stare at the UI with hundreds of parameters can be modified and output. Despite the complicity of Apsim, the entire idea of simulation checking is about biologically meaningful. We could apply some simple logic to do the inspection of the agricultural system - a system that should be balanced.  

There are probably three main balances in a agricultural system.  

  1. Water balance. whenever there is water in (e.g. Rainfall/Irrigation), the water either drain away or used by plants or stored by the soil or run off or evaporate or just sitting there. 
  
  2. Nitrogen balance. Nitrogen has many different forms in the soil, but still it is suppose to balance in a sensible way following the I/O (input / output) rule.  
  
  3. Biomass balance. The plant is the `factory` which is susceptible to the input (water/radiation/temperature/nutrients/carbon dioxide) most. It operates at a close to potential rate if there is no stress at all while yield gap always presents in the paddock.   
  
This post covers the main idea of inspecting Apsim model via simulation results. It should be noted that general understanding of agricultural system is necessary to carry out the task. Apsim Lucerne model is used here. Special thanks to [Dr Rogerio Cichota](https://www.researchgate.net/profile/Rogerio_Cichota) for the detailed explanations and patient guidance.  

# Water Balance 

### Basic Logic 

The idea is simple, $$InputWater = OutputWater + StoredWater$$

Table below shows the common variables that one should check for the water balance in simulations.   

|Input| Output|State (StoredWater)|
|:---|:---|:---|
|Precipitation | Evapotranspiration|Soil Water content|
|Irrigation | Drainage||
||Runoff||
||Pond||
||Lateral flow||

### Representative variables 

The ApsimNG UI has some really helpful features. For instance, a `.` after the right model component will trigger the drop-down list with all available variables under the component. This feature can be performed in the **Properties** of the **\*Report** node.  

![](/post/2020-03-28-blance-is-the-key-to-validate-your-simulation_files/report.png){width=50% height=50%}  

Addresses to access some common variables for checking if the model water balance makes sense.  

- Inputs:   
`[Weather].Rain as Rainfall`  
`[Irrigation].IrrigationApplied as IrrigationApplied`    

- Outputs:  
  `[Soil].SoilWater.Drainage as Drainage`  
  
  `[Soil].SoilWater.Runoff as Runoff`. This might be very useful in hill country land.   
  
  `([Lucerne].Leaf.Transpiration + [Soil].SoilWater.Es) as ET`.  ET is a special one since it has two parts: transpiration by plant and surface evaporation.    


- State:   
`sum([Soil].SoilWater.SWmm) as SWC`. A `sum` call will summaries soil water content in each layer to have total soil water content in mm.    
`[Soil].SoilWater.SWmm`. This variable will output soil water content in each layer which depends on the soil water set up.  

Depends on how much details one wants to check the model performance, we could output all variables that involved in water processes. However, it could be a time consuming task with little gain. For beginners (like me), it is better to check those representative variables to have some feeling about the model performance and do more sophisticated evaluation after consultant advanced users.   

# Nitrogen Balance 

### Basic Logic

Logic also can be simplified as:   

$$InputNitrogen = OutputNitorgen + StoredNitrogen$$
However, the situations in real world might violate the logic and the agreement might be rarely met. In general, large differences between the left and right hand sides could indicate poor model performance. For example, the result is probably wrong if one only inputs 100 kg N/ha into a system while the leached N is 1000 kg N/ha in an annual system. The best approach to check N balance is to have experts who can provide general guidance on particular soil types for certain crops.   

Table below shows the common variables that one should check for the nitrogen balance in simulations.  

|Input| Output|State (StoredNitrogen)|
|:---|:---|:---|
|Fertiliser |Harvest plant (RemoveN)|Surface organic matter|
|Fixation |Denitrofication|Mineral N| 
|Urine|Leaching ($NO_3^-$)|Plant N |
||volatilisation|Urea|
|||$NH_4^+$|
|||($NO_3^-$)|
|||FOMN - Fresh organic matter N|
|||Microbial|
|||Humic|
_Note: Nitrogen in soils is too complex to cover accurately here.This table is just a general guidance._

### Representative variables 

- Inputs:   
`[Fertiliser].NitrogenApplied as FertiliserNApplied`. This might not be useful for legume but could be valuable for other crops. 

- Outputs:   
`[Soil].SoilNitrogen.Denitrification`  
`[Soil].SoilNitrogen.MineralisedN`   

  `([Soil].SoilWater.LeachNH4 + [Soil].SoilWater.LeachNO3) as LeachedN`. Use `as` to rename the variable for avoiding super long variable names.   

  `([Lucerne].Leaf.Removed.N + [Lucerne].Stem.Removed.N)*10 as TotalNRemoved`. Nitrogen removed via above ground biomass will have different components to consider depending on crops. For example, maize will have grain and other organs that need to be added in. 
  
  `([Lucerne].Total.N)*10 as TotalPlantN`. The total represent both above and below ground N in the plant. 
  
  `sum([Soil].SoilNitrogen.FOMN) as TotalFOMN`. It might be too much information if output the `FOMN` by each layer, therefore, a summed value could be better to check the fresh organic matter nitrogen.   
  
  `sum([Soil].SoilNitrogen.HumicN) as TotalHumicN`  
  `sum([Soil].SoilNitrogen.MicrobialN as TotalMicrobialN`  

- State:   
`([Soil].SoilNitrogen.Urea.kgha + [Soil].SoilNitrogen.NH4.kgha + [Soil].SoilNitrogen.NO3.kgha) as SoilNLayers`.   

# Biomass Balance 


### Basic Logic

Biomass checking is not really a balance checking but a common sense checking. For instance, it would be less ideal if the predicted yield consistently outside of the real ranges all the time.  

Table below shows the common variables that one should check for the biomass balance in simulations.    

|Input| Output|
|:---|:---|
|Radiation|Biomass|
|Carbon dioxide|Biomass|
|Water|Refer to the water balance|
|Nutrient (Mainly N)|Nutrient concentrations|
|Temperature| Phenology|

### Representative variables 

- Inputs:   
`[Weather].Radn as SolarRadiation`. The solar radiation is a good checker for inspecting multiple simulations over different locations.    
`[Weather].MeanT`.   

- Outputs:  
`([Lucerne].Total.Wt)*10 as TotalPlantBiomass`. The conventional Apsim output unit is $g DM/m^2$. It probably makes more sense to use `kg DM/ha`.    


Biomass is probably the one that agronomist care the most. However, cautions are necessary when we look at the biomass predictions because the biomass is built upon the assumptions of right water and nitrogen balances. Often, the biomass variables could reveal hidden flaws in the model. For example, it is probably make no biological sense if the root biomass of lucerne keeps accumulating over years with no sign of stablising. It would be a magic crop if the root biomass always accumulates. :joy:  


