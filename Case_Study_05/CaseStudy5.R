##Task 9

library(readr)
library(haven)
library(ggplot2)
library(dplyr)
library(readr)
library(readxl)
library(downloader)
library(DT)
library(pander)

#RDS

Data1 <- read_rds(gzcon(url("https://github.com/byuistats/data/raw/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.RDS")))

#CSV

Data2 <- read_csv("https://raw.githubusercontent.com/byuistats/data/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.csv")

#DTA 

Data3 <- read_dta("https://github.com/byuistats/data/blob/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.dta?raw=true")

#SAV

Data4 <- read_sav("https://github.com/byuistats/data/blob/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.sav?raw=true")

#XLSX (Looked at Blake Cromar's code for help on this one.)

download("https://github.com/byuistats/data/raw/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.xlsx", "downloader.zip", mode = "wb")

Data5 <- read_xlsx("downloader.zip")

View(Data1)
View(Data2)
View(Data3)
View(Data4)
View(Data5)

#got help from Cameron Collett's code to understand all.equal() function
all.equal(Data1$contest_period, Data2$contest_period, Data3$contest_period, 
          Data4$contest_period, Data5$contest_period)
all.equal(Data1$variable, Data2$variable, Data3$variable, 
          Data4$variable, Data5$variable)
all.equal(Data1$value, Data2$value, Data3$value, 
          Data4$value, Data5$value)

#graphic to show performance of Dart, DJIA, and Pro

ggplot(Data1, aes(x = variable, y = value)) +
  geom_boxplot() +
  labs(title = "Select Stock Values from 1990 to 1998", x = "Stock", y = "Value") +
  theme_minimal()

ggplot(Data1, aes(x = variable, y = value)) +
  geom_jitter() +
  labs(title = "Select Stock Values from 1990 to 1998", x = "Stock", y = "Value") +
  theme_minimal()

Data1a <- Data1 %>% 
  filter(contest_period %in% c("Average"))

View(Data1a)

ggplot(Data1a, aes(x = variable, y = value)) +
  geom_col() +
  labs(title = "Average Selected Stock Value from 1990 to 1998", x = "Stock", 
       y = "Value") +
  theme_minimal()

ggplot(Data1, mapping = aes(x = variable, y = value)) +
  geom_boxplot(mapping = aes(fill = variable),
               outlier.shape = NA) +
  stat_summary(fun.y = "mean", geom = "point") +
  geom_jitter(mapping = aes(color = variable), alpha = 0.2) +
  theme_minimal() +
  labs(color = "Selected Stock",
       fill = "Selected Stock",
       x = "",
       y = "Value at X Date",
       title = "Selected Stock Value from 1990 to 1998",
       subtitle = "The black point in the box represents the average.")

##Task 10

Stock <- read_rds(gzcon(url("https://github.com/byuistats/data/raw/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.RDS")))

View(Stock)

#Cleaning the data
Stock <- Stock %>% 
  filter(contest_period != "Average") %>% 
  separate(contest_period, c("Beginning Period", "End Period")) %>%
  select(-`Beginning Period`) %>%
  separate(`End Period`, c("month_end", "year_end"), sep = -5) 

Stock$month_end[c(43, 143, 243)] = "December"
Stock$year_end[c(43, 143, 243)] = 1993
Stock$month_end[c(57, 157, 257)] = "February"

View(Stock)

#Now to create a graphic that shows the six month returns
ggplot(Stock, aes(x = year_end, y = value, color = variable)) +
  geom_point() +
  geom_jitter(mapping = aes(color = variable), alpha = 0.2) +
  scale_colour_brewer(palette = "Set1") +
  labs(title = "Return Trend of Selected Stock from 1990 to 1998", x = "Year",
       y = "Value") +
  theme_minimal()
#Im stuck on my graphic. I want to represent the return by year, 
#jittering the months to show the trend, but it is messy.
ggplot(data = Stock, mapping = aes(x = year_end, y = value)) +
  geom_boxplot(mapping = aes(group = year_end, fill = year_end),
               outlier.shape = NA) +
  geom_jitter(mapping = aes(color = year_end), alpha = 0.2) +
  theme_minimal() +
  labs(x = "",
       y = "Value of Return",
       title = "Stock Returns from 1990 to 1998 from Selected Stocks",
       subtitle = "6-month Returns",
       fill = "Year",
       color = "Year")

#This is for the table that was asked of us.
DJIA <- Stock %>%
  filter(variable %in% "DJIA") %>% 
  select(-variable) %>%
  spread(key = year_end, value = value)

View(DJIA)

pander(DJIA)
#This is a more complicated table not used in my .rmd
datatable(DJIA)

####CaseStudy 5

library(foreign)

#First data
Heights <- read_excel("C:/Users/Cortland/OneDrive/School/Stats/M335_WatsonC/Case_Study_05/analysis/Height.xlsx", range = "A3:GU309")

