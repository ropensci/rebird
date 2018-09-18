context("species_code")

test_that("species_code works correctly", {
  skip_on_cran()
  
  sp1 <- species_code("anhinga novaehollandiae")
  sp2 <- species_code("Anhinga anhinga")
  expect_is(sp1, "character")
  expect_is(sp2, "character")
  expect_length(sp1, 1)
  expect_length(sp2, 1)
  expect_message(species_code("anhinga novaehollandiae"), "Darter")
})

test_that("species_code fails correctly", {
  skip_on_cran()
  expect_error(species_code())  
  expect_error(species_code(1), "sciname is not a character vector")
  expect_error(species_code(c("anhinga novaehollandiae", "anhinga anhinga")), "length\\(sciname\\) not equal to 1")
  expect_error(species_code("Anhinga fakei"), "No species in eBird taxonomy with matching scientific name.")
})


