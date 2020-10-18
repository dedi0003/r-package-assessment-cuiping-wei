# load sources
source("app/dataTidy.R", local = TRUE)
source("app/ui_map.R", local = TRUE)
source("app/ui_visualization.R", local = TRUE)

# UI
ui <- fluidPage(
  title = "COVID-19 Global Cases",
  theme = shinytheme("flatly"),
  navbarPage(title =  div("COVID-19 Global Cases", style = "pading-left: 10px"),
             collapsible = TRUE,
             fluid = TRUE,
             tabPanel("Map", page_map, value = "page-map"),
             tabPanel("Visualization", page_Visualization, value = "page-Visualization"),
             tabPanel("About",
                      mainPanel(
                        div(includeMarkdown("app/about.md"),
                            style = "margin-left:10%;margin-right:5%;")))
             ))


# server
server <- function(input, output) {
  source("app/map.R", local = TRUE)
  source("app/visualization.R",local = TRUE)
}

# run app
shinyApp(ui = ui, server = server)

