---
title: "hei Vignette"
author: "Tim Folsom"
date: "6/27/2017"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteEngine{knitr::knitr}
  %\VignetteIndexEntry{hei Vignette}
  %\usepackage[UTF-8]{inputenc}
---



First we load the hei package and the tidyverse package. tidyverse is not necessary but the ``` %>% ``` pipe from dplyr among other functions will be used in this analysis.


```r
library(hei)
library(tidyverse)
```

## FPED: retrieving and cleaning data

It helps to start with a dataset from FPED already downloaded. You can get one of your own here: https://www.ars.usda.gov/northeast-area/beltsville-md/beltsville-human-nutrition-research-center/food-surveys-research-group/docs/fped-databases/










