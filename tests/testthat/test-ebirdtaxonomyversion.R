vcr::use_cassette("ebirdtaxonomyversion", {
  test_that("ebirdtaxonomyversion works correctly", {
    versions <- ebirdtaxonomyversion()
    expect_true(inherits(versions, "data.frame"))
    expect_true(inherits(versions, "tbl_df"))
    expect_equal(ncol(versions), 2)
    expect_true(all(c("authorityVer", "latest") %in% names(versions)))
  })
})
