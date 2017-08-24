---
title: 'hei: Calculate Healthy Eating Index (HEI) Scores'
authors:
 - name: Tim Folsom
   orcid: x
   affiliation: University of Virginia
 - name: VP Nagraj
   orcid: 0000-0003-0060-566X
   affiliation: University of Virginia
date: 23 August 2017
bibliography: paper.bib
---
# Summary 

The Health Eating Index (HEI) is a dietary metric originally designed by the United States Department of Agriculture (USDA) and National Cancer Institue (NCI) to gauge adherence to the United States Dietary Guidelines[@hei]. The NCI distributes SAS macros for calculating individual HEI scores. **hei** is a package that implements the HEI scoring algorithms in R[@R], allowing users without SAS licenses to perform these calculations for individuals across several years of National Health and Nutrition Examination Survey (NHANES) studies. Internally, **hei** depends on the **nhanesA** package[@nhanesA] to retrieve necessary data for scoring. Additional demographic and behavioral NHANES datasets are publicly available and can be combined with the HEI scores for corresponding individuals to serve a variety of research inquiries regarding dietary habits[@social_support][@tinnitus][@age]. 

# References