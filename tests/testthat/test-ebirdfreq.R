test_that("ebirdfreq works correctly", {
  expect_error(suppressMessages(ebirdfreq("counties", "CA-BC-GV")), "This function has been made temporarily defunct") 
  
  # # Temporary commenting of tests while function is made defunct
  # long <- ebirdfreq("counties", "CA-BC-GV")
  # wide <- ebirdfreq("counties", "CA-BC-GV", long=FALSE)
  # expect_is(long, "data.frame")
  # expect_is(wide, "data.frame")
  # expect_is(long$comName, "character")
  # expect_is(wide$comName, "character")
  # expect_equal(NCOL(long), 4)
  # expect_equal(NCOL(wide), 49)
  # TL1 <- ebirdfreq("hotspots", "L196159", 2015, 2015, 1, 1)
  # TL12 <- ebirdfreq("hotspots", "L196159", 2015, 2015, 1, 12)
  # expect_that(NROW(TL1), is_less_than(NROW(TL12)))
  # expect_equal(NCOL(TL1), NCOL(TL12))
})

test_that("ebirdfreq fails correctly", {
  expect_error(ebirdfreq(startmonth = 0L), 'Invalid month')
  expect_error(ebirdfreq(startyear = 1899L), 'Invalid year')
  expect_error(ebirdfreq())
  expect_error(ebirdfreq("foo"))
  expect_error(ebirdfreq("hotspots", "foo123"), "Invalid hotspot code")
  expect_error(ebirdfreq("country"), "Not a valid location type")
  # expect_error(ebirdfreq("counties", "CA-BC-ZZ"), class = "http_500")
  # expect_error(ebirdfreq("hotspots", "L196159", 1900, 1902, long = FALSE), class = "http_500")
  expect_error(ebirdfreq("foo", "CA-BC-ZZ"), "Not a valid location type")
})
 
