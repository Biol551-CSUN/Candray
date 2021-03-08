#Kevin Candray 
# 2021 March 8
#Week 7A Lecture
####################################
#loading the libs
library(tidyverse)
library(here)
library(maps)
library(mapdata)
library(mapproj)
####################################
# Read in data on population in California by county
popdata<-read_csv(here("Week_7","Data","CApopdata.csv"))
#read in data on number of seastars at different field sites
stars<-read_csv(here("Week_7","Data","stars.csv"))

#get data for entire world
world <- map_data("world")
head(world)
usa <-map_data("usa")
head(usa)
italy<-map_data("italy")
head(italy)
states<-map_data("state")
head(states)
counties<-map_data("county")
head(counties)

#make a map of the world
ggplot()+
  geom_polygon(data = world, aes(x= long, y=lat, group=group, fill=region),
               color = "black")+
  guides(fill=FALSE)+
  theme_minimal()+
  theme(panel.background = element_rect(fill="lightblue"))+
  coord_map(projection = "sinusoidal",
            xlim = c(-180,180))
###############################################
#map of just california 
head(states)
#filter our just cali
CA_data <- states %>% 
  filter(region == "california")
ggplot()+
  geom_polygon(data = CA_data, aes(x= long, y=lat, group=group, fill=region),
               color = "black")
# wrangle the data 
CApop_county <- popdata %>% 
  select("subregion"= County, Population) %>%  #rename the county col
  inner_join(counties) %>% 
  filter(region == "california") #some counties have same names in other states
ggplot()+
  geom_polygon(data = CApop_county,
               aes(x=long, y= lat, group = group, fill = Population),
               color= "black")+
  geom_point(data = stars, 
             aes(x= long, y= lat, size = star_no))+
  coord_map()+
  theme_void()+
  scale_fill_gradient(trans="log10")+
  labs(size = "# stars/m2")+
  ggsave(here("Week_7","Output","CApop.pdf"))
