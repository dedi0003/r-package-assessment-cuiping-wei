#' Launch shiny app
#'
#' @description This function can be used to launch shiny app in package.
#'
#' @return Shiny app -- COVID-19 Global Cases
#'
#' @import shiny
#'
#'
#' @export
launch_app <- function() {
  appDir <- system.file("inst", "app", package = "covid19")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `covid19`.", call. = FALSE)
  }
  shiny::runApp(appDir, display.mode = "normal")
}
