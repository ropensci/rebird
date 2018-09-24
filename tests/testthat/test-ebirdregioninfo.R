context("ebirdregioncheck")

test_that("ebirdregioncheck works correctly", {
  skip_on_cran()
  
  expect_is(ebirdregioncheck("country", "CA"), "logical")
  expect_equal(ebirdregioncheck("country", "CA"), TRUE)
  expect_equal(ebirdregioncheck("states", "CA-BC"), TRUE)
  expect_equal(ebirdregioncheck("counties", "CA-BC-CP"), TRUE)
  expect_equal(ebirdregioncheck("country", "ZZ"), FALSE)
  expect_equal(ebirdregioncheck("country", 1L), FALSE)
  expect_equal(ebirdregioncheck("states", "CA-ZZ"), FALSE)
  expect_equal(ebirdregioncheck("counties", "CA-BC-ZZ"), FALSE)
  expect_error(ebirdregioncheck("country", "CA", "US"))
})

test_that("ebirdregioncheck fails correctly", {
  skip_on_cran()
  
  expect_error(ebirdregioncheck())
  expect_error(ebirdregioncheck("country"))
  expect_error(ebirdregioncheck("foo", "CA-BC-ZZ"))
  expect_error(ebirdregioncheck("country", "CA", "US"))
})

