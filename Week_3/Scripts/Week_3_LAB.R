#Kevin Candray 
#2021-02-10, Lab week 3 assignment: Graph for Penguin Data
#################
#load all the libs used
library(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce)
library(ggplot2)
library(dplyr)
###################
glimpse(penguins) #to view the different columns
view(penguins)#viewed the data to see what we were working with
#######################
#will use island variable and body_mass_g variable
ggplot(data = penguins, mapping = aes(x=factor(island), #create a plot using the penguin data
                                      y=body_mass_g, #using x as islands and y body mass in g
                                      color=island
                                      ))+
  scale_color_manual(values = beyonce_palette(11
                                              ))+
  geom_violin(show.legend = FALSE)+
  facet_wrap(~species)+
      labs(x= "",
           y= "Body Mass (g)")+
        theme_light()+
        theme(axis.title = element_text(size = 15
                                        ))+
  scale_y_continuous(limits = c(2500,6500)) 
######################################################
ggsave(here("Week_3","Output","labpenguin.png"),
       width = 7, height = 5)
  #geom_density(fill="#69b3a2",color="#e9ecef",alpha=0.8)
