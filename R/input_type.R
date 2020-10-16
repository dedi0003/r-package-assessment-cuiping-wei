#' Title
#'
#' @param df first data
#' @param df1 second data
#' @param ID ID
#' @param label label
#' @param type Iuput type
#'
#' @return
#' @export
input_type <- function(type,df=NULL, df1 = NULL, ID,label){
  type <- enquo(type)
  #z <- enquo(z)

  if (!!quo_name(type) == "pickerInput"){
    shinyWidgets::pickerInput(
      inputId = ID,
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
      inputId = ID,
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
      inputId = ID,
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
      inputId = ID,
      label = label,
      choices = list(
        "Confirmed",
        "Mortality"),
      selected = "Confirmed",
      multiple = FALSE
    )
  }
}
