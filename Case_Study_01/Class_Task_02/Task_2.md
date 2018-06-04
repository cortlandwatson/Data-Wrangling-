---
title: "Task_2"
author: watsoncl 
output: 
  html_document:
    keep_md: true
    theme: flatly
    toc: true
    toc_float: true
    code_folding: hide
---

<style>



</style>

##Reading

o [Chapter 4: R for Data Scientists - Workflow Basics](http://r4ds.had.co.nz/workflow-basics.html)

o [Data Scientist Florence Nightengale](https://www.atlasobscura.com/articles/florence-nightingale-infographic)

o [Forbes: Data science demand](https://www.forbes.com/sites/drewhansen/2016/10/21/become-data-scientist/#268cc25187d3)

##Tasks

[x] Complete Lessons 1-4 in the library(swirl) package of the course install_course("R Programming E") 

Lesson 1: Basics

```r
#> my_div
#[1] 3.478505 3.181981 2.146460

#| Your dedication is inspiring!

#  |================================================================| 100%

#| Would you like to receive credit for completing this course on
#| Coursera.org?

#1: No
#2: Yes

#Selection: 2
#What is your email address? byui.m335@gmail.com
#What is your assignment token? 
#Error in curl::curl_fetch_memory(url, handle = handle) : 
#  Couldn't resolve host name

# Leaving swirl now. Type swirl() to resume.
```

Lesson 2: File Manipulation, Don't fully comprehend

```r
#  |================================================================| 100%

#| Would you like to receive credit for completing this course on
#| Coursera.org?

#1: No
#2: Yes

#Selection: 2
#What is your email address? byui.m335@gmail.com
```

Lesson 3: Number generation and organization

```r
#rep(c(0,1,2), each=10)
#rep(c(0,1,2), times=10)
#rep(0,times=40)
#seq_along(my_seq)
#seq(along.with=my_seq)
#1:length(my_seq)
#length(my_seq)
#my_seq<-seq(5,10,length=30)
#seq(5,10,length=30)
#seq(0,10,by=.5)
#seq(1,20)
#15:1
#pi:10
#1:20


#| You got it right!

#  |=================================================================| 100%

#| Would you like to receive credit for completing this course on
#| Coursera.org?

#1: Yes
#2: No

#Selection: 1
#What is your email address? byui.m335@gmail.com
#What is your assignment token? 
```

Lesson 4:  Vectors, Basic Logical Expressions

```r
#c(.5,55,-10,6)
#num_vector<-c(.5,55,-10,6)
#tf<-num_vect<1
#tf
#num_vect >= 6
#my_char<-c("My", "name", "is")
#my_char
#paste(my_char, collapse = " ")
#my_name<-c(my_char, "Cortland")
#my_name
#paste(my_name, collapse = " ")
#paste("Hello", "world!", sep = " ")
#paste(1:3, c("X", "Y", "Z"), sep = "")
#paste(LETTERS, 1:4, sep = "-")


#  |=================================================================| 100%

#| Would you like to receive credit for completing this course on
#| Coursera.org?

#1: Yes
#2: No

#Selection: 1
#What is your email address? byui.m335@gmail.com
#What is your assignment token? 
#Grade submission failed.
#Press ESC if you want to exit this lesson and you
#want to try to submit your grade at a later time.
```
[x] Use byui.m335@gmail.com for the email address where you will send confirmation of the completion of each lesson.

[x] Use our course standardization for your name lastname firstletterfirstname for each. For example, mine is hathawayj.

[x] Ignore the token submission step

[x] Complete Lessons 5-7 in the library(swirl) package of the course install_course("R Programming E") 

Lesson 5: Missing Values/Wrangling NAs

```r
#x<-c(44,NA,5,NA)
#x*3
#y<-rnorm(1000)
#z<-rep(NA,1000)
#my_data<-sample(c(y,z),100)
#my_na<-is.na(my_data)
#my_na
#my_data == NA
#sum(my_na)
#my_data
#0/0
#Inf-Inf

#  |=================================================================| 100%

#| Would you like to receive credit for completing this course on
#| Coursera.org?

#1: No
#2: Yes

#Selection: 2
#What is your email address? byui.m335@gmail.com
#What is your assignment token? 
#Grade submission failed.
#Press ESC if you want to exit this lesson and you want to try to submit your grade at a later time.
```

Lesson 6: Subsetting Vectors

```r
?is.na
```

```
## starting httpd help server ... done
```

```r
#  |=================================================================| 100%

#| Would you like to receive credit for completing this course on
#| Coursera.org?

#1: Yes
#2: No

#Selection: 1
#What is your email address? byui.m335@gmail.com
#What is your assignment token? 
#Grade submission failed.
```

Lesson 7: Matrices(same category of data{ex. number}) and Data Frames(combine numberic and categorical)

```r
#1:20;my_vector<-1:20;vector;my_vector;dim(my_vector);length(my_vector);dim(my_vector)<-c(4,5);dim(my_vector);attributes(my_vector);my_vector;class(my_vector);my_matrix<-my_vector;?matrix;my_matrix2<-matrix(1:20, nrow=4, ncol=5);identical(my_matrix, my_matrix2);patients<-c("Bill","Gina","Kelly","Sean");cbind(patients, my_matrix);my_data<-data.frame(patients,my_matrix);my_data;class(my_data);cnames<-c("patient", "age", "weight", "bp", "rating", "test");colnames(my_data);colnames(my_data)<-cnames;my_data


#  |=================================================================| 100%

#| Would you like to receive credit for completing this course on
#| Coursera.org?

#1: No
#2: Yes

#Selection: 1

#| You nailed it! Good job!
```

[x] Follow sub-directions above.

[x] Read a short article about the data scientist Florence Nightengale and write a two to three sentence paragraph critique of her coxcomb graphic based on your perceptions of quality graphics. 

<div style="padding-left:50px;">

While reading about Nightingale I was particularly interested by her bar graph comparing the deaths of civilians to that of soldiers. The other graph were not clear for me to read, but this graph did what Rauser spoke of. Common scales, categories labled by color, and presented a beautiful story. The others I did not understand.

</div>

[x] In class, be prepared to submit your write up electronically.

[x] Create a [GitHub account](https://github.com/join?source=header-home) and post your github username on the [google docs sheet](https://docs.google.com/spreadsheets/d/13aQsQYnGTQXyyBUGzE1V9MExEvG5woAmygtkdjltdjk/edit#gid=59053514) in I-Learn

