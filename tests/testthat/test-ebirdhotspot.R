context("ebirdhotspot")

test_that("ebirdhotspot works correctly", {
  out <- ebirdhotspot(locID=c('L99381','L99382'), species = 'larus delawarensis')
  expect_is(out, "data.frame")
  expect_equal(NCOL(out), 11)
  expect_is(out$comName, "character")
  expect_is(out$howMany, "numeric")
  expect_is(ebirdhotspot('L99381', max=10, provisional=TRUE), "data.frame")
  expect_equal(nrow(ebirdhotspot('L99381', max=10, provisional=TRUE)), 10)
  expect_that(ebirdhotspot('L99381'), not(gives_warning()))
  
  expect_warning(ebirdhotspot(locID = 'L99381', back = 40))
})