#' Shiny dashboard page
#'
#' @description This function creates a shiny dashboard page for using in Shiny app.
#'
#'
#' @param title The title of dashboard page.
#' @param body The dashboard body content.
#'
#'
#' @return Shiny dashboard page
#'
#'
#' @examples
#'
#' body <- shinydashboard::dashboardBody()
#' if (interactive()) {
#'  # Basic dashboard page
#'  shiny::shinyApp(
#'    ui = ui_page("Example", body),
#'    server = function(input, output) { }
#'  )
#' }
#'
#'
#' @export
ui_page <- function(title, body){
  shinydashboard::dashboardPage(
    title = title,
    header  = shinydashboard::dashboardHeader(disable = TRUE),
    sidebar = shinydashboard::dashboardSidebar(disable = TRUE),
    body    = body)
}
