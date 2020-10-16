#' Title
#'
#' @param title page title
#' @param body page-body
#'
#' @return
#' @export
page <- function(title, body){
  #body <- enquo(body)
  shinydashboard::dashboardPage(
    title = title,
    header  = shinydashboard::dashboardHeader(disable = TRUE),
    sidebar = shinydashboard::dashboardSidebar(disable = TRUE),
    body    = body)
}
