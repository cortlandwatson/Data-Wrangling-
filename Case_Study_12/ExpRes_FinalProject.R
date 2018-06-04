
#Final Project/Experiencing Research

library(tidyverse)
library(mosaic)
library(pander)
library(readr)
library(dplyr)
library(plotly)
library(readxl)
library(ggplot2)
library(car)

#########Final for 335
dt1 <- read_csv("C:/Users/Cortland/OneDrive/School/Psychology/Experiencing Research/Student March 29.zip")

dt2 <- read_csv("C:/Users/Cortland/OneDrive/School/Psychology/Experiencing Research/Facebook March 29.zip")

Student <- dt1 %>% 
  select(Finished, ResponseId, Q16, Q32, Q18, Q26,Q29,Q5,Q8,Q9,Q10) %>% 
  mutate(Type = "BYU-Idaho Online",
         Condition =
           case_when(!is.na(Q18)~"Static",
                     !is.na(Q26)~"Dynamic-with-future-growth",
                     !is.na(Q29)~"Dynamic-without-future-growth",
                     TRUE ~ "Missing")) %>% 
  slice(3:n()) %>% 
  rename(Consent = Q16,
         US = Q32,
         Static = Q18,
         DynamicUp = Q26,
         DynamicDown = Q29, 
         Interest = Q5,
         Politics = Q8, 
         Sex = Q9,
         Vegan = Q10) %>% 
  filter(Condition != "Missing",
         Interest != "NA") %>% 
  mutate(Interest = parse_number(Interest)) 


Norms <- dt2 %>% 
  select(Finished, ResponseId, Q16, Q32, Q18, Q26,Q29,Q5,Q8,Q9,Q10) %>% 
  mutate(Type = "Facebook",
         Condition =
           case_when(!is.na(Q18)~"Static",
                     !is.na(Q26)~"Dynamic-with-future-growth",
                     !is.na(Q29)~"Dynamic-without-future-growth",
                     TRUE ~ "Missing")) %>% 
  slice(3:n()) %>% 
  rename(Consent = Q16,
         US = Q32,
         Static = Q18,
         DynamicUp = Q26,
         DynamicDown = Q29, 
         Interest = Q5,
         Politics = Q8, 
         Sex = Q9,
         Vegan = Q10) %>% 
  filter(Condition != "Missing",
         Interest != "NA") %>% 
  mutate(Interest = parse_number(Interest)) 

dim(Student)
#291
dim(Norms)
#603 is more

Student <- Student %>% 
  filter(Vegan == "2")

Norms <- Norms %>% 
  filter(Vegan == "2")

dim(Student)
#286
dim(Norms)
#570

CombinedNorms <- Norms %>% 
  bind_rows(Student)

#Code for graphic used for poster.
ggplot(data = CombinedNorms, aes(x = Condition, y = Interest)) +
  geom_boxplot() +
  geom_jitter(mapping = aes(color = Type), width = .3, alpha = .8) +
  stat_summary(fun.y = "mean", geom = "point", size = 4, color = "Black") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 25, angle = 10, vjust = 1, hjust = .5),
        axis.text.y = element_text(size = 25),
        legend.title = element_text(size = 25),
        axis.title = element_text(size = 25)) +
  theme(plot.title = element_text(size = 50),
        plot.subtitle = element_text(size = 30),
        legend.text=element_text(size=20)) +
  labs(color = "Participant Type",
       fill = "",
       x = "Condition",
       y = "Interest in Consuming Less Meat",
       title = "Meat Consumption Influenced by Norms",
       subtitle = "286 Students - 570 Facebook - Black point is the average")

ggplot(data = CombinedNorms, aes(x = Condition, y = Interest)) +
  geom_boxplot() +
  geom_jitter(mapping = aes(color = Type), width = .3, alpha = .8) +
  stat_summary(fun.y = "mean", geom = "point", size = 4, color = "Black") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 10, vjust = 1, hjust = .5)) +
 labs(color = "Participant Type",
       fill = "",
       x = "Condition",
       y = "Interest in Consuming Meat",
       title = "Meat Consumption Influenced by Norms",
       subtitle = "286 Students - 570 Facebook - Black point is the average")

#Creating subsets for data analysis.
####Student data.
Student1 <- Student %>% 
  filter(Condition != "Dynamic-without-future-growth") 

Student2 <- Student %>% 
  filter(Condition != "Static") 

Student3 <- Student %>% 
  filter(Condition != "Dynamic-with-future-growth") 

#T-tests for online students
Test1 <- t.test(Interest ~ Condition, data = Student1, mu = 0, alternative = "two.sided",
                 conf.level = 0.95)
pander(Test1)
#-0.1185, 189.2, 0.9058, twosided, 3.135, 3.167

Test2 <- t.test(Interest ~ Condition, data = Student2, mu = 0, alternative = "two.sided",
                  conf.level = 0.95)
