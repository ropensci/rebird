vcr::use_cassette("nearestobs", {
  test_that("nearestobs works correctly", {
    
    out <- expect_warning(
      nearestobs('cangoo', 42.46, -76.5, back = 30.5, max = 2),
      "using 30 days"
    )
    out2 <- nearestobs('cangoo', 42.46, -76.5, max=2, provisional=TRUE, hotspot=TRUE)
    
    expect_true(inherits(out, "data.frame"))
    expect_true(inherits(out2, "data.frame"))
    
    expect_equal(NCOL(out), 13)
    expect_equal(NCOL(out2), 13)
    
    expect_true(inherits(out$comName, "character"))
    expect_true(inherits(out$lng, "numeric"))
  })
  
  test_that("ebirdloc fails correctly", {
    
    #expect_error(suppressWarnings(nearestobs("asf")))
    expect_error(nearestobs('asf', 42, -76))
    expect_error(nearestobs('cangoo', 91, -76))
    expect_error(nearestobs('cangoo', 42, -181))
  })
})
