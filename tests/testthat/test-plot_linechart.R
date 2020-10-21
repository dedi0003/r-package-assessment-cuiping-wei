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
    filter(country == "US") %>%
    pivot_wider(names_from = type, values_from = cases)
  p <- plot_linechart(data, date, confirmed, recovered, death)

  expect_true(is.ggplot(p))
  expect_error(plot_linechart(data, date, confirmed, recovered, death), NA)
})
