#' Title
#'
#' @description This function is to produce highchart plot
#'
#' @param df The data
#' @param x The date of COVID19 cases
#' @param ylabs y label
#' @param title plot title
#' @param y The varible you interested
#' @param xlabs x label
#'
#' @return plot
#'
#' @export
plot_highchart <- function(df,x, y, z,  ylabs, xlabs, title){
  x <- enquo(x)
  y <- enquo(y)
  z <- enquo(z)
  data <- df
  highchart() %>%
    hc_add_series(data, "line", hcaes(x = !!quo_name(x), y = !!quo_name(y), group = !!quo_name(z))) %>%
    hc_yAxis(title = list(text = ylabs)) %>%
    hc_xAxis(type = "datetime",
             dateTimeLabelFormats = list(date = '%d/%m/%y'),
             title = list(text = xlabs)) %>%
    hc_title(text = title,
             style = list(color = "black", useHTML = TRUE)) %>%
    hc_tooltip(crosshairs = TRUE,
               backgroundColor = "#FCFFC5",
               shared = TRUE,
               borderWidth = 5,
               table = T)
}
