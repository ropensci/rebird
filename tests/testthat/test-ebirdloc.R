context("ebirdloc")

test_that("ebirdloc fails correctly", {

  expect_error(ebirdregioncheck(), "defunct")
})
