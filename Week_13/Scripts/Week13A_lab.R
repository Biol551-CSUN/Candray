# Kevin Candray 
# Lab assignment for Week 13
#######################################
#loaidng the libs
library(tidyverse)
library(here)
#######################################
#read in one csv to see what we are looking at 
hwdata<-read_csv(here("Week_13","Data","homework","TP1.csv"))
glimpse(hwdata)

#point the location on the computer folder
HWPath<-here("Week_13","Data","homework") #determine path 

#list all the files in that path with a specific pattern 
files<-dir(path = HWPath,pattern = ".csv") #name the path and distinguish pattern 
files
##############################################
# allocate space for the new raw data to develop 
hw_data<-data.frame(matrix(nrow = length(files),ncol = 5))
#give names to the dataframe
colnames(hw_data)<-c("filename","meantemp","devtemp","meanlight","devlight")
hw_data$meantemp[i]<-mean()

#################################################
# for loop method
raw_data<-read_csv(paste0(HWPath,"/",files[1])) # test by reading in the first file and see if it works
head(raw_data) # look at the head of the data
mean_temp<-mean(raw_data$Temp.C, na.rm = TRUE) # calculate a mean

for (i in 1:length(files)) { #start of for loop, i as index and using tyhe 4 CSVs
  raw_data<-read_csv(paste0(HWPath,"/",files[i]))
  hw_data$filename[i]<-files[i]
  hw_data$meantemp[i]<-mean(raw_data$Temp.C,na.rm = TRUE) #find mean temp
  hw_data$devtemp[i]<-sd(raw_data$Temp.C, na.rm = TRUE) #find sd temp
  hw_data$meanlight[i]<-mean(raw_data$Intensity.lux, na.rm = TRUE) #find mean light
  hw_data$devlight[i]<-sd(raw_data$Intensity.lux, na.rm = TRUE)#find sd light
}
hw_data
#################################################
########PURRRRRRRRRRR
# no need to allocate space just begin 

pur_data<-files %>% #pulling from all the files from that path 
  set_names() %>%  #set's the ID of each list to the the file name
  map_df(read_csv,.id = "filename") %>%  #map everything to a dataframe and put the ID in a column called filename
  group_by(filename) %>%
  summarise(mean_temp = mean(Temp.C, na.rm=TRUE), # find the mean temp
            sd_temp = sd(Temp.C, na.rm = TRUE),#to finf SD of temp
            mean_light = mean(Intensity.lux, na.rm=TRUE), # to find the mean light
            sd_light = sd(Intensity.lux, na.rm=TRUE)) # to find dev of light
pur_data # call in new formed data set
