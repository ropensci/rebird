context("ebirdtaxonomy")

test_that("ebirdtaxonomy works correctly", {
  out <- ebirdtaxonomy()
  out2 <- ebirdtaxonomy(cat=c("spuh", "slash"))
  
  expect_is(out, "data.frame")
  expect_is(out2, "data.frame")
  
  expect_equal(ncol(out), 3)
  expect_equal(ncol(out), 3)
  
  expect_is(out$comName, "character")
  expect_is(out$taxonID, "character")
  
  expect_error(ebirdtaxonomy("asf"), "You have supplied an invalid species category")
})