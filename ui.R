shinyUI(tagList(
  shinyjs::useShinyjs(),
  # include style
  tags$head(includeCSS(("www/style.css"))),
  fluidPage(
    windowTitle = 'My first interactive map',
    fluidRow(column(width=12,
                    # Title banner
                    span(h3("A interactive map of heatwaves")),
                    br(),
                    # selector
                    div(fluidRow(
                      column(width = 6,
                             # slider to select a year
                             sliderInput(
                               inputId = "year",
                               label = 'Select a year',
                               min = 1981,
                               max = 2021,
                               value = 2020,
                               sep = "",
                               width = '90%'
                             )
                      ), # end of slider input
                      column(width = 6,
                             # dropdown menu to select a state
                             pickerInput(
                               inputId = "state",
                               label = "Select U.S. or a State", 
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
    )
    )
  ))
)
