context("Shiny input module")

test_that("input_type", {
  expect_true(TRUE)
  expect_error(input_type(selectInput, inputID = "type", label = "Select Variable" ), NA)
})
