# highchart, plotly and table section

output$choice<-renderUI({
  input_type(selectInput, inputID = "type", label = "Select Variable" )
  # selectInput(
  #   inputId = "type",
  #   label = "Select Variable",
  #   choices = list(
  #     "Confirmed",
  #     "Mortality"),
  #   selected = "Confirmed",
  #   multiple = FALSE
  # )
})

## hightchart for confirmed cases rate and mortality rate
output$casecompare <- renderHighchart({
  req(input$country_choice)
  req(input$type)
  countrylist <- input$country_choice
  dateRange <- input$date
  plotType <- input$type

  data <- case_comparison %>%
    filter(country %in% countrylist) %>%
    filter(date >= dateRange[1] & date <= dateRange[2]) %>%
    select(date, country, all_of(plotType))


  if(plotType == "Confirmed"){
    plot_highchart(data, date, Confirmed, country, "Confirmed cases rate", "Date",
                   "COVID-19 confirmed cases rate per million by country")

    # highchart() %>%
    #   hc_add_series(data, "line",
    #                 hcaes(x = date, y = `Confirmed cases rate`, group = country)) %>%
    #   hc_yAxis(title = list(text = "Confirmed cases rate")) %>%
    #   hc_xAxis(type = "datetime",
    #            dateTimeLabelFormats = list(date = '%d/%m/%y'),
    #            title = list(text = "Date")) %>%
    #   hc_title(text = "COVID-19 confirmed cases rate per million by country",
    #            style = list(color = "black", useHTML = TRUE)) %>%
    #   hc_tooltip(crosshairs = TRUE,
    #              backgroundColor = "#FCFFC5",
    #              shared = TRUE,
    #              borderWidth = 5,
    #              table = T)

    }
  else{
    plot_highchart(data, date, Mortality, country, "Mortality rate", "Date",
                   "COVID-19 mortality rate per million by country")

    # highchart() %>%
    #   hc_add_series(data, "line",
    #                 hcaes(x = date, y = `Mortality rate`, group = country)) %>%
    #   hc_yAxis(title = list(text = "Mortality rate")) %>%
    #   hc_xAxis(type = "datetime",
    #            dateTimeLabelFormats = list(date = '%d/%m/%y'),
    #            title = list(text = "Date")) %>%
    #   hc_title(text = "COVID-19 mortality rate per million by country",
    #            style = list(color = "black", useHTML = TRUE)) %>%
    #   hc_tooltip(crosshairs = TRUE,
    #              backgroundColor = "#FCFFC5",
    #              shared = TRUE,
    #              borderWidth = 5,
    #              table = T)
  }
})


## plotly for the total confirmed cases of selected countries, create event_data
output$topCountries <- renderPlotly({

   req(input$country_choice)
   countrylist <- input$country_choice

data <- log_data_top %>%
  filter(country %in% countrylist) %>%
  select(country, confirmed)


data$country <- factor(data$country, levels = unique(data$country)[order(data$confirmed, decreasing = TRUE)])

data %>%
  plot_ly(x = ~country,
          y = ~confirmed,
          type = "bar",
          color = ~country,
          source = "topCountries") %>%
  plotly::layout(
    yaxis=list(title="Confirmed cases(per million)"),
    title =list(text = paste0("Total confirmed cases for ",length(countrylist), " countries")),
    showlegend = FALSE) %>%
  config(displayModeBar = F) %>%
  event_register( "plotly_click")
})

## print the result from event_data
output$click <- renderPrint({
  d <- event_data("plotly_click",  source = "topCountries")
  if (is.null(d)) "Click events appear here" else d
})


## line plot for log cases based on event_data()
output$log <- renderPlotly({

  # default plot

  default_plot<-log_data %>%
    filter(country == "US") %>%
    ggplot(aes(x =date))+
    geom_line(aes(y = confirmed, color = "Confirmed"))+
    geom_line(aes(y = recovered, color = "Recovered")) +
    geom_line(aes(y = death, color = "Deaths")) +
    scale_color_manual(breaks = c("Confirmed", "Deaths", "Recovered"),
                       values = c("black", "red", "steelblue")) +
    scale_x_date(date_breaks = "1 month",
                 date_labels = "%b") +
    scale_y_continuous(trans = "log10")+
    labs(title = paste0("Logarithmic scale for COVID-19 cases in US"),
         x = "Date",
         y = "Count") +
    theme_light()


  d_plot<-
    ggplotly(default_plot) %>%
    layout(legend = list(orientation = "h", y = -0.3)) %>%
    config(displayModeBar = F)

  # event data
  d <- event_data("plotly_click", source = "topCountries")
  if (is.null(d)) return(d_plot)


  # plot for event data
  line_plot<-log_data %>%
    filter(country %in% d$x) %>%   #change input from event_data click
    ggplot(aes(x =date))+
    geom_line(aes(y = confirmed, color = "Confirmed"))+
    geom_line(aes(y = recovered, color = "Recovered")) +
    geom_line(aes(y = death, color = "Deaths")) +
    scale_color_manual(breaks = c("Confirmed", "Deaths", "Recovered"),
                       values = c("black", "red", "steelblue")) +
    scale_x_date(date_breaks = "1 month",
                 date_labels = "%b") +
    scale_y_continuous(trans = "log10")+
    labs(title = paste0("Logarithmic scale for COVID-19 cases in ", d$x),
         x = "Date",
         y = "Count") +
    theme_light()

  ggplotly(line_plot) %>%
    layout(legend = list(orientation = "h", y = -0.3)) %>%
    config(displayModeBar = F)
})


## summary table
output$summaryTable <- DT::renderDataTable({

  req(input$country_choice)
  req(input$date)
  countrylist <- input$country_choice
  dateRange <- input$date

  # table data based on selectInput and dateRange

  pro_cases <- covid_pop %>%
    filter(date >= dateRange[1] & date <= dateRange[2]) %>%
    filter(country %in% countrylist) %>%
    group_by(country) %>%
    summarise(Confirmed = sum(confirmed, na.rm = TRUE),
              Recovered = sum(recovered, na.rm = TRUE),
              Active = sum(active, na.rm = TRUE),
              Deaths = sum(death, na.rm = TRUE)) %>%
    arrange(-Confirmed) %>%
    mutate(`Recovery rate` = Recovered / Confirmed,
           `Death rate` = Deaths / Confirmed,
           `Active rate` = Active / Confirmed) %>%
    rename("Country" = "country")

  datatable(pro_cases,
            escape = FALSE,
            rownames = FALSE,
            class = "display",
            options = list(
              columnDefs = list(list(className = 'dt-left')))) %>%   #adjust text position
    formatPercentage(c(6:8),2) %>%   # adjust number
    formatCurrency(c(2:5), currency = "", interval = 3, mark = ",", digits = 0)

})


