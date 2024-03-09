vcr::use_cassette("ebirdgeo", {
  test_that("ebirdgeo works correctly", {
    expect_warning(egeo <- ebirdgeo('amegfi', 42.45, -76.50, dist = 51, max = 2),
                   "Distance supplied was >50km")
    expect_true(inherits(egeo, "data.frame"))
    expect_gt(NCOL(egeo), 10)
    expect_equal(nrow(egeo), 2)
    expect_true(inherits(egeo$locName, "character"))
    expect_true(inherits(egeo$howMany, "integer"))
    expect_warning(
      prov <- ebirdgeo(
        lat = 42.45, lng = -76.50, max=2,
        provisional=TRUE, hotspot=TRUE, back = 31.5),
      "using 30 days"
    )
    expect_true(inherits(prov, "data.frame"))
  })
})
