#' Linechart
#'
#' @description This function creates a line chart.
#'
#' @param df The data used in producing line chart.
#' @param date A date vector.
#' @param y1 The first y variable.
#' @param y2 The second y variable.
#' @param y3 The third y variable.
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr filter
#' @import rlang
#' @import ggplot2
#'
#'
#' @return Linechart
#'
#'
#' @examples
#' library(magrittr)
#' library(coronavirus)
#' library(ggplot2)
#'
#' data("coronavirus")
#' data <- coronavirus %>%
#'  dplyr::filter(date >= '2020-09-10' & date <= '2020-10-10') %>%
#'  dplyr::filter(country == "US") %>%
#'  tidyr::pivot_wider(names_from = type, values_from = cases)
#'
#'  plot_linechart(data, date, confirmed, recovered, death)
#'
#'
#'
#' @export
plot_linechart <- function(df, date, y1, y2, y3){
    ggplot2::ggplot(df, aes(x = {{date}}))+
    geom_line(aes(y = {{y1}}, color = "Confirmed"))+
    geom_line(aes(y = {{y2}}, color = "Recovered")) +
    geom_line(aes(y = {{y3}}, color = "Deaths")) +
    scale_color_manual(breaks = c("Confirmed", "Deaths", "Recovered"),
                       values = c("black", "red", "steelblue")) +
    scale_x_date(date_breaks = "1 month",
                 date_labels = "%b") +
    scale_y_continuous(trans = "log10")+
    labs(title = paste0("Logarithmic scale for COVID-19 cases in ", df$country),
         x = "Date",
         y = "Count") +
    theme_light()

}
