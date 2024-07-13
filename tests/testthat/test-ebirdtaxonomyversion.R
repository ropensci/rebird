vcr::use_cassette("ebirdtaxonomyversion", {
  test_that("ebirdtaxonomyversion works correctly", {
    versions <- ebirdtaxonomyversion()
    expect_true(inherits(versions, "data.frame"))
    expect_true(inherits(versions, "tbl_df"))
    expect_equal(ncol(versions), 2)

    latest_version <- ebirdtaxonomyversion(latest_only = TRUE)
    expect_true(inherits(latest_version, "character"))
  })
})
