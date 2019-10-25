#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(tidyverse)
library(shinydashboard)
getwd()

data = read.csv('uefa.csv', stringsAsFactors=FALSE)
team =data%>%select(.,HomeTeam,AwayTeam)
action=data%>%select(.,-HomeTeam,-AwayTeam,-X)


dashboardPage(
    dashboardHeader(
        
        title = "UEFA DASHBOARD",
        
        
        dropdownMenu(
            
            
        
            notificationItem("shinydashboard", icon = icon("users"),
                             href = "https://rstudio.github.io/shinydashboard/")
        )),
    
    #side bar
    dashboardSidebar(
        
        sidebarMenu(
            menuItem("Summary", tabName = "map", icon = icon("map")),
            menuItem("Data", tabName = "data", icon = icon("database")),
            hr(),
            selectInput(inputId ="teams", 
                        label = "Team:", 
                        choices =  colnames(team)),
            
            selectInput( inputId= "actions", 
                         label =  "Action:", 
                        choices =  colnames(action))
           
        )
    ),
    #end of side bar
    
    #body
    dashboardBody
    (

       # start test
        fluidRow(style='margin: 0px;',
                 box(width='100%',
                     infoBox("Total Home Team" ,"Screened", icon = icon('users'), width = 6),
                     infoBox("Total Away Team" ,"Screened", icon = icon('male'), width = 
                                 6),)),
        
        
        
        fluidRow(
            column(12, 
                   plotOutput("uefa"))
            
        )
        
        
        #test
    )
    
    #end of body
)