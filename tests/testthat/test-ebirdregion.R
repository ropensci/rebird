vcr::use_cassette("ebirdregion", {
  test_that("ebirdregion works correctly", {
    out <- ebirdregion(loc = 'US', species = 'btbwar', back = 14.75, max = 2)
    expect_is(out, "data.frame")
    expect_equal(ncol(out), 13)
    expect_is(out$comName, "character")
    expect_is(out$howMany, "integer")

    expect_equal(dim(ebirdregion('US-OH', max=3, provisional=TRUE, hotspot=TRUE)), c(3,13))

    res <- ebirdregion(loc = 'US-OR-029', max = 3)
    expect_equal(ncol(res), 13)
    expect_gte(ncol(ebirdregion(loc = 'L109339', species = 'amecro', simple = FALSE)), 26)
  })
})
