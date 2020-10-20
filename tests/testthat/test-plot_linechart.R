context("Linechart")

test_that("Linechart", {
  library(magrittr)
  library(coronavirus)
  library(ggplot2)
  library(tidyr)
  library(dplyr)

  data("coronavirus")
  data <- coronavirus %>%
    filter(date >= '2020-10-10') %>%
    filter(country %in% c("France", "India", "Austria")) %>%
    pivot_wider(names_from = type, values_from = cases)

  p <- plot_linechart(data, "India")

  expect_true(is.ggplot(p))
  expect_error(plot_linechart(data, "Austria"), NA)
})
