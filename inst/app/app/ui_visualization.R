body_plot_table <- dashboardBody(
  sidebarLayout(
    sidebarPanel(
      h3("Data visualization"),
      br(),
      #input_type(picker, case_comparison),
      input_type(pickerInput, case_comparison, log_data_top, "country_choice", "Comparing mutiple countries"),
      # pickerInput(
      #   inputId = "country_choice",
      #   label = "Comparing mutiple countries",
      #   choices = unique(case_comparison$country),
      #   selected = log_data_top$country[c(1:8)],
      #   multiple = TRUE,
      #   options = list(
      #     `actions-box` = TRUE,
      #     `live-search` = TRUE,
      #     size = 12)),

      br(),
      input_type(dateRangeInput, df = case_comparison, ID="date", label = "Select date range"),
      # dateRangeInput( inputId = "date",
      #                 label = "Select date range",
      #                 start = min(case_comparison$date),
      #                 end   = max(case_comparison$date),
      #                 min = min(case_comparison$date),
      #                 max = max(case_comparison$date),
      #                 format = "dd-mm-yyyy",
      #                 width = "100%"),
      br(),
      plotlyOutput("topCountries"),
      br(),
      verbatimTextOutput("click"),
      hr(),
      br(),
      h4("Explanation for visualization page"),
      br(),
      h5("There are three graphs and one table in this page, all of which can be changed by user input."),
      br(),
      HTML("<b>How to explore this app? (Follow the order below)</b>"),
      br(),
      br(),
      HTML("<b>1. Bar chart: </b>Select the country you are interested in the above input panel and explore the bar chart, which will provide you with a visualization of the total confirmed cases in your chosen country."),
      br(),
      br(),
      HTML("<b>2. Line chart: </b>Click on the bar chart to see which countries you would like to explore further, and then the first plot on the right panel will be updated by your chosen country. The line plot shows the number of confirmed cases, recovered cases, and deaths on a logarithmic scale over time."),
      br(),
      br(),
      HTML("<b>3. Highchart: </b>The second plot on the right panel shows the comparison of confirmed rates and mortality rates between different countries. And these two rates are calculated based on the total population (million) of each country."),
      br(),
      br(),
      HTML("<b>4. Summary table: </b>The summary table shows the total confirmed cases, the total recovered cases, the total active cases, the total deaths, recovery rates, active rates, and mortality rates of each country. And the rates in the table are calculated based on the total confirmed cases of each country. "),
      br(),
      br(),
      HTML("<b>What the outputs mean?</b>"),
      br(),
      br(),
      HTML("<b>General variables: </b>"),
      br(),
      HTML("<b>Confirmed: </b> Confirmed positive cases of COVID-19."),
      br(),
      HTML("<b>Recovered: </b> Cured cases of COVID-19."),
      br(),
      HTML("<b>Active: </b> Uncured cases of COVID-19."),
      br(),
      HTML("<b>Deaths: </b> Deaths due to COVID-19 infection."),
      br(),
      br(),
      HTML("<b>Highchart:</b>"),
      br(),
      HTML("<b>Confirmed cases rate: </b> COVID-19 infection rate per million people in each country."),
      br(),
      HTML("<b>Mortality rate: </b> COVID-19 mortality rate per million people in each country."),
      br(),
      br(),
      HTML("<b>Summary table:</b>"),
      br(),
      HTML("<b>Recovery rate: </b> Recovery rate for COVID-19 based on total confirmed cases of each country."),
      br(),
      HTML("<b>Death rate: </b> The death rate for COVID-19 based on total confirmed cases of each country."),
      br(),
      HTML("<b>Active rate: </b> Active rate for COVID-19 based on total confirmed cases of each country.")
      ),

    mainPanel(


      fluidRow(
        box(
          title = "Logarithmic scale plot",
          width = 12,
          tabPanel("log", plotlyOutput("log", width = "100%", height = 500)),
          br(),
          column(
            htmltools::div(p("Note: Click the country you are interested in the bar plot on left panel.")),
            width = 12))),

      fluidRow(
        box(
          title = "Compare the rates for confirmed cases and mortality",
          width = 12,
          column(
            offset = 4,
            uiOutput("choice"),
            width = 4,
            style = "float: right; padding: 10px, margin-right: 50px"),

          tabPanel("compare rate", highchartOutput("casecompare", width = "100%", height = 500)),
          br(),
          column(
            htmltools::div(p("Note: Some countries' negative rates are directly related to the current and historical approach taken by these countries to report cases."),
                           "You can switch the `Confirmed cases rate` to `Mortality rate` and change countries on the left panel to compare the differences between multiple countries."),
            width = 12))),

      fluidRow(
        box(
          title = "Summary table",
          width = 12,
          htmltools::div(div(class = "title",
                             h3("Summary statistic of Covid-19 cases by each country/region"),
                             p("Clich on the columns names to resort the table."))),
          tabPanel("Summary table", DT::dataTableOutput("summaryTable")),
          br()
          ))
    )))

# page_Visualization <- dashboardPage(
#   title   = "Visualization",
#   header  = dashboardHeader(disable = TRUE),
#   sidebar = dashboardSidebar(disable = TRUE),
#   body    = body_plot_table)


page_Visualization <- page("Visualization", body_plot_table)


