body_map <- dashboardBody(
    tabItem("map",
    fluidRow(
      box(title = paste0("Data updated on ", max(covid19$date)),
        width = 12,
        column(
          htmltools::div(p("Statistical values of COVID-19")),
          width = 12),
        valuebox("value_confirmed", width = 3),
        valuebox("value_recovered", width = 3),
        valuebox("value_active", width = 3),
        valuebox("value_death", width = 3)),
      width = 12,
      style = 'padding:0px;')),

    fluidRow(
      column(
        box(
          width = 12,
          tabPanel("map", leafletOutput(outputId = "map", width = "100%", height = 500)),
          br(),
          column(
            htmltools::div(p("Note: You can change the time range by using the time slider below."),
                           "Switch the variables on the top-right button. The larger the circle, the greater the cumulative number of cases."),
            width = 12)
          ),
        width = 12,
        style = 'padding:0px;'
      ),

      column(
        input_type(sliderInput, df=covid_pop, inputID="timeSlider", label = "Select date"),
        class = "slider",
        width = 12,
        style = 'padding-left:20px; padding-right:20px;'
      )
    )
  )


page_map <- ui_page("map", body_map)
