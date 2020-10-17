#' Shiny dashboard page
#'
#' @description This function creates a shiny dashboard page for using in Shiny app.
#'
#'
#' @param title The title of dashboard page
#' @param body The dashboard body content
#'
#'
#' @import shinydashboard
#'
#'
#' @return Shiny dashboard page
#'
#'
#' @examples
#' body <- dashboardBody()
#' if (interactive()) {
#'  # Basic dashboard page
#'  library(shiny)
#'  shinyApp(
#'    ui = page("Example", body),
#'    server = function(input, output) { }
#'  )
#' }
#'
#'
#' @export
page <- function(title, body){
  shinydashboard::dashboardPage(
    title = title,
    header  = shinydashboard::dashboardHeader(disable = TRUE),
    sidebar = shinydashboard::dashboardSidebar(disable = TRUE),
    body    = body)
}
