library(gapminder)
library(ggplot2)
library(tidyverse)

#Read Data
-----------
suicide <- read_xlsx("/Users/Cortland/OneDrive/School/Stats/M335_WatsonC/Case_Study_03/Class_Task_06/suicide.xlsx")

#Data manipulation
suicide1 <- suicide %>% 
  mutate(tenth=Suicides/10)





#Plots
ggplot(data = suicide, mapping = aes(x = Year, y = Suicides)) +
  geom_point(mapping = aes(color = Age)) +
  labs(title = "Suicides Per 100000", x = "Year", y = "Number of Suicides") +
  scale_y_continuous(trans = "sqrt") +
  theme_bw()

ggplot(suicide1, aes(x = Year, y = tenth)) +
  geom_point(aes(color = Age)) +
  geom_line(aes(group=Age, color=Age)) +
  labs(title = "World Wide Suicides Per Population of 100000", x = "Year", y = "Number of Suicides") +
  scale_y_continuous(trans = "sqrt") +
  theme_get()
