---
title: "CaseStudy_2"
author: watsoncl 
output: 
  html_document:
    keep_md: true
    theme: flatly
    toc: true
    toc_float: true
    code_folding: hide
---



##Reading
This reading will help you complete the tasks below.

o [Chapter 3: R for Data Science - Data visualization](http://r4ds.had.co.nz/data-visualisation.html)

<div style="padding-left:30px;">

How to use ggplot2!

</div>

o [Hans Rosling: The River of Myths]()

##Tasks

[x] Watch the Hons Rosling video

[x] Recreate the two graphics shown below using gapminder dataset from library(gapminder) (get them to match as closely as you can) 

<div style="padding-left:30px;">

  [ ] Use library(ggplot2) and the theme_bw() to duplicate the first plot
  

  
  [x] Use scale_y_continuous(trans = "sqrt") to get the correct scale on the y-axis.
  
  [x] Build weighted average data set using weighted.mean() and GDP with mutate() and group_by() that will be the black continent average line on the second plot
  
  [x] Use library(ggplot2) and the theme_bw() to duplicate the second plot. You will need to use the new data to make the black lines and dots showing the continent average.
  

  
  [x] Use ggsave() and save each plot as a .png with a width of 15 inches

</div>

[x] Build an Rmd file that has the following features 

<div style="padding-left:30px;">

[x] The title is the same as listed in the task

[x] You have two sections – 1) Background, 2) Images

[x] In the background section write a few sentences about what you learned making these plots

[x] In the Image section have two chunks. One for each image

</div>

[x] Save your .Rmd',.md, and the two.png`’s of the plots into your git repository.
















