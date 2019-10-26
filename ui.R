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
        sidebarUserPanel(image ="uefalogo.png",name = "" ),
        
        
        
        
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

       
        tabItems(
            tabItem(tabName = "map",
                    fluidRow(infoBoxOutput("maxgoal"),
                             infoBoxOutput("minBox"),
                             infoBoxOutput("avgBox")))),
                    
        
    fluidRow(
            column(12, plotOutput("uefa"))
            ),
        
        fluidRow(
            column(12, plotOutput("uefaav"))
        )
        
        )
    
    
    
    #end of body
)