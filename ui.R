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
library(DT)


data = read.csv('uefa.csv', stringsAsFactors=FALSE)
team =data%>%select(.,HomeTeam,AwayTeam)
action=data%>%select(.,-HomeTeam,-AwayTeam,-X)


dashboardPage(
    dashboardHeader(
        
        title = "UEFA DASHBOARD",
        
        
        dropdownMenu(
            
            
        
            notificationItem("check on github", icon = icon("users"),
                             href = "https://github.com/datascienceseptember/shiny_project_on_uefa")
        )),
    
    #side bar
    dashboardSidebar(
        sidebarUserPanel(image ="uefalogo.png",name = "" ),
        
        
        
        
        sidebarMenu(
            menuItem("Data", tabName = "data", icon = icon("database")),
            hr(),
            menuItem("Get Summary", tabName = "dashboard", icon = icon("home")),
            
            
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
            #tabItem(tabName = "map",
             #       fluidRow(infoBoxOutput("maxgoal"),
                         #    infoBoxOutput("minBox"),
                           #  infoBoxOutput("avgBox")),
                    
                    tabItem(tabName = "dashboard",
                            fluidRow(
                                column(12, plotOutput("uefa"))
                            ),
                            
                            fluidRow(
                                column(width = 12, offset = 0, style='padding:30px;')
                            ),
                            fluidRow(
                                column(12, plotOutput("uefaav"))
                            )
                    
                    
                    ),
                    
                    tabItem(tabName = "data",
                            fluidRow(DT::dataTableOutput("table"))
                    )
                    
                    
                    ),
        
                    
        
    
        
        )
    
    
    
    #end of body
)

