---
title: "Task_12"
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
Using global regular expression print (grep) and regular expressions (regex) to find character string patterns is a valuable tool in data analysis and is available with all operating systems and many different programming languages. It is a powerful tool once it is understood. The recently developed library(stringr) package makes these tools much easier to use. The three tasks below can be completed in many different ways. As a challenge, my code to complete this entire task less than 10 lines.

##Reading

This reading will help you complete the tasks below.

o [Chapter 14: R for Data Science - Strings](r4ds.had.co.nz/strings.html)

o [Five principles of effective data visualizations](https://www.thoughtworks.com/insights/blog/five-principles-effective-data-visualizations)

o [regexr.com (optional)](https://regexr.com/)

o [Regular Expression examples (optional)](https://qntm.org/files/re/re.html)

o [Regular Expression support applet (optional)](https://regex101.com/)

o [Regular Expression for R (optional)](http://stat545.com/block022_regular-expression.html)

##Tasks

[x] Use the readr::read_lines() function to read in each string - randomletters.txt and randomletters_wnumbers.txt



[x] With the randomletters.txt file, pull out every 1700 letter (e.g. 1, 1700, 3400, …) and find the quote that is hidden - the quote ends with a period



[x] With the randomletters_wnumbers.txt file, find all the numbers hidden and convert those numbers to letters using the letters order in the alphabet to decipher the message


```r
pander(Letters)
```

_t_, _h_, _e_, _ _, _p_, _l_, _u_, _r_, _a_, _l_, _ _, _o_, _f_, _ _, _a_, _n_, _e_, _c_, _d_, _o_, _t_, _e_, _ _, _i_, _s_, _ _, _n_, _o_, _t_, _ _, _d_, _a_, _t_, _a_, _._, _z_, _ _, _a_, _n_, _f_, _r_ and _a_

[x] With the randomletters.txt file, remove all the spaces and periods from the string then find the longest sequence of vowels.




```r
pander(Number)
```



  * _euaauue_ and _aaoaaae_

<!-- end of list -->

[x] Save your .R script to your repository and be ready to share your code solution at the beginning of class

















