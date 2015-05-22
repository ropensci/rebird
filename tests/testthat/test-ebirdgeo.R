context("ebirdgeo")

test_that("ebirdgeo works correctly", {
  skip_on_cran()
  
  egeo <- ebirdgeo('spinus tristis',42,-76)
  expect_is(egeo, "data.frame")
  expect_equal(ncol(egeo), 11)
  expect_is(egeo$comName, "character")
  expect_is(egeo$howMany, "integer")
  expect_is(ebirdgeo(lat = 42, lng = -76, max=10, provisional=TRUE, hotspot=TRUE), "data.frame")
  expect_equal(nrow(ebirdgeo(lat = 42, lng = -76, max=10, provisional=TRUE, hotspot=TRUE)), 10)
  expect_that(ebirdgeo(lat = 40, lng = -120, dist = 50), not(gives_warning()))
  expect_warning(ebirdgeo(lat = 30, lng = -120, dist = 100), "Distance supplied was >50km")
})
