context("ebirdfreq")

test_that("ebirdloccheck works correctly", {
  expect_is(rebird:::ebirdloccheck("country", "CA"), "logical")
  expect_equal(rebird:::ebirdloccheck("country", "CA"), TRUE)
  expect_equal(rebird:::ebirdloccheck("states", "CA-BC"), TRUE)
  expect_equal(rebird:::ebirdloccheck("counties", "CA-BC-CP"), TRUE)
  expect_equal(rebird:::ebirdloccheck("country", "ZZ"), FALSE)
  expect_equal(rebird:::ebirdloccheck("states", "CA-ZZ"), FALSE)
  expect_equal(rebird:::ebirdloccheck("counties", "CA-BC-ZZ"), FALSE)
  expect_error(rebird:::ebirdloccheck("foo", "CA-BC-ZZ"))
})
