body_map <- dashboardBody(
    tabItem("map",
    fluidRow(
      box(title = paste0("Data updated on ", max(covid19$date)),
        width = 12,
        column(
          htmltools::div(p("Statistical values of COVID-19")),
          width = 12),
      valueBoxOutput("value_confirmed", width = 3),
      valueBoxOutput("value_recovered", width = 3),
      valueBoxOutput("value_active", width = 3),
      valueBoxOutput("value_death", width = 3)),
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
        sliderInput(
          "timeSlider",
          label = "Select date",
          min = min(covid_pop$date), 
          max = max(covid_pop$date), 
          value = max(covid_pop$date), 
          width = "100%",
          animate = animationOptions(loop = FALSE, interval = 250),
          timeFormat = "%d.%m.%Y"),
        class = "slider",
        width = 12,
        style = 'padding-left:20px; padding-right:20px;'
      )
    )
  )


page_map <- dashboardPage(
  title   = "map",
  header  = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body    = body_map
)

