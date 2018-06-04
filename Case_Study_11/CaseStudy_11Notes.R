#######CASESTUDY 11 NOTES
####Task21
library(tidyverse)
library(USAboundaries)
library(ggrepel)
library(sf)
library(maps)
library(leaflet)

States <- st_as_sf(map("state", fill = TRUE, plot = FALSE))

Cities <- us_cities(map_date = NULL) %>%
  filter(state != "AK",
         state != "HI") %>%
  mutate(pop_1000 = population/1000) %>%
  group_by(state) %>%
  filter(row_number(desc(population)) %in% c(1,2,3)) %>%
  group_by(state) %>%
  mutate(rank = rank(desc(population)))

Cities1 <- Cities %>% 
  group_by(state) %>%
  filter(row_number(desc(population)) == 1) 

pal <- colorFactor(c("firebrick4", "yellow2", "orange2"), domain = c(1, 2, 3))

leaflet(data = Cities) %>%
  addTiles() %>%
  setView(lng = -95, lat = 40, zoom = 3) %>%
  addCircleMarkers(~lon, ~lat, popup = ~as.character(city), 
                   label = ~as.character(city),
                   color = ~pal(rank),
                   radius = ~ifelse(rank == 1, 10, 5),
                   stroke = FALSE,
                   fillOpacity = 1) %>%
  addPopups(lng = ~lon, lat = ~lat, 
            popup = ~as.character(city), data = Cities1,
            options = popupOptions(closeButton = FALSE,
                                   textOnly = TRUE)) %>%
  addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
  addPolygons(color = "black", 
              data = States, 
              fill = FALSE, 
              opacity = 1,
              weight = 1)

########CaseStudy 11
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
library(leaflet)
library(pander)

Idaho <- us_counties(states = "Idaho")
States <- us_states()

States1 <- States %>%
  filter(statefp != "72", statefp != "02", statefp != "15")

Permits <- permits %>%
  group_by(StateAbbr, year) %>%
  filter(variable == "Single Family") %>%
  summarise(countOfPermits = sum(value)) %>%
  filter(year %in% c(2005:2010))

Permits1 <- Permits %>%
  group_by(StateAbbr) %>%
  summarise(difference4years = max(countOfPermits) - min(countOfPermits))

Diff <- Permits1 %>%
  left_join(States1, by = c("StateAbbr" = "stusps"))

Diff <- st_as_sf(Diff)

#US 2005
US5 <- Permits %>%
  left_join(States1, by = c("StateAbbr" = "stusps")) %>%
  filter(year == 2005)

US5 <- st_as_sf(US5)

#2010
US10 <- Permits %>%
  left_join(States1, by = c("StateAbbr" = "stusps")) %>%
  filter(year == 2010)

US10 <- st_as_sf(US10)

#Idaho 2005
ID5 <- permits %>%
  filter(StateAbbr == "ID", 
         variable == "Single Family",
         year == 2010) %>%
  rename(name = countyname) %>%
  mutate(name = gsub(" County", "", name))

Idaho5 <- ID5 %>%
  left_join(Idaho)

Idaho5 <- st_as_sf(Idaho5)

#2010
ID10 <- permits %>%
  filter(StateAbbr == "ID", 
         variable == "Single Family",
         year == 2010) %>%
  rename(name = countyname) %>%
  mutate(name = gsub(" County", "", name))

Idaho10 <- ID10 %>%
  left_join(Idaho)

Idaho10 <- st_as_sf(Idaho10)

#graphics
bins <- c(125, 4129, 8133, 15198.5, 22264, 30359, 38454, 123808, 209162)
pal <- colorBin("Bluess", domain = US5$countOfPermits, bins = bins)

leaflet(data = US5) %>%
  addTiles() %>%
  addPolygons(color = "black", 
              data = states_contiguous, 
              fill = FALSE, 
              opacity = 1,
              weight = 1)  %>%
  addPolygons(
    fillColor = ~pal(countOfPermits),
    weight = 2,
    opacity = 1,
    color = "black",
    dashArray = "3",
    fillOpacity = 1) %>% 
  addProviderTiles(providers$Esri.NatGeoWorldMap)

bins <- c(125, 4129, 8133, 15198.5, 22264, 30359, 38454, 123808, 209162)
pal <- colorBin("Blues", domain = US5$countOfPermits, bins = bins)

leaflet(data = US10) %>%
  addTiles() %>%
  addPolygons(color = "black", 
              data = states_contiguous, 
              fill = FALSE, 
              opacity = 1,
              weight = 1)  %>%
  addPolygons(
    fillColor = ~pal(countOfPermits),
    weight = 2,
    opacity = 1,
    color = "black",
    dashArray = "3",
    fillOpacity = 1) %>% 
  addProviderTiles(providers$Esri.NatGeoWorldMap)

bins <- c(0, 86.75, 173.5, 656.85, 1418, 2269.9, 3121.8, 12666.4, 22211)
pal <- colorBin("Blues", domain = Idaho5$value, bins = bins)

leaflet(data = Idaho5) %>% 
  addTiles() %>%
  addPolygons(
    fillColor = ~pal(value),
    weight = 2,
    opacity = 1,
    color = "black",
    dashArray = "3",
    fillOpacity = 1) %>% 
  addProviderTiles(providers$Esri.NatGeoWorldMap)

bins <- c(0, 86.75, 173.5, 656.85, 1418, 2269.9, 3121.8, 12666.4, 22211)
pal <- colorBin("Blues", domain = Idaho10$value, bins = bins)

leaflet(data = Idaho10) %>% 
  addTiles() %>%
  addPolygons(
    fillColor = ~pal(value),
    weight = 2,
    opacity = 1,
    color = "black",
    dashArray = "3",
    fillOpacity = 1) %>% 
  addProviderTiles(providers$Esri.NatGeoWorldMap) 
































