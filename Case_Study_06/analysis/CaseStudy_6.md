---
title: "CaseStudy_6"
author: watsoncl 
output: 
  html_document:
    keep_md: true
    theme: flatly
    toc: true
    toc_float: true
    code_folding: hide
---



##Background
It is 2010, and you are working for the Idaho restaurant commission, and they need your help getting a clearer picture of how restaurant construction changed across Idaho from 2008 to 2009. They provided you a dataset of all commercial construction in Idaho for those two years. The data has a variable Type with a general category called Food_Beverage_Service that has other buildings besides restaurants in the category. You will need to use the restaurant names (see restaurants data object) and some additional key words to create the correct subgroupings. Your client expects to provide new data for 2010 and 2011 so your script needs to do the work. Make sure you do not use Excel to manipulate anything.

How did full-service restaurant construction compare to quick service restaurant construction across county and years?

How did restaurant construction fare compare to the other commercial construction in Idaho?

Which county in Idaho spent the most on fast food construction each year?

In that county how did other commercial construction compare?

##Reading

This reading will help you complete the tasks below.

o Regular Expressions in R

##Tasks
[x] Load the R package from GitHub devtools::install_github("hathawayj/buildings") and find out what data is in the package



<div style="padding-left:30px;">
There are four datasets in this package. They discuss the commercial buildings and their operations, and dates including construction.
</div>

[ ] Construction value is related to population in the area. Join the climate_zone_fips data to the buildings0809 data using the two FIPS columns for state and county.

[ ] After filtering to Food_Beverage_Service group of buildings in the Type variable, use the ProjectTitle column to create new subgroups from the groupings in the code section below and the restaurant names in restaurants. 

[ ] Restaurants that are not assigned using the names and keywords that are over 4000 square feet should be grouped into Full Service Restaurants and be in Quick Service Restaurants if they are under 4000 square feet

[ ] Make sure your text strings your are matching on are as standardized as possible 

[ ] leverage functions like str_to_lower() and str_trim() to get all the words in a standardized form

[ ] you could use the case_when() function to create the subgroups.

[ ] Create an .Rmd file with 2-3 paragraphs summarizing your 3-4 graphics that inform the client questions

[ ] Compile your .md and .html file into your git repository

[ ] Find two other student’s compiled files in their repository and provide feedback using the issues feature in GitHub (If they already have three issues find a different student to critique)

[ ] Address 1-2 of the issues posted on your project and push the updates to GitHub






