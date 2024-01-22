vcr::use_cassette("ebirdchecklistfeed", {
  
  test_that("ebirdchecklistfeed succeeds reproducibly", {
    # Check that max query was readjusted to 200 with warning
    expect_warning(
      out1 <- ebirdchecklistfeed(loc = "L207391", date = "2020-03-24", max = 250),
      "Maximum number of results supplied was > 200, using 200."
    )
    # But the query is still successful
    expect_is(out1, "data.frame")
    expect_is(out1$userDisplayName, "character")
    expect_equal(nrow(out1), 7)
    expect_equal(ncol(out1), 9)
  })
  
  test_that("ebirdchecklistfeed errors for bad input", {
    # Bad location ID
    expect_error(ebirdchecklistfeed(loc = "LL207391", date = "2020-03-25", max = 10))
  })
  
  test_that("ebirdchecklistfeed errors locally", {
    # Bad dates
    expect_error(ebirdchecklistfeed(loc = "L207391", date = "2121-03-25"))
    expect_error(ebirdchecklistfeed(loc = "L207391", date = "03-25-2020"))
  })
  
})
