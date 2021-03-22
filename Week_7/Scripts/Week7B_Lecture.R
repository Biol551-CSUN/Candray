#Kevin Candray 
# March 10 2021
# Week 7B Lecture
######################################
#installed packaged, ggmaps and ggsn 
######################################
#load the libs
library(ggmap)
library(tidyverse)
library(here)
library(ggsn)

register_google(key = "AIzaSyBXeJgX4y-vRmwWlt8B5YcU3rOP2qCheaI")

ChemData <- read_csv(here("Week_7","Data","chemicaldata_maunalua.csv"))
glimpse(ChemData)

#get map function 

Oahu <- get_map("Oahu")

