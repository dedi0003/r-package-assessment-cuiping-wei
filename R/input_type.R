#' Shiny input module
#'
#' @description This function used to create a input module for Shiny app.
#' Only can be used in the built-in Shiny app in `covid19` package.
#'
#'
#' @param df The first data used in function.
#' @param df1 The second data used in function.
#' @param label The label name of input module.
#' @param type Iuput module type.
#' @param inputID The input module ID.
#'
#'
#' @return Input module
#'
#'
#' @export
input_type <- function(type, df=NULL, df1 = NULL, inputID, label){
  type <- enquo(type)

  if (!!quo_name(type) == "pickerInput"){
    shinyWidgets::pickerInput(
      inputId = inputID,
      label = label,
      choices = unique(df$country),
      selected = df1$country[c(1:8)],
      multiple = TRUE,
      options = list(
        `actions-box` = TRUE,
        `live-search` = TRUE,
        size = 12))
  }
  else if(!!quo_name(type) == "dateRangeInput"){
    shiny::dateRangeInput(
      inputId = inputID,
      label = label,
      start = min(df$date),
      end   = max(df$date),
      min = min(df$date),
      max = max(df$date),
      format = "dd-mm-yyyy",
      width = "100%")
  }
  else if(!!quo_name(type) == "sliderInput"){
    shiny::sliderInput(
      inputId = inputID,
      label = label,
      min = min(df$date),
      max = max(df$date),
      value = max(df$date),
      width = "100%",
      animate = animationOptions(loop = FALSE, interval = 250),
      timeFormat = "%d.%m.%Y")
  }
  else{
    shiny::selectInput(
      inputId = inputID,
      label = label,
      choices = list(
        "Confirmed",
        "Mortality"),
      selected = "Confirmed",
      multiple = FALSE
    )
  }
}
