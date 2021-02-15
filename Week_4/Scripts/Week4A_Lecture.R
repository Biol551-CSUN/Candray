# Today is 2021-02-15: Week 4A
#Plotting penguin data
#Kevin Candray 
####################################
#loading the libraries 
library(palmerpenguins)
library(tidyverse)
library(here)
####################################
#loading the data 
glimpse(penguins)
####################################
#filter mechanism 
  #filter(.data=penguins, sex == "female") "" if its a word, if its a number no quotes
filter(.data = penguins, sex == "female")
# one = sets an argument in the function 
# two = reads as "exactly equal to"
# x <= y less than or equal to 
#x >= y Greater than or equal to 
# x != y not equal to
# x %in% y In(group membership)
#is.na(x) Is missing
#is.na(x) Is not missing
#######################################
#think pair share
filter(.data = penguins, body_mass_g > 5000, year == 2008)

filter(.data = penguins, sex == "female", body_mass_g > 4000)
                      # a & b and the comma can be replaced with &
                      # a | b or
                      #!a not 
#filter(.data = penguins, year == 2008|2009, island == !"Dream", species == "Adelie" & "Gentoo" )
#my attempt
#mutate : adding new columns
data2 <- mutate(.data = penguins, 
                body_mass_kg = body_mass_g/1000,
                bill_length_depth = bill_length_mm/bill_depth_mm) #convert mass to kg and calculate the ration of bill length and depth 
View(data2)
#look up mutate_if, _at, _all 
# ifelse function, do conditional tests within mutate()
data2 <- mutate(.data = penguins,
                after_2008 = ifelse(year >2008, "After 2008", "Before 2008"))
View(data2)

##########
# think pair share
data2 <- mutate(.data = penguins, 
                length_and_mass = flipper_length_mm+body_mass_g)
View(data2)
(data2 <- mutate(.data = penguins, 
                grammar = ifelse(sex == "male" , "Male", "Female")))
#pipe
data3<- penguins %>% #use penguin dataframe
  filter(sex == "female") %>% #select females
  mutate(log_mass = log(body_mass_g))%>% #calculate log bio mass
  select(species, island, sex, log_mass)
#summarize & and group by
(penguins %>%
    group_by(island, sex) %>%
  summarise(mean_flipper = mean(bill_length_mm, na.rm=TRUE),
            min_flipper = min(bill_length_mm, na.rm=TRUE)))
#removing missing data
penguins %>%
  drop_na(sex)
#pipe directly into a plot
penguins %>%
  drop_na(sex) %>%
  ggplot(aes (x = sex, y = bill_length_mm))+
  geom_boxplot()
