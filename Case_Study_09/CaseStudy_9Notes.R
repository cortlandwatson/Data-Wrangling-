####Case Study 9 Notes

#####Task 17 (Credit to Blake Cromar for helping with my code)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(plotly)
library(lubridate)
library(pander)
library(tidyquant)
library(quantmod)

#Mine
Me <- c("BTSC", "GOOG", "IBM") %>%
  tq_get(get  = "stock.prices",
         from = "2017-10-01",
         to   = "2018-04-01") %>%
  group_by(symbol) %>%
  tq_transmute(select     = adjusted, 
               mutate_fun = periodReturn, 
               period     = "daily", 
               col_rename = "Ra")

wts <- c(1/3, 1/3, 1/3)
MeReturns <- Me %>%
  tq_portfolio(assets_col   = symbol, 
               returns_col  = Ra, 
               weights      = wts, 
               col_rename   = "investment.growth",
               wealth.index = TRUE) %>%
  mutate(investment.growth = investment.growth * 1000)

#Wife
Wife <- c("AMZN", "NKE", "WMT") %>%
  tq_get(get  = "stock.prices",
         from = "2017-10-01",
         to   = "2018-04-01") %>%
  group_by(symbol) %>%
  tq_transmute(select     = adjusted, 
               mutate_fun = periodReturn, 
               period     = "daily", 
               col_rename = "Ra")

WifeReturns <- Wife %>%
  tq_portfolio(assets_col   = symbol, 
               returns_col  = Ra, 
               weights      = wts, 
               col_rename   = "investment.growth",
               wealth.index = TRUE) %>%
  mutate(investment.growth = investment.growth * 1000)

ggplot(MeReturns, aes(x = date, y = investment.growth)) +
  geom_line(size = 2, color = "green") +
  geom_line(data = WifeReturns,
            size = 2,
            color = "purple") +
  labs(title = "Yours, Mine and Ours",
       subtitle = "The red line is the one thousand dollars that we initially invested",
       x = "Purple is my wife/I am green", 
       y = "Portfolio Value") +
  theme_minimal() +
  geom_hline(yintercept = 1000, 
             color = "red", 
             size = 1)

#########TAsk18
library(dygraphs)
library(timetk)
library(DT)
library(xts)

Kroger <- tq_get("KR",
                       get = "stock.prices",
                       from = "2013-04-01",
                       to = "2018-04-01") %>%
  select(-volume) %>%
  rename(Open = open, High = high, Low = low, Close = close, Adjusted = adjusted) %>%
  tk_xts(start = 2013, freq = 1259, silent = TRUE)

dygraph(Kroger,
        ylab = "Stock Value",
        main = "Kroger Stocks") %>% 
  dyRangeSelector() 


######CaseStudy 9

#Major help from Blake Cromar's code as I did not get this Case Study.
Stocks <- c("CXW", "F", "GM",               
                   "JCP", "KR", "WDC",            
                   "NKE","T", "WDAY",             
                   "WFC", "WMT")  

Years <- 5              

Returns <- Stocks %>% 
  tq_get(get  = "stock.prices",
         from = today() - dyears(Years),  
         to   = today()) %>%                    
  select(symbol, date, adjusted) %>%
  spread(key = symbol, value = adjusted) %>%                  
  tk_xts(start =  year(today() - dyears(Years)),  
         silent = TRUE)             

wts <- c(rep(1/length(Stocks),              
             length(Stocks))) 

Investment <- 25000                        

ReturnsDaily <- Stocks %>%
  tq_get(get  = "stock.prices",
         from = today() - dyears(Years), 
         to   = today()) %>%                    
  group_by(symbol) %>%
  tq_transmute(select     = adjusted,           
               mutate_fun = periodReturn,       
               period     = "daily",            
               col_rename = "Ra")

PortfolioDaily <- ReturnsDaily %>%
  tq_portfolio(assets_col   = symbol, 
               returns_col  = Ra, 
               weights      = wts, 
               col_rename   = "investment.growth",
               wealth.index = TRUE) %>%
  mutate(investment.growth = investment.growth * Investment) %>%       
  tk_xts(start = year(today() - dyears(Years)), 
         silent = TRUE)

Volume <- Stocks %>% 
  tq_get(get  = "stock.prices",
         from = today() - dyears(Years),  
         to   = today()) %>%                   
  select(symbol, date, volume)

View(Volume)

dygraph(Returns,
        ylab = "Adjusted Value") %>% 
  dyRangeSelector()  %>%
  dyShading(from = today() - dyears(Years), 
            to = today()) 

dygraph(PortfolioDaily,
        ylab = "Value of Portfolio") %>% 
  dyRangeSelector()  

ggplot(data = Volume, aes(x = date, y = volume/1000000)) +
  geom_smooth(aes(color = symbol),
              se = FALSE)  +
  labs(title="Stock Shares Through the Years",
       x = "Date",
       y = "Volume of Shares (In Millions)",
       color = "Stock") +
  theme_minimal() 



























