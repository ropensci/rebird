context("ebirdgeo")

test_that("ebirdgeo works correctly", {
  skip_on_cran()
  skip_on_ci()
  
  egeo <- ebirdgeo('amegfi',42,-76)
  expect_is(egeo, "data.frame")
  expect_gt(NCOL(egeo), 10)
  expect_is(egeo$locName, "character")
  expect_is(egeo$howMany, "integer")
  expect_is(ebirdgeo(lat = 42, lng = -76, max=10, provisional=TRUE, hotspot=TRUE), "data.frame")
  expect_equal(NROW(ebirdgeo(lat = 42, lng = -76, max=10, provisional=TRUE, hotspot=TRUE)), 10)
  expect_silent(ebirdgeo(lat = 40, lng = -120, dist = 50))
  expect_warning(ebirdgeo(lat = 30, lng = -120, dist = 100), "Distance supplied was >50km")
})
