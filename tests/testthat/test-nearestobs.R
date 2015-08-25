context("nearestobs")

test_that("nearestobs works correctly", {
  skip_on_cran()
  
  out <- nearestobs('branta canadensis', 42, -76)
  out2 <- nearestobs('branta canadensis', 42,-76, max=10, provisional=TRUE, hotspot=TRUE)
  
  expect_is(out, "data.frame")
  expect_is(out2, "data.frame")
  
  expect_equal(ncol(out), 11)
  expect_equal(ncol(out2), 11)
  
  expect_is(out$comName, "character")
  expect_is(out$lng, "numeric")
  
  expect_warning(nearestobs("asf", 42, -76), "Unknown species: asf")
  
  expect_equal(suppressWarnings(nearestobs("asf")), NA)
})
