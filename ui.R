library(shiny)
shiny::tags#101 tags in HTML
library(shinydashboard)
library(shinyWidgets)
shinyWidgets::shinyWidgetsGallery()#Shiny switch input
library(highcharter)#highchartOutput
library(tidyverse)#filter function
source("www/global.R")

header <- dashboardHeader(
  title = "IoT Food Processing",
  #tags$img(src="Pics/header.png",width="100%", align="left"),
  dropdownMenuOutput("messageMenu")
)#End header

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("HOME", tabName = "home", icon = icon("home")),  
    menuItem("STATISTIC", tabName = "statictics", icon = icon("dashboard")),
    menuItem("SETTINGS", icon = icon("life-ring"), tabName = "settings", badgeColor = "green")
  )
  #tags$br(),
  #tags$img(src="Pics/sanhan_tim3.jpg",width="100%"),
  #tags$img(src="Pics/sanhan_tim.png",width="100%"),
  #tags$img(src="Pics/sanhan_tim_1.jpg",width="100%")
)#End Sidebar

body <- dashboardBody(
  tabItems(
  #------------------------------HOME-----------------------------------------#
    tabItem(tabName = "home",
      #Box value --------------------------------------------------------
      fluidRow(
        column(width = 12,
          #tags$head(tags$style(HTML(".small-box {height: 50px}"))),
          valueBoxOutput("CLO1", width = 4),
          valueBoxOutput("CO21", width = 4),
          valueBoxOutput("NH31", width = 4),
        ),#End column
        column(width = 12,
          valueBoxOutput("CLO2", width = 4),
          valueBoxOutput("CO22", width = 4),
          valueBoxOutput("NH32", width = 4),
        ),#End column
        column(width = 12,
          valueBoxOutput("CLO3", width = 4),
          valueBoxOutput("CO23", width = 4),
          valueBoxOutput("NH33", width = 4),
        ),#End column
      ),#End fluidrow
            
      #Tab CO2, CLO, NH3 -----------------------------------------------
      fluidRow(
        column(width = 12,
          tabBox(id = "tabset1",height = "460px", width = 12, 
            # The id lets us use input$tabset1 on the server to find the current tab
            
            #Tab CLO
            tabPanel(id = "CLO", "Chloride",
              column(width=3,
                fluidRow(
                  column(width=12,
                    tags$h5("Range"),
                    verbatimTextOutput("clo_max_a1"),
                    tags$head(tags$style(HTML("#clo_max_a1 {font-size: 12px;}"))),
                    tags$br(),
                    verbatimTextOutput("clo_max_a2"),
                    tags$head(tags$style(HTML("#clo_max_a2 {font-size: 12px;}"))),
                    tags$br(),
                    verbatimTextOutput("clo_max_a3"),
                    tags$head(tags$style(HTML("#clo_max_a3 {font-size: 12px;}")))
                  ),
                )
              ),#End column 3
              #Do thi CLO
              column(width=9,highchartOutput("CloGraph")),#End column 9
            ),#End tab CLO
            
            #Tab CO2
            tabPanel(id = "CO2", "Carbon Dioxide",
              column(width=3,
                fluidRow(
                  column(width=12,
                    tags$h5("Range"),
                    verbatimTextOutput("co2_max_a1"),
                    tags$head(tags$style(HTML("#co2_max_a1 {font-size: 12px;}"))),
                    tags$br(),
                    verbatimTextOutput("co2_max_a2"),
                    tags$head(tags$style(HTML("#co2_max_a2 {font-size: 12px;}"))),
                    tags$br(),
                    verbatimTextOutput("co2_max_a3"),
                    tags$head(tags$style(HTML("#co2_max_a3 {font-size: 12px;}")))
                  ),
                )
              ),#End column 3
              #Do thi CO2
              column(width=9,highchartOutput("CO2Graph")),#End column 9
            ),#End tab CO2
            
            #Tab NH3
            tabPanel(id = "NH3", "Amonia",
                     column(width=3,
                            fluidRow(
                              column(width=12,
                                     tags$h5("Range"),
                                     verbatimTextOutput("nh3_max_a1"),
                                     tags$head(tags$style(HTML("#nh3_max_a1 {font-size: 12px;}"))),
                                     tags$br(),
                                     verbatimTextOutput("nh3_max_a2"),
                                     tags$head(tags$style(HTML("#nh3_max_a2 {font-size: 12px;}"))),
                                     tags$br(),
                                     verbatimTextOutput("nh3_max_a3"),
                                     tags$head(tags$style(HTML("#nh3_max_a3 {font-size: 12px;}")))
                              ),
                            )
                     ),#End column 3
                     #Do thi NH3
                     column(width=9,highchartOutput("NH3Graph")),#End column 9
            ),#End tab CO2
           )#End cac tab lien quan den do thi 
        )#End column 12 cho 3 tabs
      )#End fluid ROW cac Tab ben duoi Box Value
    
    ),#End Tab HOME
    
    #---------------------------------------------------------------------------#  
    tabItem(tabName = "statictics",
            fluidRow(
              column(3,downloadButton('downloadData', 'Download'),
                     tags$style('#downloadData {background-color: #6BCB77;}'),
              ),#End column 3
              column(9,dateRangeInput("daterange", "Lọc theo ngày:",start = min(DAT$Date),end = max(DAT$Date))
                     #format = "dd/mm/yyyy",separator = "/")
              ),#End column 9
              
              shinyjs::useShinyjs(),
              hr(),
              DT::dataTableOutput("the_data")
            ),
            
    ),#End Tab STATISTICS
    
    #---------------------------------------------------------------------------#
    tabItem(tabName = "settings",
            fluidPage(
              uiOutput("uiLogin"),
              textOutput("pass"),
              tags$head(tags$style("#pass{color: red;")),#),    
              
              #hien thi dong login/logout
              uiOutput("userPanel"),
              #Hien thi trang login thanh cong
              uiOutput("LoginPage")
              #uiOutput("Setup"),#hien thi màn hình thiết lập
            )#End fluid page
    )#End Tab Settings
    
  )#End Tab Items
)#End BODY


dashboardPage(header, sidebar, body)