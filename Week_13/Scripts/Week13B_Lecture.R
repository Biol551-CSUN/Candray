# KEvin Candray 
# Week 13b Lecture

# Intro to models

# loading in the libs
library(tidyverse)
library(here)
library(palmerpenguins)
library(broom)
library(performance) # if you didn't already install from group projects install it
library(modelsummary)
library(tidymodels)
###########################################
# the anatomy of a basic linear model 
mod <- lm(y~x, data = df)
 #  lm is linear model 
#   y is dependent variabl e
# x is independent 
# df is dataframe

## multiple regression 
mod <- lm(y~x1 +x2, data = df)

##interaction teram 
mod<-lm(y~x1*x2, data = df) #the * will compute x1+x2+x1:x2
##############################################
#model the penguin data set
# Linear model of Bill depth ~ Bill length by species
Peng_mod<-lm(bill_length_mm ~ bill_depth_mm*species, data = penguins)
check_model(Peng_mod)

anova(Peng_mod)

summary(Peng_mod)

###########################################
#View the results with broom 
  # tidy the results so that it is easy to view and extract 
# Tidy coefficients
coeffs<-tidy(Peng_mod) # just put tidy() around it
coeffs

# glance() extracts R-squared, AICs, etc
# tidy r2, etc
results<-glance(Peng_mod) 
results

# argument () adds residuals and preedicted to ur original data and requires that you put both the model and data
# tidy residuals, etc
resid_fitted<-augment(Peng_mod)
resid_fitted
###############################################
# results in {modelsummary} - creates tables and plots to summarize stat models and data in R
#Model Summary
#modelsummary: Regression tables with side-by-side models.
#modelsummary_wide: Regression tables for categorical response models or grouped coefficients.
#modelplot: Coefficient plots.

#Data Summary
#datasummary: Powerful tool to create (multi-level) cross-tabs and data summaries.
#datasummary_balance: Balance tables with subgroup statistics and difference in means (aka “Table 1”).
#datasummary_correlation: Correlation tables.
#datasummary_skim: Quick overview (“skim”) of a dataset.
#datasummary_df: Turn dataframes into nice tables with titles, notes, etc.

# New model
Peng_mod_noX<-lm(bill_length_mm ~ bill_depth_mm, data = penguins)
#Make a list of models and name them
models<-list("Model with interaction" = Peng_mod,
             "Model with no interaction" = Peng_mod_noX)
#Save the results as a .docx
modelsummary(models, output = here("Week_13","output","table.docx"))

############### Model Plot ##############
library(wesanderson)
modelplot(models) +
  labs(x = 'Coefficients', 
       y = 'Term names') +
  scale_color_manual(values = wes_palette('Darjeeling1'))
##################################################
# Many model with purr,dplyr, and broom 
models<- penguins %>%
  ungroup()%>% # the penguin data are grouped so we need to ungroup them
  nest(-species) %>%  # nest all the data by species
  mutate(fit = map(data, ~lm(bill_length_mm~body_mass_g, data = .)))

models

models$fit # shows you each of the 3 models
################################################

results<-models %>%
  mutate(coeffs = map(fit, tidy), # look at the coefficients
         modelresults = map(fit, glance)) %>%   # R2 and others
  select(species, coeffs, modelresults) %>% # only keep the results
  unnest() # put it back in a dataframe and specify which columns to unnest
view(results)
