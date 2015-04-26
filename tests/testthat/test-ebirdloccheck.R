context("ebirdloccheck")

test_that("ebirdloccheck works correctly", {
  expect_is(ebirdloccheck("country", "CA"), "logical")
  expect_equal(ebirdloccheck("country", "CA"), TRUE)
  expect_equal(ebirdloccheck("states", "CA-BC"), TRUE)
  expect_equal(ebirdloccheck("counties", "CA-BC-CP"), TRUE)
  expect_equal(ebirdloccheck("country", "ZZ"), FALSE)
  expect_equal(ebirdloccheck("country", 1L), FALSE)
  expect_equal(ebirdloccheck("states", "CA-ZZ"), FALSE)
  expect_equal(ebirdloccheck("counties", "CA-BC-ZZ"), FALSE)
  expect_error(ebirdloccheck("country", "CA", "US"))
})

test_that("ebirdloccheck fails correctly", {
  expect_error(ebirdloccheck())
  expect_error(ebirdloccheck("country"))
  expect_error(ebirdloccheck("foo", "CA-BC-ZZ"))
  expect_error(ebirdloccheck("country", "CA", "US"))
})

