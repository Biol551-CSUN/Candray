#First Script. Learning how to import data
  #created by: Kevin Candray 
  #created on: 2021-02-03
##############################################
#load the libraries 
library(tidyverse)
library(here)
##############################################
#reading the data
WeightData <- read_csv(here("Week_2", "data", "weightdata.csv"))
##############################################
#data anaylsis
head(WeightData)
#looks at the top 6 lines of the dataframe
tail(WeightData)
#looks at the bottom 6 lines of the dataframe
View(WeightData)
