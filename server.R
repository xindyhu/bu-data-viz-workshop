shinyServer(function(input, output, session) {
  ############ get input from ui ###############################
  # get selected state
  selected_values <- reactiveValues(state = states)
  # update selected values based on the dropdown menu
  observeEvent(input$state, {
    if(input$state == "U.S."){ # showing full U.S.
      selected_values$state <- states
    } else if(input$state != "U.S.") { # showing new state
      selected_values$state <- input$state
    }
  })
  # update selected state on click
  observeEvent(input$map_shape_click, {
    click <- input$map_shape_click  # store clicked county 
    selected_values$state <-  df_fips %>% 
      filter(state_fips == substr(click$id, 1, 2)) %>% # get state fips from county fips
      pull(state) %>% unique()      # replace selected state
    updatePickerInput(inputId = "state", session = session, selected = selected_values$state)
  })
  
  ############# filter data based on inputs ######################
  heatwave_data_filtered <- reactive({
    # require inputs from state dropdown and year selection
    req(selected_values$state, input$year)
    # filter data to selected year and state
    county_year %>%
      filter(year == input$year,
             state %in% selected_values$state)
  })
  
  # filter county map shapefile based on inputs
  shp_geo <- reactive({
    req(selected_values$state)
    filter(county_shp, state %in% selected_values$state)
  })
  
  # filter state map shapefile based on inputs
  state_shp_geo <- reactive({
    req(selected_values$state)
    filter(state_shp, state %in% selected_values$state)
  })
  
  ############### generate visualizations ###########################
  output$map_tit <- renderUI({
    state_title <- if_else(input$state == "U.S.", "U.S.", input$state)
    txt <- paste0("Heatwaves in ", state_title, ", ", input$year)
    div(class = 'chart-title-container', 
        h4(HTML(txt), class = 'chart-title-text'))
  })
  
  output$map <- renderLeaflet({
    validate(need(nrow(heatwave_data_filtered()) > 0, "No heatwave data to show."))
    
    coords <- st_coordinates(shp_geo()$geometry)
    
    # join county shapefile to heatwave data
    data_for_map <- shp_geo() %>%
      left_join(heatwave_data_filtered(), by = c("fips", "state")) %>%
      # impute NA as 0
      replace_na(list(n_epis = 0, dur_epis = 0))
    
    data_for_map %>%
      {if(input$state=="U.S.")
        leaflet(., options = leafletOptions(crs = epsg2163))
        else
          leaflet(.)} %>%
      fitBounds( 
        lng1 = min(coords[,1]), 
        lat1 = min(coords[,2]), 
        lng2 = max(coords[,1]), 
        lat2 = max(coords[,2])
      ) %>% 
      addPolygons(
        data = data_for_map,
        weight = 0.5, 
        color = "#444444", 
        opacity = 1,
        fillOpacity = 1,
        layerId = ~fips, 
        fillColor = ~map_pal(n_epis_bin), 
        smoothFactor = 0.5,
        # tooltip
        label = ~map_label_format(data_for_map[["county"]], 
                                  data_for_map[["n_epis"]], 
                                  data_for_map[["dur_epis"]]),
        labelOptions = labelOptions(
          style = list(
            "font-weight" = "normal",
            padding = "3px 8px",
            "font-size" = "12px",
            "font-family" = "Arial"
          ),
          direction = "auto"
        ),
        # highlight shapes
        highlightOptions = highlightOptions(color = "black", weight = 2,
                                            bringToFront = TRUE)) %>%
      # add thicker outline for states
      addPolylines(
        data = state_shp_geo(),
        layerId = ~state_fips,
        color = "#444444",
        opacity = 1,
        weight = if_else(input$state != "U.S.", 3.5, 1.3)
      ) %>%
      # add legend
      addLegend(
        position = "bottomleft",
        title = "Number of heatwaves",
        pal = map_pal,
        opacity = 1,
        values = ~n_epis_bin,
        na.label = 'No heatwave'
      )
  })
  
  output$map_ui <- renderUI({
    leafletOutput("map")
  })
  
  observeEvent(input$reset_map, {
    updatePickerInput(inputId = "state", session = session, selected = states)
  })
})