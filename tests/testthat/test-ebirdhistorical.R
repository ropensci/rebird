context("ebirdhistorical")

test_that("ebirdhistorical works correctly", {
  skip_on_cran()
  
  out <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19')
  expect_is(out, "data.frame")
  expect_equal(ncol(out), 13)
  expect_gt(nrow(out), 60)
  expect_equal(nrow(out), length(unique(out$speciesCode)))

  out2 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19',sortKey = 'mrec')
  expect_equal(out, out2)
  out3 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19', sortKey = 'create')
  expect_false(isTRUE(all.equal(out, out3)))

  out4 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19', categories = 'all')
  expect_equal(out, out4)
  out5 <- ebirdhistorical(loc = 'US-VA', date = '2017-03-19', categories = 'hybrid')
  expect_equal(nrow(out5), 2)

  out6 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19',max = 2)
  expect_equal(nrow(out6), 2)

  out7 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19',fieldSet = 'simple')
  expect_equal(out, out7)
  out8 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19',fieldSet = 'full')
  expect_equal(ncol(out8), 27)
  expect_equal(nrow(out8), length(unique(out8$speciesCode)))
  
  prov1 <- ebirdhistorical(loc = 'CA-NS-HL', "2019-09-09")
  prov2 <- ebirdhistorical(loc = 'CA-NS-HL', "2019-09-09", provisional = FALSE)
  expect_equal(prov1,prov2)
  prov3 <- ebirdhistorical(loc = 'CA-NS-HL', "2019-09-09", provisional = TRUE)
  expect_gte(nrow(prov3), nrow(prov2))

  out9 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19', limitToHotspots = FALSE)
  expect_equal(out, out9)
  out10 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19', limitToHotspots = TRUE)
  expect_equal(nrow(out10), 51)
  
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
