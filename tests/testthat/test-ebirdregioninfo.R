context("ebirdregioninfo")

test_that("ebirdregioninfo works correctly", {
  skip_on_cran()
  
  us <- ebirdregioninfo("US")
  
  expect_is(us, "data.frame")
  expect_equal(us$region, "United States")
  expect_equal(NROW(us), 1)
  expect_equal(NCOL(us), 5)
  expect_is(us$region, "character")
  expect_is(us$bounds.minX, "numeric")

  us <- ebirdregioninfo("L99381")
  
  expect_is(us, "data.frame")
  expect_equal(us$name, "Stewart Park")
  expect_equal(NROW(us), 1)
  expect_equal(NCOL(us), 16)
  expect_is(us$name, "character")
  expect_is(us$latitude, "numeric")
  expect_is(us$longitude, "numeric")
})

test_that("ebirdregioninfo fails correctly", {
  skip_on_cran()
  
  expect_error(ebirdregioninfo())
  expect_error(ebirdregioninfo("foo"), "Internal Server Error \\(HTTP 500\\).")
  expect_error(ebirdregioninfo("CA-BC-ZZ"), "No region with code")

  expect_error(ebirdregioninfo("L00000"), "No such hotspot. L00000")
})

