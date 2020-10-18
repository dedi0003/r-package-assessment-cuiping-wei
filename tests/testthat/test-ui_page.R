context("Shiny dashboard page")

test_that("ui_page", {
  body_map <- shinydashboard::dashboardBody(
    shinydashboard::tabItem("map",
            fluidRow(
              shinydashboard::box(title ="Data updated on 2020-10-18"),
                  width = 12,
                  column(
                    htmltools::div(p("Statistical values of COVID-19")),
                    width = 12))))

  p <- ui_page("map", body_map)
  expect_error(ui_page('map', body_map), NA)
  expect_error(ui_page(body = body_map), 'argument \"title\" is missing, with no default')
  expect_error(ui_page(title = 'map'), 'argument \"body\" is missing, with no default')
  expect_is(p, 'shiny.tag')
  expect_message(p, NA)
})
