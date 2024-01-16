context("ebirdnotable")

test_that("ebirdnotable works correctly", {
  skip_on_cran()
  skip_on_ci()
  
  out <- ebirdnotable(lat=42, lng=-70, max = 40)
  expect_is(out, "data.frame")
  expect_equal(dim(out), c(40,13))
  expect_is(out$comName, "character")
  expect_is(out$howMany, "integer")

  expect_equal(NCOL(ebirdnotable(region='US-OH', regtype='subnational1')), 14)
  
  simpler <- ebirdnotable(lat=42, lng=-70, max = 40, simple = TRUE)
#   lesssimpler <- ebirdnotable(lat=42, lng=-70, max = 40, simple = FALSE)
  expect_equal(dim(simpler), c(40,13))
#   expect_equal(dim(lesssimpler), c(40,24))
  
  expect_gt(
    system.time(ebirdnotable(lat=42, lng=-70, max = 10, sleep = 1))[[3]]
    , 1)
})
