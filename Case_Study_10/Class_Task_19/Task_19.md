---
title: "Task_19"
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

Up to this point, we have dealt with data that fits into the tidy format without much effort. Spatial data has many complicating factors that have made handling spatial data in R complicated. Big strides are being made to make spatial data tidy in R. However; we are in the middle of the transition.
We will use library(USAboundaries), library(ggrepel), and library(sf) to make a map of the US and show the top 3 largest cities in each state. Specifically, you will use library(ggplot2) and the function geom_sf() to recreate the provided image.

## Reading

This reading will help you complete the tasks below.

o [Using SF package with tidyverse](https://byuistats.github.io/M335/spatial_reading.html)

o [SF R package](https://r-spatial.github.io/sf/)

o [USAboundaries R Package](https://github.com/ropensci/USAboundaries)

o [Video on spatial datums](https://www.youtube.com/watch?v=xKGlMp__jog)

o [Video 2 on spatial datums](https://www.youtube.com/watch?v=kXTHaMY3cVk)

## Tasks

[ ] Create a .png image that closely matches my example 

[ ] Note that fill = NA in geom_sf() will not fill the polygons with a grey color

[ ] Note that library(USAboundaries) has three useful functions - us_cities(), us_states(), and us_counties()

[ ] Save your script and .png files to GitHub



























