#Case Study 6
#Class notes
##2/13/2018
###our graphics need to generate questions. If we do not generate questions,
###then we are not providing enough information to help .
c(1,2,3,4,5,6) == 2
c(1,2,3,4,5,6) %in% 2
!c(1,2,3,4,5,6) %in% 2
##2/15/2018
###install.packages('htmltab')
### http://bradleyboehmke.github.io/2015/12/scraping-html-tables.html
library(XML)
library(RCurl)
library(tidyverse)
library(readr)
library(lubridate)
library(ggrepel)
library(downloader)

### has functions kml_coordinate, kml_points, kml_polygons
source("https://gist.githubusercontent.com/briatte/18a4d543d1ccca194b2a03ac512be2b4/raw/5cd241ab780a33ec9a3ae6297a48f9035cda811d/get_points.r")

###kml file download http://ldschurchtemples.org/maps/
bob <- tempfile()
download("http://ldschurchtemples.org/maps/downloads/kml.php", bob)
temple.locs <- kml_points(bob) %>% select(name, longitude, latitude)

url_size <- "https://ldschurchtemples.org/statistics/dimensions/"
url_time <- "https://ldschurchtemples.org/statistics/timelines/"

dimensions <- url_size %>%
  getURL() %>%
  readHTMLTable() %>%
  .[[1]] %>%
  as.tibble() 

Dimensions <- dimensions %>% 
  rename(Temple = `Temple ` )

Dimensions <- Dimensions %>% 
  mutate(Temple = gsub("Temple[â€¡]+", "Temple", Temple),
         Temple = iconv(Temple, from="UTF-8", to="LATIN1"))

View(Dimensions)

times_AnGrbr <- url_time %>%
  getURL() %>%
  readHTMLTable() %>%
  .[[2]] %>%
  as.tibble() %>%
  select(-Duration) %>% 
  mutate(Temple = gsub("Temple[â€¡]+", "Temple", Temple),
         Temple = iconv(Temple, from="UTF-8", to="LATIN1"))

View(times_AnGrbr)

times_GrbrDed <- url_time %>%
  getURL() %>%
  readHTMLTable() %>%
  .[[3]] %>%
  as.tibble() %>%
  select(-Duration) %>% 
  mutate(Temple = gsub("Temple[â€¡]+", "Temple", Temple),
         Temple = iconv(Temple, from="UTF-8", to="LATIN1"))

View(times_GrbrDed)

Temples <- Dimensions %>% 
  left_join(times_AnGrbr) %>% 
  left_join(times_GrbrDed)

View(Temples)



#TASK 11
##Libraries
library(tidyverse)
library(readxl)
library(readr)
library(dplyr)
library(ggplot2)
library(devtools)
library(RCurl)
library(blscrapeR)
library(Lahman)

View(Master)
View(Salaries)
View(Appearances)
View(CollegePlaying)

###Here we are checking for Keys. Does this one variable, represent one observation
###Yes
Master %>% 
  count(playerID) %>% 
  filter(n > 1)
###Yes
CollegePlaying %>% 
  count(playerID, schoolID, yearID) %>% 
  filter(n > 1)
###Yes
AwardsPlayers %>% 
  count(playerID, awardID, yearID, lgID) %>% 
  filter(n > 1)
###Yes
Salaries %>% 
  count(playerID, yearID, teamID) %>% 
  filter(n > 1)
###Here we are going to start joining the datasets.
Inflation <- inflation_adjust(2017) 
Salaries1 <- Salaries %>% 
  rename(year = yearID)
View(Inflation)
Players <- Master %>% 
  select(playerID, nameGiven)
Players1 <- Players %>% 
  left_join(CollegePlaying, by = "playerID") %>% 
  left_join(Salaries1, by = "playerID") %>%
  left_join(Schools, by = "schoolID") %>%
  filter(state == "UT") %>% 
  mutate_at(5, as.character) %>% 
  left_join(Inflation, by = "year") %>% 
  na.omit() %>%  
  mutate(NewSalary = (1/adj_value)*salary)  
View(Players1)
PlayersUtah <- Players1 %>% 
  filter(name_full != "Brigham Young University")
PlayersBYU <- Players1 %>% 
  filter(name_full %in% "Brigham Young University", nameGiven != "Jeremy")

### Graphic
ggplot(PlayersUtah, aes(x = nameGiven, y = NewSalary, color = name_full)) +
  geom_point() +
  labs(title = "Utah Colleges", x="Player", y="Salary Adjusted to 2017") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 25, vjust = 1, hjust = 1)) 
ggplot(PlayersBYU, aes(x = nameGiven, y = NewSalary)) +
  geom_point() +
  labs(title = "BYU", x="Player", y="Salary Adjusted to 2017") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 25, vjust = 1, hjust = 1)) 



