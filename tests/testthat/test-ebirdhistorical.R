context("ebirdhistorical")

test_that("ebirdhistorical works correctly", {
  skip_on_cran()
  
  out <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19')
  expect_is(out, "data.frame")
  expect_equal(ncol(out), 12)
  expect_equal(nrow(out), 66)

  out2 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19',sortKey = 'mrec')
  expect_equal(out,out2)
  out2 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19', sortKey = 'create')
  expect_false(isTRUE(all.equal(out, out2)))

  out2 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19', categories = 'all')
  expect_equal(out,out2)
  out2 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19', categories = 'spuh')
  expect_equal(nrow(out2), 1)

  out2 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19',max = 2)
  expect_equal(nrow(out2), 2)

  out2 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19',fieldSet = 'simple')
  expect_equal(out,out2)
  out2 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19',fieldSet = 'full')
  expect_equal(ncol(out2), 27)

  prov1 <- ebirdhistorical(loc = 'US', Sys.Date() - 2)
  prov2 <- ebirdhistorical(loc = 'US', Sys.Date() - 2, provisional = FALSE)
  expect_equal(prov1,prov2)
  prov2 <- ebirdhistorical(loc = 'US', Sys.Date() - 2, provisional = TRUE)
  expect_gte(nrow(prov2), nrow(prov1))

  out2 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19',limitToHotspots = FALSE)
  expect_equal(out,out2)
  out2 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19', limitToHotspots = TRUE)
  expect_equal(nrow(out2), 51)
  
})

test_that("ebirdhistorical works correctly", {
  skip_on_cran()
  
  expect_error(ebirdhistorical(),"argument \"date\" is missing, with no default") 
  
  expect_error(ebirdhistorical(loc = "US-VA-003"), "argument \"date\" is missing, with no default")
  
  expect_error(ebirdhistorical(loc = 'US-VA-003', date = Sys.Date() + 1), "date must be in the past")

  expect_error(ebirdhistorical(loc = 'US-VA-003', '1066-10-16'), "date must be on or after 1800-01-01")

  expect_error(suppressWarnings(ebirdhistorical(locID = 'L99381', date = '2017-03-19', sleep = "adf")), 
               "invalid 'time' value")

})