# Second file
Bavaria1 <- read_dta("C:/Users/Cortland/OneDrive/School/Stats/M335_WatsonC/Case_Study_05/analysis/Bavaria.dta")

# 3rd file
Bavaria2 <- read_dta("C:/Users/Cortland/OneDrive/School/Stats/M335_WatsonC/Case_Study_05/analysis/Bavaria2.dta")

# 4th file
Soldiers <- read.dbf("C:/Users/Cortland/OneDrive/School/Stats/M335_WatsonC/Case_Study_05/analysis/Soldiers.DBF")

# 5th file
BLS <- read_csv("https://github.com/hadley/r4ds/raw/master/data/heights.csv")

# 6th file
Survey <- read_sav("C:/Users/Cortland/OneDrive/School/Stats/M335_WatsonC/Case_Study_05/analysis/Survey.sav")

View(Heights)
View(Bavaria1)
View(Bavaria2)
View(Soldiers)
View(BLS)
View(Survey)

Heights <- Heights %>% 
  gather(`1800`:`2011`, key = "year", value = "height") %>%
  filter(Code != c(150, 155, 154, 39, 151, 19, 21, 419, 29, 13, 5, 9, 53, 54, 57, 61, 142, 34, 30, 35, 145, 143, 2, 15, 11, 17, 18, 14),
         !is.na(height)) %>%
  separate(year, into = c("century", "year"), sep = 2) %>%
  separate(year, into = c("decade", "year"), sep = 1) %>%
  mutate(year_decade = paste(century, decade, year, sep = ""),
         height = round(height, 1)) %>%
  mutate(height.in = height*0.39370079) %>%
  rename(height.cm = height, Country = `Continent, Region, Country`) 

Bavaria1 <- Bavaria1 %>%
  rename(height.cm = height, birth_year = bdec) %>%
  mutate(height.in = height.cm*0.39370079, study = "Bavaria-Prison") %>%
  select(birth_year, height.cm, height.in, study) 

Bavaria2 <- Bavaria2 %>%
  select(bdec, height) %>%
  rename(birth_year = bdec, height.cm = height) %>%
  mutate(height.in = height.cm*0.39370079, study = "Bavaria-Conscripts")

Soldiers <- Soldiers %>%
  select(SJ, GEBJZ) %>%
  rename(birth_year = SJ, height.cm = GEBJZ) %>%
  mutate(height.in = height.cm*0.39370079, study = "South-East-South-West")

BLS <- BLS %>%
  select(height) %>%
  rename(height.in = height) %>%
  mutate(height.cm = height.in*(1/0.39370079), study = "BLS", birth_year = 1950)

Survey <- Survey %>%
  select(RT216F, RT216I, DOBY) %>%
  mutate(height.in = RT216F*12 + RT216I, birth_year = DOBY+1900) %>%
  select(birth_year, height.in) %>%
  mutate(height.cm = height.in*(1/0.39370079), study = "Wisconson") 

View(Heights)
View(Bavaria1)
View(Bavaria2)
View(Soldiers)
View(BLS)
View(Survey)

CompleteData <- rbind(Bavaria1, Bavaria2, Soldiers, BLS, Survey)

CompleteDecade <- CompleteData %>%
  mutate(birth_year = round(birth_year, -1), birth_year = parse_character(birth_year)) %>%
  filter(!is.na(birth_year))

View(CompleteDecade)

Germany <- Heights %>% 
  filter(Country == "Germany")

View(Germany)

ggplot(data = Heights, mapping = aes(x = year_decade, y = height.in)) +
  geom_boxplot(mapping = aes(fill = year_decade),
               outlier.shape = NA) +
  geom_jitter(mapping = aes(color = year_decade), alpha = 0.2) +
  geom_point(data = Germany, color = "black") +
  theme_minimal() +
  theme(legend.position = "None", axis.text.x = element_text(angle = 50, vjust = 1, hjust = 1)) +
  labs(color = "Year",
       fill = "Year",
       x = "Decade",
       y = "Height in Inches",
       title = "Height Through the Decades",
       subtitle = "Color = Countries of the world / Black = Germany") 

ggplot(data = CompleteDecade, mapping = aes(x = birth_year, y = height.in)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(alpha = 0.2) +
  facet_wrap(~ study, nrow = 1) +
  theme_minimal() 

##Help from Blake
ggplot(data = CompleteDecade, 
       mapping = aes(x = birth_year, y = height.in)) +
  geom_boxplot(outlier.shape = NA) +
  facet_wrap(~study, nrow = 3, scales = "free_x") + 
  ylim(50, 80) +
  theme_minimal() +
  theme(legend.position = "None") +
  labs(x = "Birth Year",
       y = "Hight in Inches",
       title = "Heights by Study",
       subtitle = "The plots represent data from different studies") 


