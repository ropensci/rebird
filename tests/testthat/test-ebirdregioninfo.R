context("ebirdregioninfo")

test_that("ebirdregioninfo works correctly", {
  skip_on_cran()
  
  us <- ebirdregioninfo("US")
  
  expect_is(us, "data.frame")
  expect_equal(us$region, "United States")
  expect_equal(NROW(us), 1)
  expect_equal(NCOL(us), 5)
  expect_is(us$region, "character")
  expect_is(us$minX, "numeric")

  sp <- ebirdregioninfo("L99381")
  
  expect_is(sp, "data.frame")
  expect_equal(sp$name, "Stewart Park")
  expect_equal(NROW(sp), 1)
  expect_equal(NCOL(sp), 16)
  expect_is(sp$name, "character")
  expect_is(sp$latitude, "numeric")
  expect_is(sp$longitude, "numeric")
})

test_that("ebirdregioninfo fails correctly", {
  skip_on_cran()
  
  expect_error(ebirdregioninfo())
  expect_error(ebirdregioninfo("foo"), class = "error")
  expect_error(ebirdregioninfo("CA-BC-ZZ"), "No region with code")
  expect_error(ebirdregioninfo("US", key = "foo"), class = "http_403")
  
  expect_error(ebirdregioninfo("L00000"), "No such hotspot")
})

