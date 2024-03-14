vcr::use_cassette("ebirdregionspecies", {
  test_that("ebirdregionspecies works correctly", {
    country <- ebirdregionspecies("HM")
    subnat1 <- ebirdregionspecies("SH-SH")
    hotspot <- ebirdregionspecies("L2549512")

    expect_is(country, "data.frame")
    expect_gt(NROW(country), 30)
    expect_equal(NCOL(country), 1)
    expect_is(country$speciesCode, "character")

    expect_is(subnat1, "data.frame")
    expect_gt(NROW(subnat1), 30)

    expect_is(hotspot, "data.frame")
    expect_gt(NROW(hotspot), 20)
  })

  test_that("ebirdregionspecies fails correctly", {
    expect_error(ebirdregionspecies(), 'is missing')
    expect_error(ebirdregionspecies(""), 'No location')
    expect_error(ebirdregionspecies(letters), 'More than one')
  })
})
