# load the libs of for the day 
library(tidyverse)
library(here)
#############################
# FOR LOOPS; PROCESS OF DOING SOMETHING OVER AND OVER AGAIN
print(paste("The year is", 2000))

# putting it in a for loop
years<-c(2015:2021)
for(i in years){#set up the for loop where i is the index
  print(paste("The year is",i))#loop over i
}
### above is just printing something over and over#####
#pre-allocate space for the for loop
# empty matrix
year_data<-data.frame(matrix(ncol=2, nrow=length(years)))
# add column names
colnames(year_data)<-c("year","year_name")
year_data
#####now that we allocated space, merge the two kind of########
for (i in 1:length(years)) {#setup the for loop where i is the index
  year_data$year_name[i]<-paste("The year is", years[i])#loop over year name
  year_data$year[i]<-years[i]#loop over year
}
year_data
##############################################
#USING LOOPS TO READ IN MULTIPLE .CSV FILES
testdata<-read_csv(here("Week_13", "Data","011521_CT316_1pcal.csv"))
glimpse(testdata)

# point the location on the comupter of the folder
CondPath<-here("Week_13","Data","cond_data")
# list all the files in that path with a specidfic pattern 
# in this case we are looking for everything that has a .csv in the filenname

#you can use regex to be more specific if you are looking for certain patterns
files<-dir(path = CondPath,pattern = ".csv")
files
################allocate space########################
# pre-allocate space
# make an empty dataframe that has one row for each file and 3 columns
cond_data<-data.frame(matrix(nrow = length(files), ncol = 3))
# give the dataframe column names
colnames(cond_data)<-c("filename","mean_temp", "mean_sal")

cond_data

raw_data<-read.csv(paste0(CondPath,"/",files[1]))#test by reading in the first file and see if it works
head(raw_data)

mean_temp<-mean(raw_data$Temperature, na.rm = TRUE) # calculate a mean
mean_temp

#################turning it into a for loop###############
for (i in 1:length(files)) {#loop over 1:3 the number of files
raw_data<-read.csv(paste0(CondPath,"/",files[i]))
cond_data$filename[i]<-files[i]
cond_data$mean_temp[i]<-mean(raw_data$Temperature, na.rm =TRUE)
cond_data$mean_sal[i]<-mean(raw_data$Salinity, na.rm =TRUE)
}
cond_data
#############################PURRRRRRRRRRRRRRR####################
1:10 # a vector from 1-10
1:10 %>% 
  map(rnorm, n=15) %>%  #calculate 15 random numbers based on a normal distribution 
  map_dbl(mean) #calculate the mean. It is now a vector which is a type "double"

# make your own function 
1:10 %>% # list 1:10
  map(function(x) rnorm(15, x)) %>% # make your own function
  map_dbl(mean)

#use a formula when u want to change the arguments within the function 
1:10 %>%
  map(~ rnorm(15, .x)) %>% # changes the arguments inside the function
  map_dbl(mean)

#fidn files
# point to the location on the computer of the folder
CondPath<-here("Week_13", "data", "cond_data")
files <- dir(path = CondPath,pattern = ".csv")
files

files <- dir(path = CondPath,pattern = ".csv", full.names = TRUE)

data<-files %>%
  set_names()%>% # set's the id of each list to the file name
  map_df(read_csv,.id = "filename") %>%  # map everything to a dataframe and put the id in a column called filename
  group_by(filename) %>%
  summarise(mean_temp = mean(Temperature, na.rm = TRUE),
            mean_sal = mean(Salinity,na.rm = TRUE))
data
