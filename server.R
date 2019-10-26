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


actionsi=data%>%select(.,-HomeTeam,-AwayTeam,-X)



# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
    
    
    observe({
        
        actions <- unique(colnames(actionsi%>%select(.,contains(substr(input$teams, 1, 4)))))
        updateSelectizeInput(
            session, "actions",
            choices = actions,
            selected = actions[1])
    })
    
    
    
output$uefa <- renderPlot(
    
    data%>%group_by(input$teams) %>% ggplot(aes(x = !!sym(input$teams), y = !!sym(input$actions)))
            + geom_bar(stat = "identity",fill=I("blue"),alpha = .2 ) 
            + theme(axis.text = element_text(size = 12))
            + guides(color = "none")
            + ggtitle(str_to_upper(paste("TOTAL",input$actions," of",input$teams , "FOR THE SEASON")))
            + xlab(str_to_upper(input$teams)) 
            + ylab(str_to_upper(input$actions)) 
            + scale_fill_gradient("Count", low="green", high="red")
            
)

output$uefaav <- renderPlot(
    
    data%>%group_by(input$teams) %>% ggplot(aes(x = !!sym(input$teams), y = !!sym(input$actions)))
    + geom_boxplot() 
   
    
    
)

output$minBox <- renderInfoBox({
    
    total=nrow(unique(select(data,input$teams)))
    infoBox(total, paste("Total of",input$teams), icon = icon("hand-o-down"))
})

output$maxgoal <- renderInfoBox({
    
    total=nrow(unique(select(data,input$teams)))
    infoBox( paste("Total of",input$teams),total, icon = icon("hand-o-down"))
})


    
    
    

})
