## HEI
___
### Overview
___
The goal of hei is to calculate Healthy Eating Index scores. The Healthy Eating Index is a dietary metric designed by the USDA and NCI to gauge adherence to the US Dietary Guidelines.
### Installation
___
```
devtools::install_github("vpnagraj/hei")
```
### Getting Started
___
>`library(hei)`

hei can be used to perform two key calculations.

>`leg_all()` works on a dataset containing the necessary food patterns information for a collection of individuals (such as that recorded in NHANES and the FPED), returning a dataset containing additional variables representing protein categories with legumes appropriately allocated.

>`hei()` works on a dataset containing food patterns information that includes protein categories with legumes appropriately allocated (such as that returned by `leg_all()`) returning a dataset with scores for each of the twelve HEI components as well as a total score.

hei also includes `get_diet()` and `get_demo()` for retrieving NHANES dietary and demographic data from the web for a given year, respectively, as well as `combo()`, which will join an FPED data set with a dietary and a demographic dataset such as these.
### Related Work
___
hei utilizes several tidyverse packages including dplyr and readr. hei also uses the nhanesA package.

* [Read more about the tidyverse approach to data analysis.](https://github.com/tidyverse)

* [Learn about the NHANES survey package.](https://github.com/cjendres1/nhanes)