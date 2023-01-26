test_that("Checking if the data is loaded from the API", {
  mlData <- muskegonLakeBuoyData(y = "rh1", x='weekday')
  expect_error(by, NA)
})


test_that("Creating plots", {
  plts <- muskegonLakeBuoyGraph(x='weekday',y='rh1',chart_type = 'scatter')
  expect_error(plts, NA)
})
