
#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)

precipData <- read.csv("RankPrecip.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
        titlePanel("100 Greatest Hourly Precipitation Events"),
        sidebarLayout(
          sidebarPanel(
            checkboxGroupInput(inputId = "StationName", 
                               label = "Select Cities:",
                               choices = c("Atlanta" = "ATLANTA HARTSFIELD INTERNATIONAL AIRPORT GA US" ,
                                           "Boston" = "BOSTON MA US",
                                           "Chicago" = "CHICAGO MIDWAY AIRPORT IL US",
                                           "Detroit" = "DETROIT CITY AIRPORT MI US",
                                           "Los Angeles" = "LOS ANGELES INTERNATIONAL AIRPORT CA US",
                                           "Miami" = "MIAMI INTERNATIONAL AIRPORT FL US",
                                           "Philedelphia" = "PHILADELPHIA INTERNATIONAL AIRPORT PA US",
                                           "San Francisco" = "SAN FRANCISCO INTERNATIONAL AIRPORT CA US",
                                           "DC" = "WASHINGTON REAGAN NATIONAL AIRPORT VA US"))),
          mainPanel(
            plotOutput(outputId = "coolplot",
                       height = "400px")
          )
        )
      )

server <- function(input, output, session) {
  filtered <- reactive({
    print(eval(input$StationName))
    precipData %>% 
      filter(StationName %in% eval(input$StationName))
  })
  
  
  output$coolplot <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(x=Year, y=Precipitation, color=StationName)) + geom_point(shape=21, size=3) + theme(axis.ticks.x = element_blank(), axis.ticks.y = element_blank(), axis.title.x = element_blank(), panel.background = element_rect(fill="white"), legend.position = "right", legend.background = element_blank(), legend.key = element_blank()) + guides(colour = guide_legend(ncol = 1)) + xlim(1950,2016)
    
  })
  
}

shinyApp(ui = ui, server = server)



