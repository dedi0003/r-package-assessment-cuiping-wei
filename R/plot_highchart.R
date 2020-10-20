#' Highchart
#'
#' @description This function creates a interactive highchart plot,
#' which can be rendered by Shiny app.
#'
#'
#' @param df The data used in producing highchart.
#' @param x A date vector.
#' @param ylabs The label name of yAxis.
#' @param title The title of plot.
#' @param y A character vector.
#' @param group A discrete variable.
#' @param xlabs The label name of xAxis.
#'
#'
#' @importFrom rlang enquo
#' @importFrom rlang quo_name
#' @importFrom magrittr %>%
#' @importFrom dplyr filter
#' @import highcharter
#'
#'
#'
#' @return Highchart
#'
#'
#'
#' @examples
#' library(magrittr)
#' library(coronavirus)
#'
#' data("coronavirus")
#' data <- coronavirus %>%
#'         dplyr::filter(date >= '2020-10-10') %>%
#'         dplyr::filter(country %in% c("Afghanistan", "Liberia", "Austria")) %>%
#'         dplyr::filter(type == "confirmed")
#'
#' plot_highchart(df = data, x = date, y = cases, group = country, ylabs = 'Confirmed cases',
#'                xlabs = 'Date', title = 'Highchart for COVID-19')
#'
#'
#' @export
plot_highchart <- function(df,x, y, group,  ylabs, xlabs, title){
  x <- enquo(x)
  y <- enquo(y)
  group <- enquo(group)
  data <- df
  highchart() %>%
    hc_add_series(data, "line", hcaes(x = !!quo_name(x), y = !!quo_name(y), group = !!quo_name(group))) %>%
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
