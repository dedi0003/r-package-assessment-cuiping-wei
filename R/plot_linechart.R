#' Linechart
#'
#' @description This function creates a linechart.
#'
#' @param df The data used in producing linechart.
#' @param var A character vector.
#'
#' @importFrom magrittr %>%
#' @importFrom dplyr filter
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
#'  dplyr::filter(date >= '2020-10-10') %>%
#'  dplyr::filter(country %in% c("France", "India", "Austria")) %>%
#'  tidyr::pivot_wider(names_from = type, values_from = cases)
#'
#'  plot_linechart(data, "India")
#'
#'
#'
#' @export
plot_linechart <- function(df, var){
  df %>%
    filter(country == var) %>%
    ggplot(aes(x = date))+
    geom_line(aes(y = confirmed, color = "Confirmed"))+
    geom_line(aes(y = recovered, color = "Recovered")) +
    geom_line(aes(y = death, color = "Deaths")) +
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
