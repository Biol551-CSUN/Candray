#2021 - 02 - 10
#We will be plotting penguin data
#Kevin Candray 
###############################
library(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce)
########################################
#loading the data
glimpse(penguins)
##########################################
#data analysis
plot1 <- ggplot(data = penguins, mapping = aes(x=bill_depth_mm,
                                      y=bill_length_mm,
                                      group = species,
                                      color = species))+
  geom_point()+
    geom_smooth(method = "lm")+ #any formula can fit where the "lm" is
    labs(x="Bill depth (mm)",
         y= "Bill length (mm)")+
    scale_color_manual(values = beyonce_palette(10))+
    theme_bw()+
    theme(axis.title = element_text(size=20,
                                    color = "red"),
          panel.background = element_rect(fill = "linen"))+
    ggsave(here("Week_3","Output","penguin.png"),
           width = 7,height = 5)#in inches
    #coord_polar("x")#make the polar
    #coord_fixed()
    #coord_flip()#flip x and y axes
    #scale_color_viridis_d()+
    #scale_x_continuous(breaks = c(14,17,21),
                      # labels = c("low","medium","high"))
    #scale_x_continuous(limits = c(0,20))+ #set x limits from 0 to 20
    #scale_y_continuous(limits = c(0,50)) #set y limits from 0 to 50
#naming scheme for scale 
#anytime you make a vectoryou need to put "c" which means "concentrate"
  #scale_color_continuous()
  #scale_x_continuous()
#Coordinates - manipulating it 
    #coord_flip()
    #     fixed
    #     trans()
    #     polar()
    #     map()
  #transforming the x and y axis (log 10)
    #coord_trans(x ="log10", y = "log10")
##########################################
#LAB ASSIGNMENT

    