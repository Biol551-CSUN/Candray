#Week 4A Lab assignment: 1 and 2
#Created on 2021-02-15
#Created by: Kevin Candray 
############################################
# loading the libraries
library(palmerpenguins)
library(tidyverse)
library(here)
####################################
#loading the data
glimpse(penguins)
####################################
#calculating the mean of body mass by species, island, and sex without any NAs
LabData1<- penguins %>% #gettiing the penguin data
  drop_na(species, island, sex) %>%  #dropping all NA in data within the columns species, island, sex
  group_by(species, island, sex) %>% #grouping by species, island, and sex
  summarise(mean_body_mass_g = mean(body_mass_g), #creates new column for mean and variance of body mass
            var_body_mass_g = var(body_mass_g))
#######################################################
LabData2 <- penguins %>% #getting the penguin data
  drop_na(species, island, sex) %>% #dropping any NA that is within the categories
  filter(sex != "male") %>% #filtering for only females
  group_by(species, island,sex) %>%  #grouping by species, island, and sex
  summarise(log_body_mass = log(body_mass_g)) %>% #creating new column for log body mass
##########################################################################
 ggplot(aes(x = island, y = log_body_mass))+ #set up axes for plot
    geom_boxplot()+
  labs(title= "Island vs Female Body Mass", #tite for graph
       x="", #x axis title 
       y= "Body Mass (Log)")+ #y axis title
  facet_wrap(~island)+ #3 different plots, 1 per island
  theme_bw()+ #settinf theme to bw
  theme(axis.title = element_text(size=20,
                                  color = "red"), #changing the font size and color of title
        panel.background = element_rect(fill = "linen"))+ #fill in the background plot color with linen 
  ggsave(here("Week_4","Output","IslandFemaleBodyMass.png"),
         width = 7,height = 5)# saving png file to week 4 folder in output in inches 
