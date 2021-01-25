context("ebirdsubregionlist")

test_that("ebirdsubregionlist works correctly", {
  skip_on_cran()
  
  countries = ebirdsubregionlist("country")
  
  expect_is(countries, "data.frame")
  expect_is(countries, "tbl_df")
  
  expect_equal(NCOL(countries), 2)
  expect_gt(NROW(countries), 200)
  expect_is(countries$code, "character")
  
  us1 = ebirdsubregionlist("subnational1", "US")
  us2 = ebirdsubregionlist("subnational2", "US")
  ny2 = ebirdsubregionlist("subnational2", "US-NY")
  
  expect_is(us1, "data.frame")
  expect_is(us1, "tbl_df")
  expect_equal(NCOL(us1), 2)
  
  expect_gt(NROW(us2),NROW(us1))
  expect_gt(NROW(us2),NROW(ny2))
})

test_that("ebirdsubregionlist fails correctly", {
  skip_on_cran()
  
  expect_error(ebirdsubregionlist("foo", "US"))
  expect_error(ebirdsubregionlist("subnational1", "foo"))
  expect_error(ebirdsubregionlist("subnational2", c("US-NY","US-NV")))
  expect_error(ebirdsubregionlist(c("subnational1","subnational2"), "US"))
  expect_error(ebirdsubregionlist("subnational1", ""))
})

