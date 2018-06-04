#Case Study 8 notes
#########Task 15

library(tidyverse)
library(readr)
library(dplyr)
library(ggplot2)
library(lubridate)
library(riem)
library(scales)
library(rio)

RXE <- riem_measures(station = "RXE", date_start = "2015-06-01", date_end = "2017-07-01")

RXE1 <- RXE %>% 
  mutate(Day = wday(.$valid, label = TRUE),
         Year = as.factor(floor(year(.$valid))),
         Hour = hour(.$valid),
         Month = month(.$valid)) %>% 
  select(valid, Year, Month, Day, Hour, tmpf) %>% 
  filter(Month == "6")

ggplot(data = RXE1, aes(x = Hour, y = tmpf)) +
  geom_point(aes(color = tmpf), 
             size = 3) +
  theme_minimal() +
  facet_wrap(~Day, 1) +
  labs(x = "Time of Day",
       y = "Temperature",
       title = "Temperature in June at RXE",
       subtitle = "0 = Noon | 12 = Midnight | 23 = 11 AM") +
  theme(legend.position = "None") +
  geom_hline(yintercept = 98, 
             color = "red", 
             size = 1)

#The graphic was telling but I had to start my red marker line at 100
#and then bring it down to the right point so that we could see which 
#day was hottest.

RXE2 <- RXE1 %>% 
  filter(Hour == "2")

ggplot(data = RXE2, aes(x = Hour, y = tmpf)) +
  geom_point(aes(color = tmpf), 
             size = 3) +
  theme_minimal() +
  facet_wrap(~Day, 1) +
  labs(x = "Time of Day",
       y = "Temperature",
       title = "Temperature in June at RXE",
       subtitle = "What day had the coldest temperature at 2pm?") +
  theme(legend.position = "None",
        axis.text.x = element_text(size = 0.001)) +
  geom_hline(yintercept = 45, 
             color = "blue", 
             size = 1)

########Task 16
CarWash <- import("https://byuistats.github.io/M335/data/carwash.csv")

Weather <- riem_measures(station = "RXE", date_start = "2016-05-01", date_end = "2016-07-18")

CarWash1 <- CarWash %>%
  mutate(time = str_replace(.$time, "T", " ")) %>%
  mutate(time = str_replace(.$time, "Z", "")) %>%
  mutate(time = ymd_hms(.$time, tz = "UTC")) %>%
  mutate(MT = with_tz(.$time, tzone = "America/Denver")) %>%
  mutate(MTHour = ceiling_date(.$time, "hour")) %>%
  group_by(MTHour) %>%
  summarise(total_sales = sum(amount)) %>%
  arrange(desc(MTHour))

Weather1 <- Weather %>%
  select(valid, tmpf) %>%
  filter(!is.na(tmpf)) %>%
  mutate(MTHour = ceiling_date(.$valid, "hour")) %>%
  rename(temperature = tmpf) %>%
  select(MTHour, temperature) 

CarWash2 <- CarWash1 %>%
  left_join(Weather1, by = "MTHour") %>%
  filter(!is.na(temperature)) %>%
  mutate(hour = hour(.$MTHour)) %>%
  mutate(hour = as.factor(.$hour))

ggplot(data = CarWash2, aes(x = temperature, y = total_sales)) +
  geom_point() +
  theme_minimal() +
  labs(x = "Temperatue",
       y = "Profit",
       title = "Temperature on Sales") 
  
#######Case Study 8

Sales <- import("https://byuistats.github.io/M335/data/sales.csv")

Sales1 <- Sales %>%
  filter(Name != "Missing") %>%
  mutate(Time = str_replace(.$Time, "T", " ")) %>%
  mutate(Time = str_replace(.$Time, "Z", "")) %>%
  mutate(Time = ymd_hms(.$Time, tz = "America/Denver")) %>%
  mutate(Year = year(.$Time),
         Month = month(.$Time, label = TRUE),
         Monthday = mday(.$Time),
         Yearday = yday(.$Time),
         Weekday = wday(.$Time),
         Weekday1 = wday(.$Time, label = TRUE),
         Hour = hour(.$Time)) %>%
  filter(Month != "Apr") %>% 
  filter(Amount < 200,
         Amount > -100)

##Summaries
#Hourly
Hourly <- group_by(Sales1, Name, Year, Month, Weekday1, Hour)
View(Hourly)
Hourly1 <- summarise(Hourly, AVG = mean(Amount, na.rm = TRUE))
knitr::kable(Hourly1) 
#Weekly
Weekly <- group_by(Sales1, Name, Year, Month, Weekday1) 
Weekly1 <- summarise(Weekly, AVG = mean(Amount, na.rm = TRUE))
knitr::kable(Weekly1)
#Monthly
Monthly <- group_by(Sales1, Name, Year, Month) 
Monthly1 <- summarise(Monthly, AVG = mean(Amount, na.rm = TRUE))
knitr::kable(Monthly1)

##Graphics
#Daily
ggplot(data = Sales1, aes(x = Hour, y = Amount, group = Name)) +
  geom_point() +
  facet_wrap(~Name) +
  theme_minimal()  +
  labs(x = "Time",
       y = "Amount",
       title = "Companies by Hour of Day") +
  geom_hline(yintercept = 0, 
             color = "red", 
             size = .5)


#Weekly
ggplot(data = Sales1, aes(x = Weekday1, y = Amount, group = Name)) +
  geom_point() +
  facet_wrap(~Name) +
  theme_minimal() +
  labs(x = "Day",
       y = "Amount",
       title = "Companies by Week") +
  geom_hline(yintercept = 0, 
             color = "red", 
             size = .5)

#Monthly
ggplot(data = Sales1, aes(x = Month, y = Amount, group = Name)) +
  geom_point() +
  geom_jitter(width = .3, alpha = .8) +
  theme_minimal() +
  facet_wrap(~Name) +
  labs(x = "Month",
       y = "Amount",
       title = "Companies by Month") +
  geom_hline(yintercept = 0, 
             color = "red", 
             size = .5)

















