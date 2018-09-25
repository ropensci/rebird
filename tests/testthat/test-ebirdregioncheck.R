context("ebirdregioncheck")

test_that("ebirdregioncheck works correctly", {
  skip_on_cran()
  
  expect_is(ebirdregioncheck("CA"), "logical")
  expect_equal(ebirdregioncheck("CA"), TRUE)
  expect_equal(ebirdregioncheck("CA-BC"), TRUE)
  expect_equal(ebirdregioncheck("CA-BC-CP"), TRUE)
  expect_equal(ebirdregioncheck("ZZ"), FALSE)
  expect_equal(ebirdregioncheck(1L), TRUE)
  expect_equal(ebirdregioncheck("CA-ZZ"), FALSE)
  expect_equal(ebirdregioncheck("counties"), FALSE)
  expect_equal(ebirdregioncheck("HTTP 400"), FALSE)
  expect_equal(ebirdregioncheck("No region with code HTTP 400"), FALSE)
})

test_that("ebirdregioncheck fails correctly", {
  skip_on_cran()
  
  expect_error(ebirdregioncheck())
  expect_error(ebirdregioncheck(c("foo", "bar")))
  expect_error(ebirdregioncheck(c("foo", "bar")))
  expect_error(ebirdregioncheck("foo", "CA-BC-ZZ"))
  expect_error(ebirdregioncheck("CA", key = "foo"))
  expect_error(ebirdregioncheck(c("country", "CA")))
})
  