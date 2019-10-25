#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

data = read.csv('uefa.csv', stringsAsFactors=FALSE)



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    
    
output$uefa <- renderPlot(
    
    data %>% ggplot(aes(x = !!sym(input$teams), y = !!sym(input$actions)))
            + geom_bar(stat = "identity") 
            + theme(axis.text = element_text(size = 12))
            + ggtitle("Total home team goal")
)

    
    
    

})
