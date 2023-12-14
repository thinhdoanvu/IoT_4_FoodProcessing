shinyServer(function(input, output, session){
  source(here::here("www/global.R"))
  shinyjs::useShinyjs()
  #-------------------------------HEADER--------------------------------------#
  output$messageMenu <- renderMenu({
    msgs <- apply(messageData, 1, function(row){
      #messageData is a data frame with two columns, 'sensor' and 'value'
      messageItem(from = row[["sensor"]], message = row[["value"]])
    })#End msgs
    dropdownMenu(type = "messages", .list = msgs)
  })
  
  #-------------------------------HOME----------------------------------------#
  #Tab HOME
  #CLO VALUE BOX --------------------------------------------------------------
  if(realtimeDAT$CLO_A1 > CONTROL$CLO_A1_MAX){
    COLOR_CLO_A1 = "red"
  }
  else{
    COLOR_CLO_A1 = "green"
  }
  output$CLO1 <- renderValueBox({
    valueBox(realtimeDAT$CLO_A1/10,'CLO - Area 1',icon = icon("thermometer"),color = COLOR_CLO_A1) 
  })
  
  if(realtimeDAT$CLO_A2 > CONTROL$CLO_A2_MAX){
    COLOR_CLO_A2 = "red"
  }
  else{
    COLOR_CLO_A2 = "green"
  }
  output$CLO2 <- renderValueBox({
    valueBox(realtimeDAT$CLO_A2/10,'CLO - Area 2',icon = icon("thermometer"),color = COLOR_CLO_A2) 
  })
  
  if(realtimeDAT$CLO_A3 > CONTROL$CLO_A3_MAX){
    COLOR_CLO_A3 = "red"
  }
  else{
    COLOR_CLO_A3 = "green"
  }
  output$CLO3 <- renderValueBox({
    valueBox(realtimeDAT$CLO_A3/10,'CLO - Area 3',icon = icon("thermometer"),color = COLOR_CLO_A3) 
  })
  
  #CO2 VALUE BOX --------------------------------------------------------------
  if(realtimeDAT$CO2_A1 > CONTROL$CO2_A1_MAX){
    COLOR_CO2_A1 = "red"
  }
  else{
    COLOR_CO2_A1 = "light-blue"
  }
  output$CO21 <- renderValueBox({
    valueBox(realtimeDAT$CO2_A1/10,'CO2 - Area 1',icon = icon("thermometer"),color = COLOR_CO2_A1) 
  })
  
  if(realtimeDAT$CO2_A2 > CONTROL$CO2_A2_MAX){
    COLOR_CO2_A2 = "red"
  }
  else{
    COLOR_CO2_A2 = "light-blue"
  }
  output$CO22 <- renderValueBox({
    valueBox(realtimeDAT$CO2_A2/10,'CO2 - Area 2',icon = icon("thermometer"),color = COLOR_CO2_A2) 
  })
  
  if(realtimeDAT$CO2_A3 > CONTROL$CO2_A3_MAX){
    COLOR_CO2_A3= "red"
  }
  else{
    COLOR_CO2_A3 = "light-blue"
  }
  
  output$CO23 <- renderValueBox({
    valueBox(realtimeDAT$CO2_A3/10,'CO2 - Area 3',icon = icon("thermometer"),color = COLOR_CO2_A3) 
  })
  
  #NH3 VALUE BOX --------------------------------------------------------------
  if(realtimeDAT$NH3_A1 > CONTROL$NH3_A1_MAX){
    COLOR_NH3_A1 = "red"
  }
  else{
    COLOR_NH3_A1 = "purple"
  }
  output$NH31 <- renderValueBox({
    valueBox(realtimeDAT$NH3_A1/10,'NH3 - Area 1',icon = icon("thermometer"),color = COLOR_NH3_A1) 
  })
  
  if(realtimeDAT$NH3_A2 > CONTROL$NH3_A2_MAX){
    COLOR_NH3_A2 = "red"
  }
  else{
    COLOR_NH3_A2 = "purple"
  }
  output$NH32 <- renderValueBox({
    valueBox(realtimeDAT$NH3_A2/10,'NH3 - Area 2',icon = icon("thermometer"),color = COLOR_NH3_A2) 
  })
  
  if(realtimeDAT$NH3_A3 > CONTROL$NH3_A3_MAX){
    COLOR_NH3_A3 = "red"
  }
  else{
    COLOR_NH3_A3 = "purple"
  }
  output$NH33 <- renderValueBox({
    valueBox(realtimeDAT$NH3_A3/10,'NH3 - Area 3',icon = icon("thermometer"),color = COLOR_NH3_A3) 
  })
  
  #MAX VALUE--------------------------------------------------------------
  #CLO
  output$clo_max_a1 <- renderText({paste0("A1-MAX:",round(CONTROL$CLO_A1_MAX/10,digits = 1),"mg/l")})
  output$clo_max_a2 <- renderText({paste0("A2-MAX:",round(CONTROL$CLO_A2_MAX/10,digits = 1),"mg/l")})
  output$clo_max_a3 <- renderText({paste0("A3-MAX:",round(CONTROL$CLO_A3_MAX/10,digits = 1),"mg/l")})
  
  #CO2: carbondioxide
  output$co2_max_a1 <- renderText({paste0("A1-MAX:",round(CONTROL$CO2_A1_MAX/10,digits = 1),"mg/l")})
  output$co2_max_a2 <- renderText({paste0("A2-MAX:",round(CONTROL$CO2_A2_MAX/10,digits = 1),"mg/l")})
  output$co2_max_a3 <- renderText({paste0("A3-MAX:",round(CONTROL$CO2_A3_MAX/10,digits = 1),"mg/l")})
  
  #NH3: amonia
  output$nh3_max_a1 <- renderText({paste0("A1-MAX:",round(CONTROL$NH3_A1_MAX/10,digits = 1),"mg/l")})
  output$nh3_max_a2 <- renderText({paste0("A2-MAX:",round(CONTROL$NH3_A2_MAX/10,digits = 1),"mg/l")})
  output$nh3_max_a3 <- renderText({paste0("A3-MAX:",round(CONTROL$NH3_A3_MAX/10,digits = 1),"mg/l")})
  
  
  #GRAPH--------------------------------------------------------------
  #CLO
  output$CloGraph <-renderHighchart({
    hchart(DAT_24, "line",color="red",hcaes(x=Time))%>%
      #highchart() %>%
      hc_add_series(DAT_24, "line",color="red",hcaes(x=Time,y=CLO_A1), marker = list(symbol = 'circle'), name = "Clo - A1", showInLegend = TRUE)  %>%
      hc_add_series(DAT_24, "line",color="blue",hcaes(x=Time,y=CLO_A2), marker = list(symbol = 'square'), name = "Clo - A2", showInLegend = TRUE)  %>%  
      hc_add_series(DAT_24, "line",color="green",hcaes(x=Time,y=CLO_A3), marker = list(symbol = 'triangle'), name = "Clo - A3", showInLegend = TRUE)  %>%   
      hc_exporting(enabled = TRUE) %>% 
      hc_tooltip(crosshairs = TRUE, backgroundColor = "#FCFFC5",shared = TRUE, borderWidth = 0) %>%
      #hc_title(text="Nồng độ Clo theo thời gian",align="center") %>%
      hc_subtitle(text=unique(DAT_24$Date),align="center") %>%
      hc_add_theme(hc_theme_elementary()) %>%
      hc_xAxis( title = list(text = "Hour:Min")) %>%
      hc_yAxis( title = list(text = "mg/l")) %>%
      hc_tooltip(table = TRUE,sort = TRUE,
                 pointFormat = paste0( '<br> <span style="color:{point.color}"></span>'," {point.y} mg/l"),
                 headerFormat = '<span style="font-size: 13px">{point.key}</span>'
      )
  })
  
  #CO2
  output$CO2Graph <-renderHighchart({
    hchart(DAT_24, "line",color="red",hcaes(x=Time))%>%
      #highchart() %>%
      hc_add_series(DAT_24, "line",color="red",hcaes(x=Time,y=CO2_A1), marker = list(symbol = 'circle'), name = "CO2 - A1", showInLegend = TRUE)  %>%
      hc_add_series(DAT_24, "line",color="blue",hcaes(x=Time,y=CO2_A2), marker = list(symbol = 'square'), name = "CO2 - A2", showInLegend = TRUE)  %>%  
      hc_add_series(DAT_24, "line",color="green",hcaes(x=Time,y=CO2_A3), marker = list(symbol = 'triangle'), name = "CO2 - A3", showInLegend = TRUE)  %>%   
      hc_exporting(enabled = TRUE) %>% 
      hc_tooltip(crosshairs = TRUE, backgroundColor = "#FCFFC5",shared = TRUE, borderWidth = 0) %>%
      #hc_title(text="Nổng độ CO2",align="center") %>%
      hc_subtitle(text=unique(DAT_24$Date),align="center") %>%
      hc_add_theme(hc_theme_elementary()) %>%
      hc_xAxis( title = list(text = "Hour:Min")) %>%
      hc_yAxis( title = list(text = "mg/l")) %>%
      hc_tooltip(table = TRUE,sort = TRUE,
                 pointFormat = paste0( '<br> <span style="color:{point.color}"></span>'," {point.y} mg/l"),
                 headerFormat = '<span style="font-size: 13px">{point.key}</span>'
      )
  })
  
  #NH3
  output$NH3Graph <-renderHighchart({
    hchart(DAT_24, "line",color="red",hcaes(x=Time))%>%
      #highchart() %>%
      hc_add_series(DAT_24, "line",color="red",hcaes(x=Time,y=NH3_A1), marker = list(symbol = 'circle'), name = "NH3 - A1", showInLegend = TRUE)  %>%
      hc_add_series(DAT_24, "line",color="blue",hcaes(x=Time,y=NH3_A2), marker = list(symbol = 'square'), name = "NH3 - A2", showInLegend = TRUE)  %>%  
      hc_add_series(DAT_24, "line",color="green",hcaes(x=Time,y=NH3_A3), marker = list(symbol = 'triangle'), name = "NH3 - A3", showInLegend = TRUE)  %>%   
      hc_exporting(enabled = TRUE) %>% 
      hc_tooltip(crosshairs = TRUE, backgroundColor = "#FCFFC5",shared = TRUE, borderWidth = 0) %>%
      #hc_title(text="Nổng độ NH3",align="center") %>%
      hc_subtitle(text=unique(DAT_24$Date),align="center") %>%
      hc_add_theme(hc_theme_elementary()) %>%
      hc_xAxis( title = list(text = "Hour:Min")) %>%
      hc_yAxis( title = list(text = "mg/l")) %>%
      hc_tooltip(table = TRUE,sort = TRUE,
                 pointFormat = paste0( '<br> <span style="color:{point.color}"></span>'," {point.y} mg/l"),
                 headerFormat = '<span style="font-size: 13px">{point.key}</span>'
      )
  })
  
  #----------------------------STATISTICS----------------------------------#
  #TAB STATISTIC
  #hien thi data dang bang
  getdata <- reactive({
    filterdata <- DAT[ , c(1:11)] %>% filter(DAT$Date >= input$daterange[1] & DAT$Date <= input$daterange[2])
    return(filterdata)
  })
  
  output$the_data <- DT::renderDataTable({
    getdata()
    #DT::datatable(filterdata, options = list(lengthMenu = c(12, 24, 48), order = list(1, 'desc') ,pageLength = 20, scrollX = TRUE))
  })
  
  
  output$downloadData <- downloadHandler(
    filename = function() { 
      paste("data-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(getdata(), file)
    })
  
  #---------------------------SETTINGS------------------------------------#
  #Login Logout
  USER <- reactiveValues(Logged = FALSE , session = session$user) 
  source(here::here("www/Login.R"),  local = TRUE)
  
  output$LoginPage <- renderUI({
    if (USER$Logged == TRUE) {
      
      #Dang nhap thanh cong
      fluidRow(
        titlePanel(title = "SETTINGS FOR SENSORS RANGE"), align = "center",
        tags$hr(),
        uiOutput("Setup")#hien thi màn hình thiết lập
      )
    }#End IF (login thanh cong)  
  })
  
  #Man hinh thiet lap nguong
  output$Setup <- renderUI({
    fluidRow(
      #titlePanel(title = "Thiết lập ngưỡng cảnh báo"), align = "center",
      column(width=12,style = "background-color:#F1F1F1",#thiet lap nguong
        #CLO
        column(width = 4,
          column(width = 12,style = "background-color:#DFE8CC",tags$br(),
            tags$style("#clo_a1_max {font-size:20px;height:50px;}"),
            numericInput(inputId="clo_a1_max",label="Cloride A1-MAX",value=CONTROL$CLO_A1_MAX/10,min = 0,max = 100,step = 0.1,width = NULL),
            tags$hr(),
            tags$style("#clo_a2_max {font-size:20px;height:50px;}"),
            numericInput(inputId="clo_a2_max",label="Cloride A2-MAX",value=CONTROL$CLO_A2_MAX/10,min = 0,max = 100,step = 0.1,width = NULL),
            tags$hr(),
            tags$style("#clo_a3_max {font-size:20px;height:50px;}"),
            numericInput(inputId="clo_a3_max",label="Cloride A3-MAX",value=CONTROL$CLO_A3_MAX/10,min = 0,max = 100,step = 0.1,width = NULL),
          ),#End column
        ),#End column CLO
        
        #CO2
        column(width = 4,
          column(width = 12,style = "background-color:#DFE8CC",tags$br(),
            tags$style("#co2_a1_max {font-size:20px;height:50px;}"),
              numericInput(inputId="co2_a1_max",label="CO2 A1-MAX",value=CONTROL$CO2_A1_MAX/10,min = 0,max = 100,step = 0.1,width = NULL),
              tags$hr(),
              tags$style("#co2_a2_max {font-size:20px;height:50px;}"),
              numericInput(inputId="co2_a2_max",label="CO2 A2-MAX",value=CONTROL$CO2_A2_MAX/10,min = 0,max = 100,step = 0.1,width = NULL),
              tags$hr(),
              tags$style("#co2_a3_max {font-size:20px;height:50px;}"),
              numericInput(inputId="co2_a3_max",label="CO2 A3-MAX",value=CONTROL$CO2_A3_MAX/10,min = 0,max = 100,step = 0.1,width = NULL),
            ),#End column
        ),#End column CO2
        
        #NH3
        column(width = 4,
               column(width = 12,style = "background-color:#DFE8CC",tags$br(),
                      tags$style("#nh3_a1_max {font-size:20px;height:50px;}"),
                      numericInput(inputId="nh3_a1_max",label="NH3 A1-MAX",value=CONTROL$NH3_A1_MAX/10,min = 0,max = 100,step = 0.1,width = NULL),
                      tags$hr(),
                      tags$style("#nh3_a2_max {font-size:20px;height:50px;}"),
                      numericInput(inputId="nh3_a2_max",label="NH3 A2-MAX",value=CONTROL$NH3_A2_MAX/10,min = 0,max = 100,step = 0.1,width = NULL),
                      tags$hr(),
                      tags$style("#nh3_a3_max {font-size:20px;height:50px;}"),
                      numericInput(inputId="nh3_a3_max",label="NH3 A3-MAX",value=CONTROL$NH3_A3_MAX/10,min = 0,max = 100,step = 0.1,width = NULL),
               ),#End column
        ),#End column NH3
        
        #OK button
        tags$hr(),  
        column(width = 12,tags$br(),
               tags$style('#Save {background-color: #6BCB77;}'),
               actionButton("Save", "SAVE"),
        ),
        tags$hr(),
        
      )#End column 12 for settings
    )#End fluid row for settings 
  })#End setup range
  
  #Nhan nut Luu thiet lap
  observeEvent(input$Save,{
    if(file.exists("www/control.txt")){
      #file.remove("www/control.txt")
    }
    else{
      file.create("www/control.txt")
      head="DATE,TIME,CLO_A1_MAX,CLO_A2_MAX,CLO_A3_MAX,CO2_A1_MAX,CO2_A2_MAX,CO2_A3_MAX,NH3_A1_MAX,NH3_A2_MAX,NH3_A3_MAX"
      write(head,file="www/control.txt",append=TRUE)
    }
    dmy<-format(as.Date(Sys.Date(), '%Y/%m/%d'), '%d/%m/%Y')
    hms<-format(Sys.time(), '%H:%M:%S')
    write.table(dmy,"www/control.txt",quote = FALSE, sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE )
    write.table(hms,"www/control.txt",quote = FALSE,sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE )
    
    write.table(input$clo_a1_max*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$clo_a2_max*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$clo_a3_max*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    
    write.table(input$co2_a1_max*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$co2_a2_max*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$co2_a3_max*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    
    write.table(input$nh3_a1_max*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$nh3_a2_max*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol=",", append =TRUE)
    write.table(input$nh3_a3_max*10,"www/control.txt",sep = ",",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
    
    #Luu vao file config.cfg va gui den -> Raspb -> PLC
    if(file.exists("www/config.cfg")){
      file.remove("www/config.cfg")
    }
    else{
      file.create("www/config.cfg")
    }
    
    #ghi noi dung vao file
    write.table(input$clo_a1_max*10,"www/config.cfg",sep ="\n",row.names=FALSE, col.names=FALSE, eol ="\n", append =TRUE)
    write.table(input$clo_a2_max*10,"www/config.cfg",sep ="\n",row.names=FALSE, col.names=FALSE, eol ="\n", append =TRUE)
    write.table(input$clo_a3_max*10,"www/config.cfg",sep ="\n",row.names=FALSE, col.names=FALSE, eol ="\n", append =TRUE)
    
    write.table(input$co2_a1_max*10,"www/config.cfg",sep ="\n",row.names=FALSE, col.names=FALSE, eol ="\n", append =TRUE)
    write.table(input$co2_a2_max*10,"www/config.cfg",sep ="\n",row.names=FALSE, col.names=FALSE, eol ="\n", append =TRUE)
    write.table(input$co2_a3_max*10,"www/config.cfg",sep ="\n",row.names=FALSE, col.names=FALSE, eol ="\n", append =TRUE)
    
    write.table(input$nh3_a1_max,"www/config.cfg",sep ="\n",row.names=FALSE, col.names=FALSE, eol ="\n", append =TRUE)
    write.table(input$nh3_a2_max,"www/config.cfg",sep ="\n",row.names=FALSE, col.names=FALSE, eol ="\n", append =TRUE)
    write.table(input$nh3_a3_max,"www/config.cfg",sep ="\n",row.names=FALSE, col.names=FALSE, eol ="\n", append =TRUE)
    
    #Luu yeu cau Write to PLC vao file request.req, file nay da co do ngay tu khi khoi dong da tao ra file nay roi
    dmy<-format(as.Date(Sys.Date(), '%Y/%m/%d'), '%d/%m/%Y')
    hms<-format(Sys.time(), '%H:%M:%S')
    #write.table("\n","www/request.req",quote = FALSE, sep = "",row.names=FALSE, col.names=FALSE, eol="", append =TRUE )
    write.table(dmy,"www/request.req",quote = FALSE, sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
    write.table(hms,"www/request.req",quote = FALSE,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\t", append =TRUE )
    write.table("W","www/request.req",quote = F,sep = "\t",row.names=FALSE, col.names=FALSE, eol="\n", append =TRUE)
    
    shinyjs::refresh()
    
  })#End Save button
  
})#END BACKEND