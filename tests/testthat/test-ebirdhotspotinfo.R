context("ebirdhotspotinfo")

test_that("ebirdhotspotinfo works correctly", {
  skip_on_cran()
  
  us <- ebirdhotspotinfo("L99381")
  
  expect_is(us, "data.frame")
  expect_equal(us$name, "Stewart Park")
  expect_equal(NROW(us), 1)
  expect_equal(NCOL(us), 16)
  expect_is(us$name, "character")
  expect_is(us$latitude, "numeric")
  expect_is(us$longitude, "numeric")
})

test_that("ebirdhotspotinfo fails correctly", {
  skip_on_cran()
  
  expect_error(ebirdhotspotinfo())
  expect_error(ebirdhotspotinfo("L00000"), "No hotspot with code")
})

