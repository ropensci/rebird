context("ebirdnotable")

test_that("ebirdnotable works correctly", {
  skip_on_cran()
  
  out <- ebirdnotable(lat=42, lng=-70, max = 40)
  expect_is(out, "data.frame")
  expect_equal(dim(out), c(40,11))
  expect_is(out$comName, "character")
  expect_is(out$howMany, "integer")

  expect_equal(ncol(ebirdnotable(region='US-OH', regtype='subnational1')), 11)
  
  simpler <- ebirdnotable(lat=42, lng=-70, max = 40, simple = TRUE)
#   lesssimpler <- ebirdnotable(lat=42, lng=-70, max = 40, simple = FALSE)
  expect_equal(dim(simpler), c(40,11))
#   expect_equal(dim(lesssimpler), c(40,24))
  
  expect_more_than(
    system.time(ebirdnotable(lat=42, lng=-70, max = 10, sleep = 1))[[3]]
    , 1)
})
