######Intro to Tidyverse######
#Data Wrangling

library(gapminder)
library(dplyr)

##N/A
###Understanding N/As in the data
x<-c(44,NA,5,NA)
x*3
y<-rnorm(1000)
z<-rep(NA,1000)
my_data<-sample(c(y,z),100)
my_na<-is.na(my_data)
my_na
my_data == NA
sum(my_na)
my_data
0/0
Inf-Inf

###Getting rid of N/A
x
x[1:10]
x[is.na(x)]
y<-x[!is.na(x)]
y
y[y>0]
x[x>0]
x[!is.na(x) & x>0]
x[c(3,5,7)]
x[0]
x[300]
x[3000]
x[c(-2,-10)]
x[-c(2,10)]
vect <- c(foo=11, bar=2, norf=NA)
vect
names(vect)
c(11, 2, NA)
vect2<-c(11, 2, NA)
names(vect2)<- c("foo", "bar", "norf")
identical(vect, vect2)
vect["bar"]
vect[c("foo","bar")]


##Filter is used to take sections of the data. This can allows us to view, 
##or create a new data set.

gapminder %>%
  filter(year == 1957)

gapminder %>% 
  filter(year == 2002, country == "China")

##Arrange allows me to organize the data according to a variable.
##The first example shows the default, which goes from low to high

gapminder %>%
  arrange(lifeExp)

##This example shows how to go from high to low

gapminder %>%
  arrange(desc(lifeExp))

##This shows how to filter and use arrange

gapminder %>%
  filter(year == 1957) %>% 
  arrange(desc(pop))

##Mutate allows for a variable to be changed, or to create a new column.
##The first one is manipulating the data in the same data set

gapminder %>%
  mutate(lifeExp = lifeExp * 12)

##This example shows how to make a new column.
gapminder %>% 
  mutate(lifeExpMonths = lifeExp * 12)

gapminder %>% 
  filter(year == 2007) %>% 
  mutate(lifeExpMonths = 12 * lifeExp) %>% 
  arrange(desc(lifeExpMonths))

#Data Visualization

library(ggplot2)

gapminder_1952 <- gapminder %>% 
  filter(year == 1952)

gapminder_1952

##Geom_point is for scatter plots. There are many different geoms

ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) +
  geom_point()

ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point()

##Use the scale of a variable to manipulate the data to get rid of specific
##trends or behaviors in the data.

ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point() +
  scale_x_log10()

ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10()

##Add color and size to help the visualization more clear

ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent, 
                           size = gdpPercap)) +
  geom_point() +
  scale_x_log10() 

##This facet lets me make several graphs seperated by the given variable.

ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~ continent)

ggplot(gapminder, aes( x = gdpPercap, y = lifeExp, color = continent, 
                       size = pop)) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~ year)

#Grouping and Summarizing

gapminder1 <- filter(gapminder, year == 1957)

##Summarize gives us outputs based on the information we want. 
##Here we ask for median

gapminder %>%
  summarize(medianLifeExp = median(lifeExp))

##Here we ask for median, max, we can also ask for min, sum, and mean

gapminder1 %>%
  summarize(medianLifeExp = median(lifeExp),maxGdpPercap = max(gdpPercap))

##Group_by allows us to see all data for specific variables as shown

gapminder %>%
  group_by(year) %>% 
  summarize(medianLifeExp = median(lifeExp),maxGdpPercap = max(gdpPercap))

gapminder %>%
  group_by(year, continent) %>% 
  summarize(medianLifeExp = median(lifeExp),maxGdpPercap = max(gdpPercap))

by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))

by_year

##Expand limits allows me to make the scale start at a specific point.

ggplot(by_year, aes(x = year, y = medianLifeExp)) +
  geom_point() +
  expand_limits(y = 0)

by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

by_year_continent

ggplot(by_year_continent, aes(x = year, y = medianGdpPercap, color = continent)) +
  geom_point() +
  expand_limits(y = 0)

##I created a graph using a new data set. %>% is used when creating the new 
##data set while + is used inside ggplot.

by_continent_2007 <- gapminder %>% 
  filter(year == 2007) %>% 
  group_by(continent) %>% 
  summarize(medianGdpPercap = median(gdpPercap), 
            medianLifeExp = median(lifeExp))

by_continent_2007

ggplot(by_continent_2007, aes(x = medianGdpPercap, y = medianLifeExp, color = continent)) +
  geom_point() 



#Types of Visualizations
##Line chart
by_year <- gapminder %>%
  group_by(year) %>% 
  summarize(medianGdpPercap = median(gdpPercap)) 

by_year

ggplot(by_year, aes(x = year, y = medianGdpPercap)) +
  geom_line() +
  expand_limits(y = 0)

by_year_continent <- gapminder %>%
  group_by(year, continent) %>% 
  summarize(medianGdpPercap = median(gdpPercap)) 

by_year_continent

##Points plus lines

ggplot(by_year_continent, aes(x = year, y = medianGdpPercap, color = continent)) +
  geom_line() +
  geom_point() +
  expand_limits(y = 0)

by_continent <- gapminder %>%
  filter(year == 1952) %>% 
  group_by(continent) %>% 
  summarize(medianGdpPercap = median(gdpPercap)) 

##Bar charts

ggplot(by_continent, aes(x = continent, y = medianGdpPercap)) +
  geom_col()
 
oceania_1952 <- gapminder %>% 
  filter(year == 1952, continent == "Oceania")
  
ggplot(oceania_1952, aes(x = country, y = gdpPercap)) +
  geom_col()

gapminder_1952 <- gapminder %>%
  filter(year == 1952)

##Histogram

ggplot(gapminder_1952, aes(x = pop)) +
  geom_histogram()

ggplot(gapminder_1952, aes(x = pop)) +
  geom_histogram() +
  scale_x_log10()

##Boxplots

ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) +
  geom_boxplot() +
  scale_y_log10()

ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) +
  geom_boxplot() +
  labs(title = "Comparing GDP per capita across continents") +
  scale_y_log10() +
  theme_minimal() +
  coord_flip()

#### ^ coord_flip() allows us to shift the graphic to view it in a different way.

