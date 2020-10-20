#' Linechart
#'
#' @description This function creates a line chart.
#'
#' @param df The data used in producing line chart.
#' @param var A character vector.
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr filter
#' @importFrom rlang .data
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
#'  dplyr::filter(country %in% c("US", "India", "Austria")) %>%
#'  tidyr::pivot_wider(names_from = type, values_from = cases)
#'
#'  plot_linechart(data, "US")
#'
#'
#'
#' @export
plot_linechart <- function(df, var){
  df %>%
    filter(.data$country == var) %>%
    ggplot(aes(x =.data$date))+
    geom_line(aes(y = .data$confirmed, color = "Confirmed"))+
    geom_line(aes(y = .data$recovered, color = "Recovered")) +
    geom_line(aes(y = .data$death, color = "Deaths")) +
    scale_color_manual(breaks = c("Confirmed", "Deaths", "Recovered"),
                       values = c("black", "red", "steelblue")) +
    scale_x_date(date_breaks = "1 month",
                 date_labels = "%b") +
    scale_y_continuous(trans = "log10")+
    labs(title = paste0("Logarithmic scale for COVID-19 cases in ", var),
         x = "Date",
         y = "Count") +
    theme_light()

}
