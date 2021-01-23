context("ebirdregionspecies")

test_that("ebirdregionspecies works correctly", {
  skip_on_cran()

  eng <- ebirdregionspecies("GB-ENG")
  lon <- ebirdregionspecies("GB-ENG-LND")
  hotspot <- ebirdregionspecies("L5803024")

  expect_is(eng, "data.frame")
  expect_gt(NROW(eng), 500)
  expect_equal(NCOL(eng), 1)
  expect_is(eng$speciesCode, "character")

  expect_is(lon, "data.frame")
  expect_gt(NROW(lon), 300)
  expect_gt(NROW(eng), NROW(lon))

  expect_is(hotspot, "data.frame")
  expect_gt(NROW(hotspot), 100)
  expect_gt(NROW(lon), NROW(hotspot))
})

test_that("ebirdregionspecies fails correctly", {
  skip_on_cran()

  expect_error(suppressWarnings(ebirdregionspecies()))
  expect_error(suppressWarnings(ebirdregionspecies("")))
  expect_error(suppressWarnings(ebirdregionspecies(c("GB", "FR"))))
})
