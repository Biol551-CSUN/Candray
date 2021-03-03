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
  rename(date_old = date) %>% 
  rename(na_date = DateTime) %>% 
  rename(date = "DateTime + seconds(8)") %>% 
  select(-date_old, -na_date)
FullData <- inner_join(ConData_sqkey, DepthData)
View(FullData)
FullData <- FullData %>% 
  mutate(time_hour = hour(date)) %>%
  mutate(time_minute = minute(date)) %>% 
  group_by(time_hour, time_minute) %>% 
  summarise(mean_date = mean(date), 
            mean_depth = mean(Depth),  
            mean_temperature = mean(TempInSitu),  
            mean_salinity = mean(SalinityInSitu_1pCal))%>%
  write_csv(here("Week_5","Data","FullData.csv"))

#########################################
#plot
FullData %>% # name the data frame 
  ggplot(aes(x = mean_temperature, # name x axis 
             y = mean_depth, # name y axis 
             color = mean_salinity))+
  geom_line()+
  labs(title = "Average Temperature, Depth and Salinity",
       x= "Average Temp (Celcius)", 
       y= "Average Depth (Meters)")+
  theme_classic()+
  theme(axis.title = element_text(size = 12))
  ggsave(here("Week_5","Output","AvgTempDepthLab.png"),
         width = 7, height = 5)
