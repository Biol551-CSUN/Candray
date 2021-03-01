################################################
#Kevin Candray 
#Week 4b Lab Assignment
#2021-02-17
#####################################
#loading the libs
library(tidyverse)
library(here)
#####################################
#loading the chemistry data
ChemData <- read_csv(here("Week_4","Data","chemicaldata_maunalua.csv"))
View(ChemData)
#noted that there are some NAs in the data 
glimpse(ChemData)
#there are 15 columns, and 355 rows
######################################
#cleaning the data
  #removing the NAs
ChemData_sum <- ChemData %>% #renaming the better version of data with no NAs as ChemData_sqkey
  filter(complete.cases(.)) %>% #function to filter for ONLY complete cases
  separate(col = Tide_time,
           into = c("Tide","Time"),
           sep = "_") %>% 
  filter(Season == "SPRING") %>%
  pivot_longer(cols = Temp_in:percent_sgd, #pivot columns into long columns
               names_to = "Variables", #one column for all the variable names
               values_to =  "Values") %>% #one column for all the values
  group_by(Variables, Site, Tide) %>% #select columns
  summarise (Value_means = mean(Values, na.rm = TRUE)) %>% #means
  pivot_wider(names_from = Variables, #wide format
              values_from = Value_means)
View(ChemData_sum)
#########################################
#dataframe
ChemData_sqkey <- ChemData %>% 
  filter(complete.cases(.)) %>% 
  separate(col = Tide_time,
           into = c("Tide","Time"),
           sep = "_") %>% 
  rename("Nitrate + Nitrite (umol/L)" = "NN", #change name of variables
         "Percent SGD" = "percent_sgd",
         "Total Alkylinity (umol/L)" = "TA",
         "Temperature (C)" = "Temp_in",
         "Phosphate (umol/L)" = "Phosphate",
         "Silicate (umol/L)" = "Silicate") %>%
  pivot_longer(cols = c("Temperature (C)", "Phosphate (umol/L)":"Percent SGD"), #pivot to long format
               names_to = "Variables", #one column for all the variable names
               values_to =  "Values") %>% #one column for the values
  mutate(Site = ifelse(Site == "BP", "Black Point", "Wailupe")) # rename sites
View(ChemData_sqkey)
###########################################
#plot
ggplot(data = ChemData_sqkey, #use ChemData_sqkey
       aes(x = Salinity, #put salinity on x axis
           y = Values, #put values of each variable on y axis
           color = Site)) + #color by site
  geom_line() + #make it a line graph
  theme_bw() +
  theme(legend.position = c(0.63, 0.15), #move legend into empty space
        legend.background = element_blank(), 
        plot.margin = margin(60, 60, 30, 30)) + #put margin around plot
  facet_wrap(~Variables, scales = "free") + #make one plot for each variable
  labs(y = " ")+ #remove redundant y label
  ggsave(here("week_4","Output","ChemPlot.png"),
         width = 9, height = 9)
