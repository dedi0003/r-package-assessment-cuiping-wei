test_that("page", {
  covid19 <- vctrs::data_frame(
    date = c('2019-10-01', '2019-12-01', '2020-05-01', '2020-10-01')
  )
  body_map <- shinydashboard::dashboardBody(
    shinydashboard::tabItem("map",
            fluidRow(
              shinydashboard::box(title = paste0("Data updated on ", max(covid19$date)),
                  width = 12,
                  column(
                    htmltools::div(p("Statistical values of COVID-19")),
                    width = 12))))
    )

  p <- page("map", body_map)
  expect_error(page('map', body_map), NA)
  expect_error(page(body = body_map), 'argument \"title\" is missing, with no default')
  expect_error(page(title = 'map'), 'argument \"body\" is missing, with no default')
  expect_is(p, 'shiny.tag')
  expect_message(p, NA)
})
