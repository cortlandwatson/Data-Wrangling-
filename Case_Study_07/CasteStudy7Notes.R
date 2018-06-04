#CaseStudy7 Notes

##Task 13 (Go back to task 10 and complete that)
library(forcats)
library(tidyverse)

Stock <- read_rds(gzcon(url("https://github.com/byuistats/data/raw/master/Dart_Expert_Dow_6month_anova/Dart_Expert_Dow_6month_anova.RDS")))

Stock <- Stock %>% 
  filter(contest_period != "Average") %>% 
  separate(contest_period, c("Beginning Period", "End Period")) %>%
  select(-`Beginning Period`) %>%
  separate(`End Period`, c("month_end", "year_end"), sep = -5) 

Stock$month_end[c(43, 143, 243)] = "December"
Stock$year_end[c(43, 143, 243)] = 1993
Stock$month_end[c(57, 157, 257)] = "February"

###Getting to know the data
str(Stocks$contest_period)
####Each character is different
levels(Stocks$contest_period)
####This means that there are no levels or major groupings
nlevels(Stocks$contest_period)
####This doesnt really apply because there are no levels
class(Stocks$contest_period)
####This tells us that this column is a character column

ggplot(data = Stock, mapping = aes(x = month_end, y = value)) +
  geom_boxplot(mapping = aes(group = month_end, fill = month_end),
               outlier.shape = NA) +
  geom_jitter(mapping = aes(color = month_end), alpha = 0.2) +
  theme_minimal() +
  labs(x = "",
       y = "Value of Return",
       title = "Stock Returns by month from 1990 to 1998 from Selected Stocks",
       subtitle = "6-month Returns",
       fill = "Month",
       color = "Month") +
  coord_flip()

##Task 14
library(readr)
library(stringi)
library(stringr)
library(pander)
BOM <- read_csv("C:/Users/Cortland/OneDrive/School/Stats/M335_WatsonC/Case_Study_07/Class_Task_14/lds-scriptures.csv")
View(BOM)

###Question 1

BOM$scripture_text[1]
BOM$scripture_text[1] %>% stri_stats_latex()
stri_stats_latex(BOM$scripture_text[1])["Words"]

BOM1 <- BOM %>% 
  group_by(verse_id, volume_title, book_title, verse_title) %>% 
  summarise(words = stri_stats_latex(scripture_text)["Words"])
View(BOM1)

BOM1 %>% 
  group_by(volume_title) %>% 
  summarise(mwords=mean(words)) %>% 
  pander()

###Question 2

str_locate_all(BOM$scripture_text, "Jesus")

stri_stats_latex(BOM$scripture_text)

### New Testament
NewTestament <- BOM %>% 
  filter(volume_title == "New Testament")

View(NewTestament)

str_locate_all(NewTestament$scripture_text, "Jesus")

stri_stats_latex(NewTestament$scripture_text)

JesusNT <- str_count(str_to_lower(NewTestament$scripture_text), "jesus")
JesusNT <- sum(JesusNT)
JesusNT
984

### Calulating the Number of References of Jesus in BoM
BOM2 <- BOM %>% 
  filter(volume_title == "Book of Mormon")

View(BOM2)

str_locate_all(BOM2$scripture_text, "Jesus")

stri_stats_latex(BOM2$scripture_text)

JesusBOM <- str_count(str_to_lower(BOM2$scripture_text), "jesus")
JesusBOM <- sum(JesusBOM)
JesusBOM
184

###Question 3
BOM3 <- BOM1 %>% 
  filter(volume_title == "Book of Mormon") %>% 
  group_by(book_title) %>% 
  arrange(desc(words))

View(BOM3)

ggplot(BOM3, aes(x = book_title, y = words)) +
  geom_boxplot() +
  labs(title = "Word Count for Verses in Books of Book of Mormon", 
       y = "Words Per Verse", x = "Book Name") +
  theme_minimal() +
  coord_flip()

BOM4 <- BOM3 %>% 
  filter(words >= "75")

View(BOM4)


###### CASE STUDY 7
library(rio)


Lines <- read_lines("https://byuistats.github.io/M335/data/2nephi2516.txt")
Names <- import("https://byuistats.github.io/M335/data/BoM_SaviorNames.rds")
Scriptures <- read_csv("C:/Users/Cortland/OneDrive/School/Stats/M335_WatsonC/Case_Study_07/Class_Task_14/lds-scriptures.csv")
BOM <- Scriptures %>%
  filter(volume_title == "Book of Mormon")

View(BOM)

Names1 <- Names %>%
  select(name) %>%
  str_c(sep = "|", collapse = NULL) %>%
  unlist() 

View(Names1)

