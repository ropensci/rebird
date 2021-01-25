context("ebirdchecklistfeed")

test_that("ebirdchecklistfeed succeeds reproducibly", {
  skip_on_cran()
  
  out1 <- ebirdchecklistfeed(loc = "L207391", date = "2020-03-24", max = 3)
  expect_is(out1, "data.frame")
  expect_is(out1$userDisplayName, "character")
  expect_equal(nrow(out1), 3)
  expect_equal(ncol(out1), 8)
})

test_that("ebirdchecklistfeed errors for bad input", {
  skip_on_cran()
  
  expect_warning(ebirdchecklistfeed(loc = "L207391", date = "2020-03-24", max = 250))
  expect_error(ebirdchecklistfeed(loc = "L207391", date = "2121-03-25"))
  expect_error(ebirdchecklistfeed(loc = "L207391", date = "03-25-2020"))
  expect_error(ebirdchecklistfeed(loc = "LL207391", date = "2020-03-25", max = 10))
})
