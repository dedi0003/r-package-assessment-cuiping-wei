# map plot section

output$map <-renderLeaflet({
map <- leaflet() %>%
      setView(0, 25, zoom = 2) %>%
      addTiles() %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addLayersControl(
        baseGroups = c("Confirmed", "Deaths", "Recovered", "Active"),
        options = layersControlOptions(collapsed = FALSE)) %>%
      hideGroup("Deaths") %>%
      hideGroup("Recovered") %>%
      hideGroup("Active")
})

  observe({
    req(input$timeSlider)
    data_date<- date_filter(input$timeSlider) %>% 
      filter(!is.na(long) & !is.na(lat)) %>% 
      drop_na()
    
    leafletProxy("map", data = data_date) %>%
      clearMarkers() %>%
      addCircleMarkers(
        lng          = ~long,
        lat          = ~lat,
        radius       = ~log(confirmed_cum),
        stroke       = FALSE,
        color = "#4682B4",
        fillOpacity  = 0.5,
        group        = "Confirmed"
      ) %>%
      addCircleMarkers(
        lng          = ~long,
        lat          = ~lat,
        radius       = ~log(death_cum),
        stroke       = FALSE,
        color        = "#E9967A",
        fillOpacity  = 0.5,
        group        = "Deaths"
      ) %>%
      addCircleMarkers(
        lng          = ~long,
        lat          = ~lat,
        radius       = ~log(recovered_cum),
        stroke       = FALSE,
        color        = "#9BCD9B",
        fillOpacity  = 0.5,
        group        = "Recovered"
      ) %>%
      addCircleMarkers(
        lng          = ~long,
        lat          = ~lat,
        radius       = ~log(active_cum),
        stroke       = FALSE,
        color        = "#CD96CD",
        fillOpacity  = 0.5,
        group        = "Active"
      ) 
  })

  
  
# ValueBox section

output$value_confirmed <- renderValueBox({
  valueBox(paste(format(total_value$confirmed, big.mark = ","), "", sep=" "), "Total confirmed cases", color = "blue")
})

output$value_recovered<- renderValueBox({
  valueBox(paste(format(total_value$recovered,  big.mark = ","), "", sep=" "), "Total recovered cases", color = "olive")
})

output$value_death<- renderValueBox({
  valueBox(paste(format(total_value$death,  big.mark = ","), "", sep=" "), "Total deaths", color = "orange")
})

output$value_active<- renderValueBox({
  valueBox(paste(format(total_value$active,  big.mark = ","), "", sep=" "), "Total active cases", color = "purple")
})
