#Notes for week of Case Study 3

##Task 6

#install.packages("devtools")
devtools::install_github("drsimonj/ourworldindata", force = TRUE)
child_mortality <- read_csv("drsimonj/ourworldindata")

child_mortality

RegionMortalityRates <- 
  read_excel("C:/Users/Cortland/OneDrive/School/Stats/M335_WatsonC/Case_Study_03/Class_Task_06/RegionMortalityRates.xlsx")
RegionMortalityRates

child_mortality_worldbank <- read_excel("C:/Users/Cortland/OneDrive/School/Stats/M335_WatsonC/Case_Study_03/Class_Task_06/child_mortality_worldbank.xls")
child_mortality_worldbank

RegionMortality <- RegionMortalityRates %>% 
  filter(country != "East Asia & Pacific (IDA & IBRD countries)", country != "Europe & Central Asia (IDA & IBRD countries)", country != "Latin America & the Caribbean (IDA & IBRD countries)", country != "Middle East & North Africa (IDA & IBRD countries)", country != "Sub-Saharan Africa (IDA & IBRD countries)")

ggplot(RegionMortality, aes(x = year, y = deaths, color = country)) +
  geom_point() +
  geom_line() +
  labs(title = "Child Mortality By Region") +
  theme_minimal() +
  scale_y_log10() 
 
ggplot(RegionMortality, aes(x = year, y = deaths, color = country)) +
  geom_point() +
  geom_line() +
  labs(title = "Child Mortality By Region") +
  theme_minimal() +
  scale_y_log10() + 
  theme(legend.position = "bottom") +
  guides(colour = guide_legend(nrow = 1, override.aes = list(size = 4)))


##The code below was in attempt to label the lines, but it failed.
##It labeled every point
RegionMortalityRates <- 
  read_excel("C:/Users/Cortland/OneDrive/School/Stats/M335_WatsonC/Case_Study_03/Class_Task_06/RegionMortalityRates.xlsx")
RegionMortality <- RegionMortalityRates %>% 
  filter(country != "East Asia & Pacific (IDA & IBRD countries)", country != "Europe & Central Asia (IDA & IBRD countries)", country != "Latin America & the Caribbean (IDA & IBRD countries)", country != "Middle East & North Africa (IDA & IBRD countries)", country != "Sub-Saharan Africa (IDA & IBRD countries)")

##Asked McKay and Dylan for help, they suggested the annotate() function.
p + annotate("text", x = 4, y = 25, label = "Some text")

Mortality <- ggplot(RegionMortality, aes(year, deaths)) +
  geom_line(aes(colour = country)) +
  geom_point(aes(colour = country)) +
  labs(title = "Child Mortality By Region", x="Year", y="Deaths per 1000") +
  theme_minimal() 

Mortality + annotate("text", x = 2005, y = 160, label = "Sub-Sahara Africa") +
  annotate("text", x = 1993, y = 4, label = "Euro area") +
  annotate("text", x = 1995, y = 83, label = "World Avg")

##This was to be able to see the points on which to label the lines.

RegionMortality %>%
  filter(year == 1995) %>% 
  arrange(desc(deaths))

RegionMortality %>%
  filter(year == 2000) %>% 
  arrange(deaths)

RegionMortality %>%
  filter(year == 1992) %>% 
  arrange(deaths)

##devtools

devtools::install_github("drsimonj/ourworldindata", force=TRUE)
View(ourworldindata::child_mortality)


#Case Study 3
library(nycflights13)
library(gapminder)
library(tidyverse)
library(readxl)
library(readr)
library(ggrepel)
View(nycflights13)
?nycflights13
View(flights)

##If I am leaving before noon, which two airlines do you recommend at each
##airport (JFK, LGA, EWR) that will have the lowest delay time at the 75th 
##percentile?

###This is me creating my new data sets that will allow me to work based on 
###specific data that the questions asks for, before noon, at specific airports

###Graphics for the first question. 75th percentile means boxplot
JFK <- flights %>% 
  filter(origin == "JFK", dep_time < 1200) %>% 
  group_by(carrier) 
View(JFK)

ggplot(JFK, aes(x = carrier, y = dep_delay)) +
  geom_boxplot() +
  labs(title = "Delay time at JFK by Carrier") +
  scale_y_log10() +
  theme_minimal()

####The above graphic leaves me with question between the two carriers UA and DL
JFK1 <- JFK %>% 
  filter(carrier != "9E", carrier != "AA", carrier != "B6", carrier != "EV", 
         carrier != "HA", carrier != "MQ", carrier != "US", carrier != "VX")
View(JFK1)

ggplot(JFK1, aes(x = carrier, y = dep_delay)) +
  geom_boxplot() +
  labs(title = "Delay time at JFK by UA and DL") +
  scale_y_log10() +
  theme_minimal()
####UA has a smaller 75th along with VX

LGA <- flights %>% 
  filter(origin == "LGA", dep_time < 1200)
View(LGA)
ggplot(LGA, aes(x = carrier, y = dep_delay)) +
  geom_boxplot() +
  labs(title = "Delay time at LGA by Carrier") +
  scale_y_log10() +
  theme_minimal()
####This graphic tells us that out of LGA YV has the lowest, but we are left
####comparing two other carriers, FL and WN
LGA1 <- LGA %>% 
  filter(carrier != "9E", carrier != "AA", carrier != "B6", carrier != "EV", 
         carrier != "UA", carrier != "MQ", carrier != "US", carrier != "YV",
         carrier != "DL", carrier != "F9")
View(LGA1)

ggplot(LGA1, aes(x = carrier, y = dep_delay)) +
  geom_boxplot() +
  labs(title = "Delay time at LGA by FL and WN") +
  scale_y_log10() +
  theme_minimal()

EWR <- flights %>% 
  filter(origin == "EWR", dep_time < 1200)
View(EWR)
ggplot(EWR, aes(x = carrier, y = dep_delay)) +
  geom_boxplot() +
  labs(title = "Delay time at EWR by Carrier") +
  scale_y_log10() +
  theme_minimal()
####This graphic tells us that out of EWR AS is the lowest and again 
####we must take a closer look at two of them, AA and WN
EWR1 <- EWR %>% 
  filter(carrier != "9E", carrier != "AS", carrier != "B6", carrier != "DL", 
         carrier != "EV", carrier != "MQ", carrier != "UA", carrier != "US",
         carrier != "VX")
View(EWR1)

ggplot(EWR1, aes(x = carrier, y = dep_delay)) +
  geom_boxplot() +
  labs(title = "Delay time at EWR by AA and WN") +
  scale_y_log10() +
  theme_minimal()

###Which origin airport is best to minimize my chances of a late arrival 
###when I am using Delta Airlines?

####This is me wrangling data. Minimize late arrival using Delta. What origin?

Flights <- flights %>%
  filter(carrier == "DL", !is.na(arr_delay))

View(Flights)

Delta <- Flights %>% 
  filter(carrier == "DL") %>% 
  group_by(origin) %>%  
  summarize(AVG_Delay = mean(arr_delay))
View(Delta)

ggplot(Delta, aes(x = origin, y = AVG_Delay, color = origin)) +
  geom_col() +
  labs(title = "Comparing Arrival Delays Using Delta", x = "Origin", y = "AVG Delay In Minutes") +
  theme_minimal()

###Stole code from Blake Cromar to see how he handled the situation with NA.
Flights <- flights %>%
  filter(carrier == "DL", !is.na(arr_delay), hour %in% c(6, 8, 10, 12, 14, 16, 18, 20, 22))

View(Flights)







