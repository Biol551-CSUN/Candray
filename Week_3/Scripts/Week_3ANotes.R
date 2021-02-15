#Notes on Week 3A PowerPoint
#starting on slide 39
##########################
#things that are bad

  #dont use the deafult, add extra lines
  #color gradients with a single color is bad, should have 2
  #no shadows
  #no 3D
  #dont use too many legends
  #dont overuse colors
################################
#need 2 lines of code to make a deafult graph
library(palmerpenguins)
library(tidyverse)
glimpse(penguins)
ggplot(data=penguins,#appears as blank box, this just says I WANT TO USE THIS DATAFRAME
       mapping = aes(x= bill_depth_mm,
                     y= bill_length_mm,
                     color = species,
                     shape= species))+
        geom_point()+
          labs(title = "Bill depth and length",
               subtitle = "Dimensions for Adelie, Chinstap, and Gentoo Penguins",
               x= "Bill depth (mm)", y="Bill length (mm)",
               color="species",
               caption = "Source: Palmer Station LTER / palmerpenguins package")+
scale_color_viridis_d()
#alpha add transperancy 
#mapping vs setting 
#mappiing is for setting up the graph 
#setting is setting up the graph to make it look good 
#faceting, smaller plots that displat different subsets of the data
ggplot(penguins,
      aes(x=bill_depth_mm,
          y=bill_length_mm,
          color = species))+
  geom_point()+
  scale_color_viridis_d()+
  facet_grid(species~sex)+
  guides(color= FALSE)
#facet grid, makes a grid
#facet wrap, more felxible, can work it how you want 
ggplot(penguins,
       aes(x=bill_depth_mm,
           y=bill_length_mm))+
  geom_point()+
  facet_wrap(~species, ncol =2)
#there are many resources on ggplot2
#links in the powerpoint, slide 77
#Tidy Tuesday INFO NEXT CLASS, expect first one due next tuesday

