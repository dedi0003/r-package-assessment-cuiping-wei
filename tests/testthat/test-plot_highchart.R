test_that("plot_highchart", {
    df <- vctrs::data_frame(
      x = c('2020-05-01', '2020-06-15', '2020-07-30', '2020-08-01', '2020-9-15', '2020-09-30',
            '2020-05-01', '2020-06-15', '2020-07-30', '2020-08-01', '2020-09-15', '2020-09-30'),
      y = c(2000,3000,2000,4000,5000,9000, 1000, 1000, 500, 300, 300, 200),
      z = c("US", "US", "US", "US", "US", "US", "UK", "UK", "UK", "UK", "UK", "UK")
    ) %>%
      dplyr::mutate(x = as.Date(x))
    p <- plot_highchart(df, x, y, z, ylabs = 'Date', xlabs = 'Count', title = 'Highchart')

    expect_error(plot_highchart(df), "No expression to parse")
    expect_error(plot_highchart(df,x, y), "No expression to parse")
    expect_error(p, NA)
    expect_true(is.highchart(p))
    expect_message(p, NA)
  })
