context("nearestobs")

test_that("nearestobs works correctly", {
  skip_on_cran()
  skip_on_ci()
  
  out <- nearestobs('cangoo', 42, -76)
  out2 <- nearestobs('cangoo', 42,-76, max=10, provisional=TRUE, hotspot=TRUE)
  
  expect_is(out, "data.frame")
  expect_is(out2, "data.frame")
  
  expect_equal(NCOL(out), 13)
  expect_equal(NCOL(out2), 13)
  
  expect_is(out$comName, "character")
  expect_is(out$lng, "numeric")
})

test_that("ebirdloc fails correctly", {
  skip_on_cran()
  
  expect_error(suppressWarnings(nearestobs("asf")))
  expect_error(nearestobs('asf', 42, -76))
})
