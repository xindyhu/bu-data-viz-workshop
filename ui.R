shinyUI(tagList(
  shinyjs::useShinyjs(),
  setBackgroundColor(
    color = "#FFFFFF",
    shinydashboard = FALSE
  ),
  navbarPage(
    id = "navbar",
    title = div(
      h1("An interactive map", style = "color:white")
    ), 
    tabPanel(
      "viz", 
      fluidRow(class="content-container", column(width=12,
                                                 # green banner
                                                 fluidRow(
                                                   column(
                                                     width = 12, 
                                                     div(class = "topic-div", 
                                                         span(  
                                                           img(src="ClimaWATCH_Pointer.png",height=60,width=80),
                                                           h4("Exposure to Heatwaves", class = "topic-text")
                                                         )
                                                     )
                                                   )),
                                                 br(),
                                                 # beige selector
                                                 div(class = "options",
                                                     fluidRow(
                                                       column(
                                                         width = 6,
                                                         # # use div + css to fix weird alignment issues in tabs
                                                         # style = "margin-top:10px; margin-left:15px",
                                                         
                                                         uiOutput("sliderbar_ui"),
                                                         sliderInput(
                                                           "year", div("Year (Note: Medicaid data were only available 2016 – 2020)", br(), 
                                                                       p(em("The colors in the slider bar indicate years with relatively fewer (yellow) or more (dark red) heatwaves across the country."), style="font-weight: normal;")), 
                                                           min = 1981, 
                                                           max = 2021, 
                                                           value = 2020,
                                                           step = 1, 
                                                           sep = "",
                                                           ticks = c(1981:2021),
                                                           width = '90%'
                                                         )
                                                       ),
                                                       column(
                                                         width = 6,
                                                         
                                                         pickerInput(
                                                           inputId = "state",
                                                           label = "State", 
                                                           choices = states,
                                                           options = list(`live-search` = TRUE)
                                                         ),
                                                         
                                                         pickerInput(
                                                           inputId = "definition_sec1",
                                                           label = "Heatwave definition",
                                                           choices = c("Method 1: >90 °F and in top 5% of values"="hybrid", "Method 2: In top 5% of values"="nonhybrid"),
                                                           #choices = c("mean AT>95th pctl & >90°F"="hybrid", "mean AT>95th percentile"="nonhybrid"),
                                                           options = list(`live-search` = TRUE)
                                                         )
                                                         
                                                       )
                                                     )), # end of class options
                                                 br(),
                                                 
                                                 
                                                 fluidRow(
                                                   column(width = 12, 
                                                          # h4("Number of heatwave episodes"),
                                                          uiOutput("map_tit"),
                                                          uiOutput("map_subtitle"),
                                                          div(actionButton("reset_map", "Reset view"), style = "float: right;padding-buttom: 0px;padding-top: 0px;padding-right: 150px"),
                                                          uiOutput("map_ui")
                                                   )
                                                 )
      ) # end of fluidRow
      
      ))
  ))
)
