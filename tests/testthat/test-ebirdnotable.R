vcr::use_cassette("ebirdnotable", {
  test_that("ebirdnotable works correctly", {
    sys_tm <- system.time(
      expect_warning(
        out <- ebirdnotable(lat=42, lng=-70, dist = 51, max = 2, sleep = 1),
        "using 50km"
      )
    )
    expect_gt(sys_tm['elapsed'], 1)
    expect_is(out, "data.frame")
    expect_equal(dim(out), c(2,13))
    expect_is(out$comName, "character")
    expect_is(out$howMany, "integer")

    oh <- ebirdnotable(region='US-OH', max = 2, regtype='subnational1',
                       provisional = TRUE, hotspot = TRUE, simple = FALSE)
    expect_gte(NCOL(oh), 27)

    expect_warning(
      simpler <- ebirdnotable(lat=42, lng=-70, back = 31, max = 2, simple = TRUE),
      "using 30 days")
    expect_equal(dim(simpler), c(2,13))

    expect_error(ebirdnotable(lat = 91, lng = 45), 'latitude')
    expect_error(ebirdnotable(lat = 45, lng = 181), 'longitude')
    expect_warning(
      ebirdnotable(locID = rep('US-OH', 11), max = 2, regtype = 'subnational1'),
      '10 locations'
    )
    expect_warning(
      outmulti <- ebirdnotable(lat=42, lng=-70, region = 'US', max = 2),
      "more than one location type"
    )
    expect_equal(nrow(outmulti), 2)
  })
})
