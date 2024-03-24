context("ebirdregioncheck")

test_that("ebirdregioncheck fails correctly", {
  
  expect_error(ebirdregioncheck(), "defunct")
})
  