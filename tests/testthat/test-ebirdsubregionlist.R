vcr::use_cassette("ebirdsubregionlist", {
  test_that("ebirdsubregionlist works correctly", {

    countries = ebirdsubregionlist("country")
    expect_true(inherits(countries, "data.frame"))
    expect_true(inherits(countries, "tbl_df"))
    expect_equal(NCOL(countries), 2)
    expect_gt(NROW(countries), 200)
    expect_true(inherits(countries$code, "character"))

    bz1 = ebirdsubregionlist("subnational1", "BZ")
    expect_true(inherits(bz1, "data.frame"))
    expect_true(inherits(bz1, "tbl_df"))
    expect_equal(NCOL(bz1), 2)

    ri2 = ebirdsubregionlist("subnational2", "US-RI")
    expect_true(inherits(ri2, "data.frame"))
    expect_true(inherits(ri2, "tbl_df"))
    expect_equal(NCOL(ri2), 2)

  })
  
  test_that("ebirdsubregionlist fails correctly", {

    expect_error(ebirdsubregionlist("foo", "US"))
    expect_error(ebirdsubregionlist("subnational1", "foo"))
    expect_error(ebirdsubregionlist("subnational2", c("US-NY","US-NV")))
    expect_error(ebirdsubregionlist(c("subnational1","subnational2"), "US"))
    expect_error(ebirdsubregionlist("subnational1", ""))
    expect_error(ebirdsubregionlist("subnational2", "US-RI-005"), "is subnational2")
  })
})
