# Kevin Candray 
# Shiny Lab Script for shiny app on babies
# loading the libs
library(tidyverse)
library(lubridate)
library(here)
library(readr)

#reading in the data
HatchBabyExport <- read_csv("Week_10/Data/HatchBabyExport.csv")
View(HatchBabyExport)

# Editing the data
  #noting the dates, we want to change that so that the dates and times are separate
  # and then changing the date so that it is proper language
HatchBabyExport_Weight <- HatchBabyExport %>% 
  filter(Activity == "Weight") %>% 
  separate(col = 'Start Time',
           into= c("Date","Time"),
           sep= " ") %>% 
  separate(col = Date,
           into = c("Month","Day","Year"),
           sep = "/") %>% 
  select(-Time, -`End Time`, -Percentile, -Duration, -Info, -Notes,-X10) %>%
  mutate(HatchBabyExport_Weight, Date = paste(Day, Month, Year)) %>% 
  ggplot(aes(x = Date, # name x axis 
             y = Amount, # name y axis 
             color = "Baby Name"))+
  geom_point()
HatchBabyExport_Weight
      labs(title = "Average Temperature, Depth and Salinity",
       x= "Average Temp (Celcius)", 
       y= "Average Depth (Meters)")+
  theme_classic()+
  theme(axis.title = element_text(size = 12))
ggsave(here("Week_5","Output","AvgTempDepthLab.png"),
       width = 7, height = 5)



HatchBabyExport_Feeding <- HatchBabyExport %>% 
  filter(Activity == "Feeding") %>% 
  separate(col = 'Start Time',
           into= c("Date","Time"),
           sep= " ") %>% 
  separate(col = Date,
           into = c("Month","Day","Year"),
           sep = "/") %>% 
  select(-Time, -`End Time`, -Percentile, -Duration, -Notes,-X10)%>%
  mutate(HatchBabyExport_Feeding, Date = paste(Day, Month, Year))
