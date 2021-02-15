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
                                      color=island #color based on 3 islands
                                      ))+
  scale_color_manual(values = beyonce_palette(11
                                              ))+ #use the beyonce palette to choose the color of the graph
  geom_violin(show.legend = FALSE)+ #type of geom
  facet_wrap(~species)+ #have 3 graphs in one image
      labs(x= "",
           y= "Body Mass (g)")+ #labeling the x and y axis
        theme_light()+ #the theme of the graph
        theme(axis.title = element_text(size = 15
                                        ))+ #changing font size of the axis title
  scale_y_continuous(limits = c(2500,6500))  #change in scale to view better
######################################################
ggsave(here("Week_3","Output","labpenguin.png"), #saving the graph as png and adjusting height and width
       width = 7, height = 5)
  #geom_density(fill="#69b3a2",color="#e9ecef",alpha=0.8)
