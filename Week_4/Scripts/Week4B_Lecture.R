# Today we are going to practice tidy with biogeochemitry from Hawaii
# Kevin Candray 
# 2021 - 02 - 17

#####################################
#loading the libs
library(tidyverse)
library(here)

######################################
#loading the data

ChemData <-read_csv(here("Week_4","Data","chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)
#viewing the data, there are a few NAs, there are several ways to remove 
ChemData_clean<- ChemData %>% 
  filter(complete.cases(.)) %>% #filters out everything that is not a complete row
  separate(col = Tide_time, #choose the tide_time column 
           into = c("Tide","Time"), #separate it into two columns: Tide and Time
           sep = "_",#separate by _
           remove = FALSE) %>% #keep og tide_time column 
  unite(col = "Site_Zone",#the new name of the NEW column
        c(Site,Zone), #the column to unite
        sep = ".", #put a . in the middle
        remove = FALSE) %>%  #keep the og 
  pivot_longer(cols = Temp_in:percent_sgd, #the cols you want to pivot
               names_to= "Variables", #the name of the new cols with all the column names
               values_to = "Values") %>%  # nams of the new column with all the values
  group_by(Variables, Site) %>% 
  summarise(Param_means = mean(Values, na.rm = TRUE),
            Param_vars = var(Values, na.rm = TRUE))
head(ChemData_clean)
View(ChemData_clean)
#separate function:
  #data = [data frame ur using]
1#col = column that you want to separate
#into = name of the new columns
#sep = what are you separating by 
