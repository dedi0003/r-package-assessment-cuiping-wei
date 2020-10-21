#' Launch shiny app
#'
#' @description This function can be used to launch shiny app in package.
#'
#' @return Shiny app -- COVID-19 Global Cases
#'
#' @examples
#' \dontrun{
#' library(covid19)
#' launch_app()
#' }
#'
#'
#' @export
launch_app <- function() {
  appDir <- system.file("app", package = "covid19")
  if (appDir == "") {
    stop("Could not find shiny app directory. Try re-installing `covid19`.", call. = FALSE)
  }
  shiny::runApp(appDir, display.mode = "normal")
}
