#kevin Candray 
# week 12B Lecture
# 4-21-20
###########################################
# loading the libs for the day
library(tidyverse)
library(here)
###########################################
#loading the data
tuesdata <- tidytuesdayR::tt_load(2021, week = 7)
income_mean<-tuesdata$income_mean
###########################################
# WHAT IS A FACTOR
  #specialized version of a character, stored as categorical, value of the factor takes are called levels
  #allows you to order data in specific ways
  #deafult levels are alphabetical 
#to make something a factor
fruits<-factor(c("Apple","Grape","Banana"))
fruits
#FACTOR BOOBY-TRAPS
test<-c("A", "1", "2")
as.numeric(test)
# lets test was a facotr 
test<-factor(test) # covert to factor
as.numeric(test)
##########################################
#difference btwn read.csv(), and read_csv() is that _strings will be characters and . strings will be factors
##########################################
#FORCATS
glimpse(starwars)
star_counts<- starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  mutate(species = fct_lump(species, n=3)) %>% 
  count(species)
star_counts
#########################################
#reordering factors
star_counts %>%
  ggplot(aes(x = fct_reorder(species,n,.desc = TRUE),y = n))+#reorde the factor of species
  geom_col()+
  labs(x="Species")
#########################################
glimpse(income_mean)

total_income<-income_mean %>%
  group_by(year, income_quintile)%>%
  summarise(income_dollars_sum = sum(income_dollars))%>%
  mutate(income_quintile = factor(income_quintile)) # make it a factor

total_income%>%
  ggplot(aes(x = year, y = income_dollars_sum, 
             color = fct_reorder2(income_quintile,year,income_dollars_sum)))+
  geom_line()+
  labs(color = "income quantile")
########################################
x1 <- factor(c("Jan", "Mar", "Apr", "Dec"))
x1

x1 <- factor(c("Jan", "Mar", "Apr", "Dec"), levels = c("Jan", "Mar", "Apr", "Dec"))
x1
##########################################
starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # make species a factor
  filter(n>3) %>% # only keep species that have more than 3
  droplevels() %>%  #drop extra levels
  mutate(species = fct_recode(species, "Humanoid"="Human"))
starwars_clean
# check the levles of the factor
levels(starwars_clean$species)
