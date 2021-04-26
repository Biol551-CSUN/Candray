#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# **** solutions! ***** #
# 1) Change the dog breed selectInput() to radio buttons.
# 2) See how the dogs dataframe is filtered the same way in each output obejct? Turn the filtered dogs dataframe into a reactive object instead, using rdogs <- reactive().

library(tidyverse)
library(kableExtra)
library(shiny)
library(here)
library(lubridate)
library(shinythemes)

BabyData<-read_csv(here("Week_10", "Data", "HatchBabyExport.csv")) 

BabyWeight <- BabyData %>%
    filter(Activity == "Weight")%>%
    separate(col = `Start Time`, 
             into = c("Date", "Time"), 
             sep = " ")%>%
    separate(col = Date, 
             into = c("Day", "Month", "Year"), 
             sep = "/")%>%
    mutate(., Date = paste(Year, Month, Day, sep = "-"))%>%
    select(-Time, -'End Time', -Percentile, -Duration, -Info, -Notes, -X10, -Day, -Month, -Year)


BabyFeeding <- BabyData %>%
    filter(Activity == "Feeding")%>%
    separate(col = `Start Time`, 
             into = c("Date", "Time"), 
             sep = " ")%>%
    separate(col = Date, 
             into = c("Day", "Month", "Year"), 
             sep = "/")%>%
    select(-Time, -'End Time', -Percentile, -Duration, -Notes, -X10, -Year)

view(BabyWeight)
# Define UI#############################################################
ui <- fluidPage(
    # Some custom CSS for a smaller font for preformatted text
    tags$head(
        tags$style(HTML("
      pre, table.table {
        font-size: smaller;
      }
    "))
    ),
    
    fluidRow(
        column(width = 4, wellPanel(
            radioButtons("Baby Name", "Baby Name:",
                         c("Blakely",
                           "Micah")
            )
        )),
        column(width = 4,
               # In a plotOutput, passing values for click, dblclick, hover, or brush
               # will enable those interactions.
               plotOutput("birthdayPlot", height = 350,
                          # Equivalent to: click = clickOpts(id = "plot_click")
                          click = "plot_click",
                          dblclick = dblclickOpts(
                              id = "plot_dblclick"
                          ),
                          hover = hoverOpts(
                              id = "plot_hover"
                          ),
                          brush = brushOpts(
                              id = "plot_brush"
                          )
               )
        )
    ),
    fluidRow(
        column(width = 3,
               verbatimTextOutput("click_info")
        ),
        column(width = 3,
               verbatimTextOutput("dblclick_info")
        ),
        column(width = 3,
               verbatimTextOutput("hover_info")
        ),
        column(width = 3,
               verbatimTextOutput("brush_info")
        )
    )
)
# Show a plot of the city-wide distribution
mainPanel(
    column(
        6,
        h4("Weight over time for each baby"),
        plotOutput("birthdayPlot")
    )
) # /mainPanel

    ##################################################################    
# Application title
titlePanel("Twin Baby Stats")

# Server logic########################################################

##################################################################
server <- function(input, output) {
    rbabies <- reactive(BabyWeight %>%
                            filter(`Baby Name` == input$`Baby Name`))
    output$birthdayPlot <- renderPlot({
        if (input$'Baby Name' == "Blakely") {
            rbabies() %>% 
            ggplot(aes(
                x = factor(Date),
                y = Amount
            )) +
                geom_point() +
                xlab("Date") +
                ylab("Weight of Baby") +
                theme_classic(base_size = 16)+
                theme(axis.title = element_text(size = 13),  # make axis font larger
                      axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 1), # change the angle of the x axis text to see it all
                      plot.title = element_text(hjust = 0.5))
        } else if (input$'Baby Name' == "Micah") {
            rbabies() %>% 
            ggplot(aes(
                x = factor(Date),
                y = Amount
            )) +
                geom_point() +
                xlab("Date") +
                ylab("Weight of Baby") +
                theme_classic(base_size = 16)+
                theme(axis.title = element_text(size = 13),  # make axis font larger
                      axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 1), # change the angle of the x axis text to see it all
                      plot.title = element_text(hjust = 0.5))
        }
    })
    
    output$click_info <- renderPrint({
        cat("input$plot_click:\n")
        str(input$plot_click)
    })
    output$hover_info <- renderPrint({
        cat("input$plot_hover:\n")
        str(input$plot_hover)
    })
    output$dblclick_info <- renderPrint({
        cat("input$plot_dblclick:\n")
        str(input$plot_dblclick)
    })
    output$brush_info <- renderPrint({
        cat("input$plot_brush:\n")
        str(input$plot_brush)
    })
    
}
# Run the application
shinyApp(ui = ui, server = server)
