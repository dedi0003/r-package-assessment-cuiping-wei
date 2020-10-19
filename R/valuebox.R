#' Shiny ValueBox output
#'
#' @param ID The ID of valueBox.
#' @param width The width of valueBox.
#'
#'
#' @return ValueBox
#' @export
valuebox <- function(ID, width){
  shinydashboard::valueBoxOutput(ID, width)
}
