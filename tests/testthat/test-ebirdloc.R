context("ebirdloc")

test_that("ebirdloc works correctly", {
  out <- ebirdloc(c('L99381','L99382'))
  expect_is(out, "data.frame")
  expect_equal(ncol(out), 11)
  expect_is(out$comName, "character")
  expect_is(out$howMany, "numeric")
  expect_is(ebirdloc('L99381', 'larus delawarensis', provisional=TRUE), "data.frame")
  expect_equal(nrow(ebirdloc('L99381', 'larus delawarensis', provisional=TRUE)), 1)
  expect_error(ebirdloc())
  expect_error(ebirdloc(species = "asdf"))
  expect_warning(ebirdloc(locID = "asdfasdf", species = "asdf"))
})