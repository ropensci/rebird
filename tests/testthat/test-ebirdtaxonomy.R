context("ebirdtaxonomy")

test_that("ebirdtaxonomy works correctly", {
  skip_on_cran()
  
  out <- ebirdtaxonomy("domestic")
  out2 <- ebirdtaxonomy(cat=c("spuh", "slash"))
  
  expect_is(out, "data.frame")
  expect_is(out, "tbl_df")
  expect_is(out2, "data.frame")
  expect_is(out2, "tbl_df")
  
  expect_is(out$comName, "character")
  expect_is(out$taxonID, "character")
})

test_that("ebirdtaxonomy fails correctly", {
  skip_on_cran()
  
  mssg <- "You have supplied an invalid species category"
  expect_error(ebirdtaxonomy("asf"), mssg)
  expect_error(ebirdtaxonomy(2), mssg)
  
  expect_error(ebirdtaxonomy("spuh", config=timeout(0.02)))
})
