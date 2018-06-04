#Case Study 4 and Tasks

#Task 7

library(tidyverse)
library(readxl)
library(readr)
library(dplyr)
library(ggplot2)
library(devtools)
library(waffle)
library(RCurl)

###Here is the data and the manipulation of it.
devtools::install_github("drsimonj/ourworldindata")
library(ourworldindata)
View(ourworldindata)
View(financing_healthcare)

Mortality <- financing_healthcare %>%
  filter(!is.na(child_mort), 
         !is.na(continent),
         child_mort >0, year > 1995) 
View(Mortality)

ggplot(Mortality, aes(x = year, y = health_exp_total, color = continent)) +
  geom_point() +
  theme_minimal()

ggplot(Mortality, aes(x = year, y = health_exp_total, color = continent)) +
  geom_point() +
  theme_minimal()

AmMortality <- Mortality %>% 
  filter(continent == "Americas") 

View(AmMortality)

ggplot(AmMortality, aes(x = year, y = health_exp_total, color = country)) +
  geom_point() +
  theme_minimal()

AmericaMortality <- AmMortality %>% 
  filter(country != "Antigua and Barbuda", country != "Bahamas", country != "Barbados",
         country != "Belize", country != "Bolivia", country != "Chile", 
         country != "Costa Rica", country != "Cuba", country != "Dominica",
         country != "Ecuador", country != "El Salvador", country != "Grenada",
         country != "Guatemala", country != "Guyana", country != "Haiti",
         country != "Honduras", country != "Nicaragua", country != "Panama",
         country != "Paraguay", country != "Peru", country != "Saint Kitts and Nevis",
         country != "Saint Lucia", country != "Saint Vincent and the Grenadines",
         country != "Suriname", country != "Trinidad and Tobago", country != "Jamaica",
         country != "Uruguay")

View(AmericaMortality)

ggplot(AmericaMortality, aes(x = year, y = health_exp_total, color = country,
                             size = child_mort)) +
  geom_point() +
  labs(title = "Americas' HealthCare", y = "Money Spent on HealthCare", x = "Year") +
  theme_minimal()

####I have my graphics listed, but it would be nice to explain in a table the
####differences in GDP between the countries in my Americas' HealthCare plot.

#I excluded Argentina because the GDP was not available.
AmericaGDP <- AmericaMortality %>% 
  filter(year == 2013, country != "Argentina") 

ggplot(AmericaGDP, aes(x = country, y = gdp, fill = child_mort)) +
  geom_col() +
  labs(title="GDP by Country in 2013", y = "GDP", x = "Country") +
  theme_minimal() +
  coord_flip()








#Case Study 4
##Getting the dataset

url <- getURL("https://raw.githubusercontent.com/fivethirtyeight/guns-data/master/full_data.csv")

Guns <- read.csv(text = url)

View(Guns)

##These are the different datasets that I will use in order to communicate.
##For the replicated graph, I will be using the 2014 dataset.
Guns1 <- Guns %>% 
  group_by(intent) %>% 
  summarise(count = n())

Guns %>% 
  group_by(police) %>% 
  summarise(count = n())

View(Guns1)

ggplot(Guns1, aes(x = intent, y = count)) +
  geom_col() +
  labs(title = "Deaths by Gun from 2012 to 2014", subtitle = "100,798 Total Deaths",
       x = "Intent", y = "Number of Deaths") +
  theme_minimal()

Guns2012 <- Guns %>% 
  filter(year == 2012) %>% 
  group_by(intent, month) %>% 
  summarise(count = n())

Guns2013 <- Guns %>% 
  filter(year == 2013) %>% 
  group_by(intent, month) %>% 
  summarise(count = n())
  
Guns2014 <-  Guns %>% 
  filter(year == 2014) %>% 
  group_by(intent, month) %>% 
  summarise(count = n())

ggplot(Guns2012, aes(x = month, y = count, color = intent)) +
  geom_point() +
  geom_line() +
  scale_colour_brewer(palette = "Set1") +
  labs(title = "Gun Deaths in 2012", x = "Month of the Year",
       y = "Number of Deaths") +
  scale_x_continuous(breaks = seq(1, 12, by = 1)) +
  theme_minimal() 

ggplot(Guns2013, aes(x = month, y = count, color = intent)) +
  geom_point() +
  geom_line() +
  scale_colour_brewer(palette = "Set1") +
  labs(title = "Gun Deaths in 2013", x = "Month of the Year",
       y = "Number of Deaths") +
  scale_x_continuous(breaks = seq(1, 12, by = 1)) +
  theme_minimal() 

ggplot(Guns2014, aes(x = month, y = count, color = intent)) +
  geom_point() +
  geom_line() +
  scale_colour_brewer(palette = "Set1") +
  labs(title = "Gun Deaths in 2014", x = "Month of the Year",
       y = "Number of Deaths") +
  scale_x_continuous(breaks = seq(1, 12, by = 1)) +
  theme_minimal() 

###I just created graphics for each year and the intent/count per month. 
###Now I am going to create another graphic that is similar but total deaths
###per month with the color as the year and comparing the month tendencies.

GunsSeason <- Guns %>% 
  group_by(intent, month, year, race) %>% 
  summarise(count = n())

View(GunsSeason)

ggplot(GunsSeason, aes(x = month, y = count)) +
  geom_point() +
  scale_colour_brewer(palette = "Set1") +
  labs(title = "Gun Death Trends by Month From 2012 to 2014", x = "Month of the Year",
       y = "Number of Deaths") +
  scale_x_continuous(breaks = seq(1, 12, by = 1)) +
  theme_minimal() 

ggplot(GunsSeason, aes(x = month, y = count, color = race)) +
  geom_point() +
  scale_colour_brewer(palette = "Set1") +
  labs(title = "Gun Deaths by Race from 2012 to 2014", x = "Month of the Year",
       y = "Number of Deaths") +
  scale_x_continuous(breaks = seq(1, 12, by = 1)) +
  theme_minimal() 

White <- GunsSeason %>% 
  filter(race == "White")

View(White)

ggplot(White, aes(x = month, y = count, color = intent)) +
  geom_point() +
  scale_colour_brewer(palette = "Set1") +
  labs(title = "White Gun Deaths from 2012 to 2014", x = "Month of the Year",
       y = "Number of Deaths") +
  scale_x_continuous(breaks = seq(1, 12, by = 1)) +
  theme_minimal() 

