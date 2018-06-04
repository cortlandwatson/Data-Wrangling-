##Case Study 10

#####Task 19
#install.packages("sf")


library(tidyverse)
library(USAboundaries)
library(ggrepel)
library(sf)
library(maps)
library(ggplot2)

US <- us_cities() %>%
  filter(state != "HI", state != "AK") %>%
  group_by(state) %>%
  top_n(n = 3) %>%
  mutate(population = population/1000,
         largest = case_when(
    population == max(population) ~ TRUE,
    population != max(population) ~ FALSE))

View(US)

State <- st_as_sf(map("state", plot = FALSE, fill = TRUE))
ID <- us_counties(state = "Idaho")

USCities <- ggplot() +
  geom_sf(data = State, fill = NA) +
  geom_sf(data = ID, fill = NA) +
  geom_point(data = US, aes(x = lon, y = lat, size = population, color = population)) +
  geom_label_repel(data = (US %>% 
                             group_by(state) %>%
                             filter(largest == TRUE)), 
                   aes(x = lon, y = lat, label = city)) +
  labs(x = "Longitude",
       y = "Latitude",
       title = "Most Populated Cities of the US by State",
       color = "Population") +
  theme_minimal() 

ggsave("USCities.png", plot = USCities, path = "./Case_Study_10/Class_Task_19", width = 18, height = 10)


##still having issues trying to get my plot working. 
nc <- sf::st_read(system.file("shape/nc.shp", package = "sf"), quiet = TRUE)
states <- sf::st_as_sf(map("state", plot = FALSE, fill = TRUE))

ggplot() +
  geom_sf(data = nc)

###Using the data from the text didnt help.


#########CaseStudy10
library(tidyverse)
library(USAboundaries)
library(ggrepel)
library(sf)
library(maps)
library(here)
library(viridis)
library(rvest)
library(rnaturalearth)
library(geofacet)
library(buildings)
library(stringr)
library(devtools)

States <- us_states()
Idaho <- us_counties(states = "Idaho")

States1 <- States %>%
  filter(statefp != "72", statefp != "02", statefp != "15")

Permits <- permits %>%
  group_by(StateAbbr, year) %>%
  filter(variable == "Single Family") %>%
  summarise(countOfPermits = sum(value)) %>%
  filter(year %in% c(2005:2010))

Combined <- Permits %>%
  left_join(States1, by = c("StateAbbr" = "stusps"))

Permits1 <- Permits %>%
  left_join(States1, by = c("StateAbbr" = "stusps"))


Idaho1 <- permits %>%
  filter(StateAbbr == "ID", 
         variable == "Single Family",
         year %in% c(2005:2010)) %>%
  rename(name = countyname) %>%
  mutate(name = gsub(" County", "", name))


Idaho2 <- Idaho1 %>%
  left_join(Idaho)

View(Idaho1)
View(Idaho2)

ggplot() + 
  geom_sf(data = Combined, aes(fill = countOfPermits)) +
  facet_wrap(~year) +
  scale_fill_gradient(low = "yellow1", high = "red1") +
  theme_minimal()  +
  labs(fill = "Count",
       title = "Permits by State")

ggplot(data = Idaho2) +
  geom_sf(aes(fill = value)) +
  facet_wrap(~year) +
  scale_fill_gradient(low = "yellow1", high = "red1") +
  theme_minimal()  +
  labs(fill = "New Permits",
       title = "New Permits by Year") 
  