str_locate_all(BOM$scripture_text, c("the Father of the heavens and of the earth, and all things that in them are", 
                                      "Creator of all things from the beginning", "Jesus Christ, the Son of the living God",
                                      "the Lord Jesus Christ, their Redeemer", "God of Abraham, and Isaac, and Jacob",
                                      "Eternal Father of heaven and earth", "God, the Father of all things", 
                                      "Lord, the Redeemer of all men", "Jesus Christ, the Son of God", 
                                      "Our Father who art in heaven", "Lord and Savior Jesus Christ", 
                                      "Christ, the Lord Omnipotent", "Only Begotten of the Father", 
                                      "Son of the everlasting God", "Father of heaven and earth", "Jehovah, the Eternal Judge",
                                      "Son of the Eternal Father", "great Mediator of all men", "the beginning and the end", 
                                      "Eternal Father of heaven", "God, the Eternal Father", "The Everlasting Father", 
                                      "master of the vineyard", "Lord, the Almighty God", "Redeemer of the world", 
                                      "Son of the living God", "Mighty One of Israel", "Son of righteousness", 
                                      "Lord of the vineyard", "Son of our great God", "Son of Righteousness", 
                                      "Lord their Redeemer", "Mighty One of Jacob", "The Prince of Peace", 
                                      "Lord God Omnipotent", "Savior Jesus Christ", "God of our fathers", 
                                      "Lord God Almighty", "Lord thy Redeemer", "Lord God of Hosts", 
                                      "Holy One of Jacob", "Only Begotten Son", "Lord Jesus Christ", 
                                      "Father of heaven", "the true Messiah", "Christ, the Lord", "Lord Omnipotent",
                                      "Supreme Creator", "Alpha and Omega", "heavenly Father", "God of Abraham",
                                      "Lord their God", "Eternal Father", "King of heaven", "Christ the Son",
                                      "God the Father", "God of Israel", "God of nature", "Lord of Hosts", 
                                      "Lord your God", "good shepherd", "Supreme Being", "Most High God", 
                                      "Lord our God", "God of Isaac", "God of Jacob", "Lord his God", "Lord thy God",
                                      "his Holy One", "Holy Messiah", "Lord Jehovah", "Jesus Christ", "Almighty God",
                                      "Christ Jesus", "Great Spirit", "Well Beloved", "Eternal Head", "Lamb of God",
                                      "Eternal God", "Lord my God", "Beloved Son", "Son of God", "Mighty God", 
                                      "O Lord God", "Holy Child", "Wonderful", "Counselor", "Most High", "Lord God",
                                      "Redeemer", "Shepherd", "Holy God", "Holy One", "Almighty", "Messiah", 
                                      "Creator", "Beloved", "Savior", "Father", "Christ", "Jesus", "Maker", "O God",
                                      "Being", "Lord", "Lamb", "King", "God", "One", "Son", "Man"))
stri_stats_latex(BOM$scripture_text)
NamesBOM <- str_count(str_to_lower(BOM$scripture_text), c("the Father of the heavens and of the earth| and all things that in them are", 
                                                           "Creator of all things from the beginning", "Jesus Christ, the Son of the living God",
                                                           "the Lord Jesus Christ, their Redeemer", "God of Abraham, and Isaac, and Jacob",
                                                           "Eternal Father of heaven and earth", "God, the Father of all things", 
                                                           "Lord, the Redeemer of all men", "Jesus Christ, the Son of God", 
                                                           "Our Father who art in heaven", "Lord and Savior Jesus Christ", 
                                                           "Christ, the Lord Omnipotent", "Only Begotten of the Father", 
                                                           "Son of the everlasting God", "Father of heaven and earth", "Jehovah, the Eternal Judge",
                                                           "Son of the Eternal Father", "great Mediator of all men", "the beginning and the end", 
                                                           "Eternal Father of heaven", "God, the Eternal Father", "The Everlasting Father", 
                                                           "master of the vineyard", "Lord, the Almighty God", "Redeemer of the world", 
                                                           "Son of the living God", "Mighty One of Israel", "Son of righteousness", 
                                                           "Lord of the vineyard", "Son of our great God", "Son of Righteousness", 
                                                           "Lord their Redeemer", "Mighty One of Jacob", "The Prince of Peace", 
                                                           "Lord God Omnipotent", "Savior Jesus Christ", "God of our fathers", 
                                                           "Lord God Almighty", "Lord thy Redeemer", "Lord God of Hosts", 
                                                           "Holy One of Jacob", "Only Begotten Son", "Lord Jesus Christ", 
                                                           "Father of heaven", "the true Messiah", "Christ, the Lord", "Lord Omnipotent",
                                                           "Supreme Creator", "Alpha and Omega", "heavenly Father", "God of Abraham",
                                                           "Lord their God", "Eternal Father", "King of heaven", "Christ the Son",
                                                           "God the Father", "God of Israel", "God of nature", "Lord of Hosts", 
                                                           "Lord your God", "good shepherd", "Supreme Being", "Most High God", 
                                                           "Lord our God", "God of Isaac", "God of Jacob", "Lord his God", "Lord thy God",
                                                           "his Holy One", "Holy Messiah", "Lord Jehovah", "Jesus Christ", "Almighty God",
                                                           "Christ Jesus", "Great Spirit", "Well Beloved", "Eternal Head", "Lamb of God",
                                                           "Eternal God", "Lord my God", "Beloved Son", "Son of God", "Mighty God", 
                                                           "O Lord God", "Holy Child", "Wonderful", "Counselor", "Most High", "Lord God",
                                                           "Redeemer", "Shepherd", "Holy God", "Holy One", "Almighty", "Messiah", 
                                                           "Creator", "Beloved", "Savior", "Father", "Christ", "Jesus", "Maker", "O God",
                                                           "Being", "Lord", "Lamb", "King", "God", "One", "Son", "Man"))
NamesBOM <- sum(NamesBOM)
pander(NamesBOM)

str_locate_all(BOM$scripture_text, "the Father of the heavens and of the earth, and all things that in them are")
stri_stats_latex(BOM$scripture_text)
NamesBOM <- str_count(str_to_lower(BOM$scripture_text), "the Father of the heavens and of the earth| and all things that in them are")
NamesBOM <- sum(NamesBOM)
pander(NamesBOM)
#4 times this is mentioned. But I would have to do this a billion times for each name. 

Names2 <- 

