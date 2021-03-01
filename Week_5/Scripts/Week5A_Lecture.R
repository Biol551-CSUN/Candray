#Kevin Candray
#2021-02-22
#Week 5A Lecture
######################################
#intro to diff types of join 
#join functions to compile multiple hierarchies of data 
#whenever u r collecting data, have unique IDs to match throughout the data
#####################################
#load libs
library(tidyverse)
library(here)
#####################################
#load the data
# Environmental data
EnviroData <- read_csv(here("Week_5","Data","site.characteristics.data.csv"))
# Thermal performance Data
TPCData <- read_csv(here("Week_5","Data","Topt_data.csv"))

glimpse(EnviroData)
glimpse(TPCData)
#pivot the data
#TPCData is in wide format and EnviroData is long format
#changing to both the same format
EnviroData_wide <- EnviroData %>% 
  pivot_wider(names_from = parameter.measured,
              values_from = values)
View(EnviroData_wide)
#sort the data to put in a particular order
EnviroData_wide <- EnviroData %>% 
  pivot_wider(names_from = parameter.measured, # pivot the data wider
              values_from = values) %>%
  arrange(site.letter) # arrange the dataframe by site
View(EnviroData_wide)
#left_join()
#within this data, the common variable name is site.letter, therefore left join 
FullData_left <- left_join(TPCData, EnviroData_wide) %>% 
  relocate(where(is.numeric), .after=where(is.character))
head(FullData_left)
####################################
#Think Pair Share
FullData_leftlong <- FullData_left %>% 
  pivot_longer(cols = c(5:23),
               names_to = "variables",
               values_to = "values") %>% 
  group_by(site.letter) %>% 
  summarise(Means = mean(values, na.rm = TRUE),
            Variations = var(values, na.rm = TRUE))
View(FullData_leftlong)
##########################################
#creating a tibble
#make 1 tibble
T1 <- tibble(Site.ID = c("A","B","C","D"),
             Temperature = c(14.1, 16.7, 15.3, 12.8))
T2 <- tibble(Site.ID = c("A","B","D","E"),
             pH = c(7.3, 7.8, 8.1, 7.9))
#left join T1, T2, join to T1
#right join T1, T2, join to T2
left_join(T1,T2)
right_join(T1,T2)
#inner join keeps full data sets
#full join keeps everything
inner_join(T1,T2)
full_join(T1,T2)
#semi join all rows from the first data set, just column from the first data set
#anti join saves all rows in the first data set that do not match anything in the second
semi_join(T1,T2)
anti_join(T1,T2)
###############################################
#R package of the day
library(cowsay)
say("hello sharkcoochie board", by = "shark")
