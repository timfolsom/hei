## HEI

[![Travis-CI Build Status](https://travis-ci.org/vpnagraj/hei.svg?branch=master)](https://travis-ci.org/vpnagraj/hei)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/hei)](https://cran.r-project.org/package=hei)
[![codecov](https://codecov.io/gh/vpnagraj/hei/branch/master/graph/badge.svg)](https://codecov.io/gh/vpnagraj/hei)
___
### Overview
___
The goal of `hei` is to calculate Healthy Eating Index (HEI) scores from National Health and Nutrition Examination Survey (NHANES) data for use in dietary analyses. The HEI is a dietary metric designed by the USDA and NCI to gauge adherence to the US Dietary Guidelines.
### Installation
___
```
devtools::install_github("vpnagraj/hei")
```
### Getting Started
___
>`library(hei)`

The hei package contains one key function:

>`hei()` works on a formatted data set containing food patterns information (such as that returned by the helper function, `hei::combo()`) returning a data set with scores for each of the twelve HEI components as well as a total score.

hei also includes `get_fped()` `get_diet()` and `get_demo()` for retrieving data from the Food Patterns Equivalents Database (FPED) and the NHANES dietary and demographic databases, respectively, modified for optimization with `combo()` (which combines and formats these data sets for use in `hei()`). The FPED data sets (in the public domain) retrieved by `get_fped()` are built into the package and have been converted to .csv files from the SAS data format in which they were originally published by their creators. `get_diet()` and `get_demo()` require the R package `nhanesA` which is employed to retrieve NHANES data sets directly from the web.
### Related Work
___
hei is intended as a tool to aid in the analysis of NHANES data. It is important to be familiar with NHANES and its complex survey design as well as the FPED, which is derived from NHANES, before beginning any analyses involving the HEI.

* [NHANES survey methods and analytical guidelines](https://wwwn.cdc.gov/nchs/nhanes/analyticguidelines.aspx)

* [FPED methodology and user guides](https://www.ars.usda.gov/northeast-area/beltsville-md/beltsville-human-nutrition-research-center/food-surveys-research-group/docs/fped-methodology/)
