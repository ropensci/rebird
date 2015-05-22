context("ebirdhotspot")

test_that("ebirdhotspot works correctly", {
  skip_on_cran()
  
  out <- ebirdhotspot('L99381', max=10, provisional=TRUE)
  expect_is(out, "data.frame")
  expect_is(out$comName, "character")
  expect_that(ebirdhotspot('L99381'), not(gives_warning()))
  
  expect_warning(ebirdhotspot(locID = 'L99381', back = 40))
})
