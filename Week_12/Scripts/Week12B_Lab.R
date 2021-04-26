# Kevin Candray 
# WEEk 12B Lab 
# Intertidal data 
#######################################
# load libs
library(here)
library(janitor)
library(tidyverse)
library(readr)
#######################################
# load the data
intertidaldata <- read_csv("Week_12/Data/intertidaldata.csv")
View(intertidaldata)
#######################################
#cleaning
unique(intertidal_clean$quadrat)

intertidal_clean <- intertidaldata %>% 
  clean_names() %>% 
  mutate(quadrat = str_replace(quadrat, pattern = "\\.", replacement = "")) %>% 
  mutate(quadrat = str_replace_all(quadrat, pattern = "[:digit:]", replacement = "")) %>%
  mutate(quadrat = str_trim(quadrat, side = "right"))

View(intertidal_clean)
unique(intertidal_clean$quadrat)
#########################################
level_order <-c('Low','Mid','High')
intertidal_clean %>% 
  ggplot(aes(x = factor(quadrat,level = level_order), y= gooseneck_barnacles,
             fill = site))+
  geom_col(show.legend = FALSE)+
  theme_bw()+
  theme(legend.position = c(1.25, 0.50), #move legend into empty space
        legend.background = element_blank(), 
        plot.margin = margin(60, 60, 30, 30))+
  facet_wrap(~site, ncol = 3, scales = "free")+
  labs(y = "Number of Gooseneck Barnacles",
       x= "Tide Level",
       title= "Amount of Gooseneck Barnacles at Sites")+
  ggsave(here("Week_12","Output","intertidal.png"),
         width = 9, height = 9)