pander(Test2)
#1.439, 187.7, 0.1517, twosided, 3.135, 2.777

Test3 <- t.test(Interest ~ Condition, data = Student3, mu = 0, alternative = "two.sided",
                 conf.level = 0.95)
pander(Test3)
#-1.512, 186.1, 0.1322, twosided, 2.777, 3.167

#Chi-squared analysis
barplot(table(Student$Condition, Student$Interest), beside=TRUE, legend=TRUE)

ChiStu <- chisq.test(table(Student$Condition, Student$Interest))
pander(ChiStu)
#7.125, 12, 0.8492

#Chi-squared analysis for politics
barplot(table(Student$Politics, Student$Interest), beside=TRUE, legend=TRUE)

ChiStuP <- chisq.test(table(Student$Politics, Student$Interest))
pander(ChiStuP)

#We are now going to use the data to run independent samples t test for the groups.
#First we have to check for appropriateness as we look to replicate 
#Sparkmans study. 

qqPlot(Norms$Interest[Norms$Condition=="Static"], ylab="Interest", main="Static")
qqPlot(Norms$Interest[Norms$Condition=="Dynamic-with-future-growth"], ylab="Interest", main="Dynamic Growth")
#We have appropriate samples.


#Creating subsets of data for analysis with Norms.
Norms1 <- Norms %>% 
  filter(Condition != "Dynamic-without-future-growth") 

Norms2 <- Norms %>% 
  filter(Condition != "Static") 

Norms3 <- Norms %>% 
  filter(Condition != "Dynamic-with-future-growth") 

NTest1 <- t.test(Interest ~ Condition, data = Norms1, mu = 0, alternative = "two.sided",
                 conf.level = 0.95)
pander(NTest1)
#Statistic -0.5389, 383.8 df, 0.5903 pvalue, twosided, mean1=3.415, mean2=3.311

NTest2 <- t.test(Interest ~ Condition, data = Norms2, mu = 0, alternative = "two.sided",
                  conf.level = 0.95)
pander(NTest2)
#Statistic 0.1419, df 373.2, pvalue 0.8872, two.sided, mean3=3.283

NTest3 <- t.test(Interest ~ Condition, data = Norms2, mu = 0, alternative = "less",
                  conf.level = 0.95)
pander(NTest3)
#Greater/statistic 0.1419, pvalue0.4436 Less/Statistic same, pvalue 0.5564

NTest4 <- t.test(Interest ~ Condition, data = Norms3, mu = 0, alternative = "two.sided",
                 conf.level = 0.95)
pander(NTest4)
#Statistic -0.6695, df 371.7, pvalue 0.5036, two sided

#Chi-squared analysis
barplot(table(Norms$Condition, Norms$Interest), beside=TRUE, legend=TRUE)

ChiNorms <- chisq.test(table(Norms$Condition, Norms$Interest))
pander(ChiNorms)
#9.439, 12, 0.665

barplot(table(Norms$Politics, Norms$Interest), beside=TRUE, legend=TRUE)

ChiPol <- chisq.test(table(Norms$Politics, Norms$Interest))
pander(ChiPol)

###Tables for RCW
Test <- c("Alpha", "Student Static Vs Dynamic Future Growth",
          "Student Dynamic Future Growth Vs Dynamic No Growth (two-tailed)",
          "Student Static Vs Dynamic No Growth",
          "Student Chi-Squared Condition Vs Interest",
          "Student Chi-Squared Politics Vs Interest")
PValue <- c(0.01, 0.9058, 0.1517, 0.1322, 0.8492, 0.00356)
TestStatistic <- c("None",-0.1185, 1.439, -1.512, 7.125, 62.98)

StudentTests <- data.frame(Test, PValue, TestStatistic)
pander(StudentTests)

FacebookTest <- c("Alpha", "Facebook Static Vs Dynamic Future Growth",
                  "Facebook Dynamic Future Growth Vs Dynamic No Growth (two-tailed)",
                  "Facebook Dynamic Future Growth Vs Dynamic No Growth (one-tailed)",
                  "Facebook Static Vs Dynamic No Growth", 
                  "Facebook Chi-Squared Condition Vs Interest",
                  "Facebook Chi-Squared Politics Vs Interest")
FacebookPValue <- c(0.008, 0.5903, 0.8872, 0.4436, 0.5036, 0.665, 6.234e-06)
FacebookTestStatistic <- c("None",-0.5389, 0.1419, 0.1419, -0.6695, 9.439, 85.68)

FacebookTests <- data.frame(FacebookTest, FacebookPValue, FacebookTestStatistic)
pander(FacebookTests)


barplot(table(CombinedNorms$Politics, CombinedNorms$Interest), beside=TRUE, legend=TRUE)

ChiCN <- chisq.test(table(CombinedNorms$Politics, CombinedNorms$Interest))
pander(ChiCN)










