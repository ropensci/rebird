context("ebirdregioncheck")

test_that("ebirdregioncheck works correctly", {
  skip_on_cran()
  skip_on_ci()
 
  expect_warning(expect_is(ebirdregioncheck("CA"), "logical"))
  expect_warning(expect_equal(ebirdregioncheck("CA"), TRUE))
  expect_warning(expect_equal(ebirdregioncheck("CA-BC"), TRUE))
  expect_warning(expect_equal(ebirdregioncheck("CA-BC-CP"), TRUE))
  expect_warning(expect_equal(ebirdregioncheck("ZZ"), FALSE))
  expect_warning(expect_equal(ebirdregioncheck(1L), TRUE))
  expect_warning(expect_equal(ebirdregioncheck("CA-ZZ"), FALSE))
  expect_warning(expect_equal(ebirdregioncheck("counties"), FALSE))
  expect_warning(expect_equal(ebirdregioncheck("HTTP 400"), FALSE))
  expect_warning(expect_equal(ebirdregioncheck("No region with code HTTP 400"), FALSE))
})

test_that("ebirdregioncheck fails correctly", {
  skip_on_cran()
  skip_on_ci()
  
  expect_error(suppressWarnings(ebirdregioncheck()))
  expect_error(suppressWarnings(ebirdregioncheck(c("foo", "bar"))))
  expect_error(suppressWarnings(ebirdregioncheck(c("foo", "bar"))))
  expect_error(suppressWarnings(ebirdregioncheck("foo", "CA-BC-ZZ")))
  expect_error(suppressWarnings(ebirdregioncheck("CA", key = "foo")))
  expect_error(suppressWarnings(ebirdregioncheck(c("country", "CA"))))
})
  