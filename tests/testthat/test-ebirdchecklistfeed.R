context("ebirdchecklistfeed")

test_that("ebirdchecklistfeed succeeds reproducibly", {
  skip_on_cran()
  
  out1 <- ebirdchecklistfeed(loc = "L207391", date = "2020-03-24", max = 10)
  expect_is(out1, "data.frame")
  expect_equal(nrow(out1), 8)
  expect_equal(ncol(out1), 5)
})

test_that("ebirdchecklistfeed errors for bad input", {
  skip_on_cran()
  
  expect_error(ebirdchecklistfeed(loc = "L207391", date = "2020-03-25", max = 201))
  expect_error(ebirdchecklistfeed(loc = "L207391", date = "2021-03-25"))
  expect_error(ebirdchecklistfeed(loc = "L207391", date = "03-25-2020"))
})
