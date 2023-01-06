test_that("Checking if the data is loaded from the API", {
  mlData <- muskegonLakeBuoyData(y = "rh1", x='weekday')
  expect_error(by, NA)
})

test_that("Getting y dictionary", {
  y_vars <- get_y_vars()
  expect_error(y_vars, NA)
})
test_that("Getting x dictionary", {
  x_vars <- get_x_vars()
  expect_error(x_vars, NA)
})

test_that("Creating plots", {
  mlData <- muskegonLakeBuoyData(y = "rh1", x='weekday')
  plts <- muskegonLakeBuoyGraph(x='weekday',y='rh1',chart_type = 'scatter', mlData)
  expect_error(plts, NA)
})

