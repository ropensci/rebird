context("ebirdregion")

test_that("ebirdregion works correctly", {
  skip_on_cran()
  
  out <- ebirdregion(region = 'US', species = 'Setophaga caerulescens', max = 50)
  expect_is(out, "data.frame")
  expect_equal(NCOL(out), 11)
  expect_is(out$comName, "character")
  expect_is(out$howMany, "integer")

  expect_equal(dim(ebirdregion('US-OH', max=10, provisional=TRUE, hotspot=TRUE)), c(10,11))
  
  res <- ebirdregion(region = 'US-CA', max = 10)
  expect_equal(ncol(res), 11)
  
  expect_equal(ncol(ebirdregion(region = 'US', species = 'Accipiter gentilis')), 11)
})
