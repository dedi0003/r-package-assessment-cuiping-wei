#' @export
launch_app <- function() {
  appDir <- system.file("inst", "app", package = "covid19")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `covid19`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
