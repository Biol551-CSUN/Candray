#Kevin Candray
#2021-02-24
#Week 5B LAB
######################################
#installed lubridate package
library(tidyverse)
library(here)
library(lubridate)
######################################
CondData <- read_csv(here("Week_5","Data","CondData.csv"))
DepthData <- read_csv(here("week_5","Data","DepthData.csv"))
#read in the data
View(CondData)
View(DepthData)

#CONDDATA PIPE
ConData_sqkey <- CondData %>% 
  mutate(DateTime = ymd_hms(date)) %>% 
  mutate(DateTime + seconds(8)) %>% 
  rename(
    "old date" = "date",
    "date" = "DateTime + seconds(8)") %>% 
  select()
FullData <- inner_join(ConData_sqkey, DepthData)
View(FullData)
Fulldata %>% 
  mutate(time_hour = hour(date)) %>%
  mutate(time_minute = minute(date))

