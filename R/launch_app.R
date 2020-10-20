#' Launch shiny app
#'
#' @description This function can be used to launch shiny app in package.
#'
#' @return Shiny app -- COVID-19 Global Cases
#'
#' @examples
#' library(covid19)
#' #launch_app()
#'
#'
#' @export
launch_app <- function() {
  shiny::runApp('inst/app')
}
