shinyUI(tagList(
  shinyjs::useShinyjs(),
  # hide navbar tabs since we just have 1 (for now at least)
  tags$head(tags$style(HTML("#navbar li a[data-value = 'viz'] {display: none;}"))),
  setBackgroundColor(
    color = "#FFFFFF",
    shinydashboard = FALSE
  ),
  navbarPage(
    id = "navbar",
    title = div(h1("An interactive map", style = "color:black")), 
    windowTitle = 'My first interactive map',
    tabPanel(
      "viz", 
      fluidRow(class="content-container", 
               column(width=12,
                      # green banner
                      fluidRow(
                        column(
                          width = 12, 
                          div(class = "topic-div", 
                              span(  
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
                              # slider to select a year
                              sliderInput(
                                inputId = "year",
                                label = 'Year',
                                min = 1981,
                                max = 2021,
                                value = 2020,
                                step = 1,
                                ticks = TRUE,
                                width = '90%'
                              )
                            ), # end of slider input
                            column(
                              width = 6,
                              # dropdown menu to select a state
                              pickerInput(
                                inputId = "state",
                                label = "State", 
                                # options are U.S. + 51 states
                                choices = states,
                                options = list(`live-search` = TRUE)
                              )
                            )# end of dropdown menu
                          )), 
                      br(),
                      fluidRow(
                        column(width = 12, 
                               uiOutput("map_tit"),
                               div(actionButton("reset_map", "Reset view"), 
                                   style = "float: right;padding-buttom: 0px;padding-top: 0px;padding-right: 150px"),
                               uiOutput("map_ui")
                        )
                      )
               ) # end of fluidRow
      ))
  ))
)
