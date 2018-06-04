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
#603

Student <- Student %>% 
  filter(Vegan == "2")

Norms <- Norms %>% 
  filter(Vegan == "2")

dim(Student)
#286
dim(Norms)
#570

CombinedNorms <- Norms %>% 
  bind_rows(Student) %>% 
  filter(Sex!="3")

#Sample Vs Interest
ggplot(data = CombinedNorms, aes(x = Type, y = Interest)) +
  geom_boxplot() +
  geom_jitter(width = .3, alpha = .8) +
  stat_summary(fun.y = "mean", geom = "point", size = 3, color = "Red") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 10, vjust = 1, hjust = .5)) +
  labs(color = "",
       fill = "",
       x = "Participants",
       y = "Interest in Consuming Meat",
       title = "Meat Consumption Interest Across Samples",
       subtitle = "Red point is the average")

#Interest vs Condition
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

#Sex Vs Interest
ggplot(data = CombinedNorms, aes(x = Sex, y = Interest)) +
  geom_boxplot() +
  geom_jitter(width = .3, alpha = .8) +
  stat_summary(fun.y = "mean", geom = "point", size = 3, color = "Red") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 10, vjust = 1, hjust = .5)) +
  labs(color = "",
       fill = "",
       x = "Sex(1=male, 2=female)",
       y = "Interest in Consuming Meat",
       title = "Meat Consumption Influenced by Sex",
       subtitle = "Red point is the average | 680 female 173 male")

#Politics Vs Interests
ggplot(data = CombinedNorms, aes(x = Politics, y = Interest)) +
  geom_boxplot() +
  geom_jitter(mapping = aes(color = Politics), width = .3, alpha = .8) +
  stat_summary(fun.y = "mean", geom = "point", size = 3, color = "Black") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 10, vjust = 1, hjust = .5)) +
  labs(color = "Politics",
       fill = "",
       x = "Political Ideology",
       y = "Interest in Consuming Meat",
       title = "Meat Consumption Influenced by Politics",
       subtitle = "Black point is the average | 1 is very liberal")

ggplot(CombinedNorms, mapping = aes(x=Politics)) +
  geom_bar( stat = "count") +
  theme_minimal()

count(CombinedNorms$Sex == "2")










































