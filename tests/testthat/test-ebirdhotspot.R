context("ebirdhotspot")

test_that("ebirdhotspot works correctly", {
  out <- ebirdhotspot(locID=c('L99381','L99382'), species = 'larus delawarensis')
  expect_is(out, "data.frame")
  expect_equal(dim(out), c(2,11))
  expect_is(out$comName, "character")
  expect_is(out$howMany, "numeric")
  expect_is(ebirdhotspot('L99381', max=10, provisional=TRUE, hotspot=TRUE), "data.frame")
  expect_equal(nrow(ebirdhotspot('L99381', max=10, provisional=TRUE, hotspot=TRUE)), 10)
  expect_that(ebirdhotspot('L99381', dist = 50), not(gives_warning()))
  
  res <- ebirdhotspot('L99381', back=40)
  expect_is(res, "data.frame")
  expect_equal(res$errorCode, "error.data.too_many_back")
})