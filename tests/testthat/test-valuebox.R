context("Shiny ValueBox output")

test_that("valuebox", {
  expect_true(TRUE)
  expect_error(valuebox("value_confirmed", 3), NA)
})
