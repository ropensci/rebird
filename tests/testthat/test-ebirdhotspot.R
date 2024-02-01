context("ebirdhotspot")

test_that("ebirdhotspot works correctly", {
  skip_on_cran()
  skip_on_ci()
  
  expect_warning(out <- ebirdhotspot('L99381', max = 10, provisional = TRUE))
  expect_is(out, "data.frame")
  expect_is(out$comName, "character")
  expect_warning(ebirdhotspot('L99381'))
  
  expect_warning(expect_error(ebirdhotspot(locID = 'L99381', back = 40)))
})
