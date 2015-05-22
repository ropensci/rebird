context("ebirdloc")

test_that("ebirdloc works correctly", {
  skip_on_cran()
  
  out <- ebirdloc(c('L99381','L99382'))
  expect_is(out, "data.frame")
  expect_is(out$comName, "character")
  expect_is(ebirdloc('L99381', 'larus delawarensis', provisional=TRUE), "data.frame")
  expect_error(ebirdloc())
  expect_error(ebirdloc(species = "asdf"))
  expect_warning(ebirdloc(locID = "asdfasdf", species = "asdf"))
  
  simpler <- ebirdloc('L99381', max = 1, simple = TRUE)
  lesssimpler <- ebirdloc('L99381', max = 1, simple = FALSE)
  expect_less_than(NCOL(simpler), 15)
  expect_that(NCOL(simpler), not(is_less_than(8)))
  expect_less_than(NCOL(lesssimpler), 30)
  expect_that(NCOL(lesssimpler), not(is_less_than(10)))
})


test_that("ebirdloc fails correctly", {
  skip_on_cran()
  
  mssg <- "You have supplied an invalid species category"
  expect_error(ebirdloc(), "argument \"locID\" is missing")
  expect_error(ebirdloc(locID = c('L99381','L99382','L99381','L99382','L99381','L99382',
                          'L99381','L99382','L99381','L99382','L99382')), 
               "Too many locations")
  expect_error(ebirdloc(locID = 'L99381', config=timeout(0.02)))
  expect_error(suppressWarnings(ebirdloc(locID = 'L99381', sleep = "adf")), "invalid 'time' value")
})