#TAsk 12

library(stringr)
rletter <- readr::read_lines("https://byuistats.github.io/M335/data/randomletters.txt")
rnumber <- readr::read_lines("https://byuistats.github.io/M335/data/randomletters_wnumbers.txt")

##Code from Hathaway
##Pull out every 1700 letter (e.g. 1, 1700, 3400, ) 

str_split(rletter, "")[[1]][c(1, seq(1700, str_count(rletter), by = 1700))] 

## find all the numbers hidden and convert those numbers to letters using the letters order in the alphabet to decipher the message


## with numbers 

extr_numbers <- rnumber %>%
  str_extract_all("[0-9]+") %>%
  unlist() %>%
  parse_number()

## letters is a default object in R

letters[extr_numbers]

## longest sequence of vowels without blank spaces and periods

rnumber %>%
  str_replace(" ", "") %>%
  str_replace("\\.", "") %>%
  str_extract_all("[aeiou]{7}")

## str_count("[aeiou]{7}")

####CasetStudy6
library(buildings)
View(buildings0809)
View(climate_zone_fips)
View(permits)
View(restaurants)

#Join by fips to get buildings and climate together. This helps with seeing
#population as well as the buildings. 

Building <- buildings0809 %>% 
  left_join(climate_zone_fips, by = c("FIPS.county", "FIPS.state")) 

View(Building)

not_restaurants <- c("development","Food preperation center", "Food Services center","bakery","Grocery","conceession","Cafeteria", "lunchroom","school","facility"," hall ")
standalone_retail <- c("Wine","Spirits","Liquor","Convenience","drugstore","Flying J", "Rite Aid","walgreens","Love's Travel")
full_service_type <- c("Ristorante","mexican","pizza","steakhouse","grill","buffet","tavern","bar","waffle","italian","steak house")
quick_service_type <- c("coffee"," java ","Donut","Doughnut","burger","Ice Cream ","custard ","sandwich","fast food","bagel")
quick_service_names <- restaurants$Restaurant[restaurants$Type %in% c("coffee","Ice Cream","Fast Food")]
full_service_names <- restaurants$Restaurant[restaurants$Type %in% c("Pizza","Casual Dining","Fast Casual")]

Dining <- Building %>% 
  filter(Type == "Food_Beverage_Service") %>% 
  mutate(ProjectTitle = str_to_lower(ProjectTitle)) %>%
  mutate(
    Subgroup = case_when(
      str_detect(ProjectTitle, paste(str_to_lower(not_restaurants), collapse = "|")) ~ "Non Standard Food Service",
      str_detect(ProjectTitle, paste(str_to_lower(standalone_retail), collapse = "|")) ~ "Standalone Retail",
      str_detect(ProjectTitle, paste(str_to_lower(full_service_type), collapse = "|")) ~ "Full Service",
      str_detect(ProjectTitle, paste(str_to_lower(quick_service_type), collapse = "|")) ~ "Quick Service",
      str_detect(ProjectTitle, paste(str_to_lower(quick_service_names), collapse = "|")) ~ "Quick Service",
      str_detect(ProjectTitle, paste(str_to_lower(full_service_names), collapse = "|")) ~ "Full Service",
      SqFt >= 4000 ~ "Full Service",
      TRUE ~ "Quick Service"
    )
  )

View(Dining)

#Question 1: How did full-service restaurant construction compare
#to quick service restaurant construction across county and years?

Dining1 <- Dining %>%
  filter(Subgroup %in% c("Full Service", "Quick Service"))

ggplot(Dining1, aes(x = AreaName, fill = Subgroup)) +
  geom_bar() +
  facet_grid(~Year) +
  theme_minimal() +
  labs(x = "",
       y = "Number of Permits",
       title = "Idaho Permits in 2008 and 2009",
       fill = "Service Type") +
  theme(axis.text.x = element_text(angle = 300, hjust = -0.05))


#Question 2: How did restaurant construction fare compare to the 
#other commercial construction in Idaho?

Building1 <- Building %>% 
  mutate()
  

ggplot(data = Building, mapping = aes(x = Value1000)) +
  geom_histogram(mapping = aes(fill = AreaName),
                 color = "black") +
  facet_wrap(~ AreaName, nrow = 4) +
  theme_minimal() +
  labs(x = "Permit Value",
       y = "Number of Permits",
       title = "Permits by county") +
  theme(axis.text.x = element_text(angle = 285, hjust = -0.05)) 

  
#Question 3: Which county in Idaho spent the most on fast food 
#construction each year?
  
#Question 4: In that county how did other commercial construction compare?










