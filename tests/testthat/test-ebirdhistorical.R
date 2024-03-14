vcr::use_cassette("ebirdhistorical", {
  test_that("ebirdhistorical works correctly", {
    out <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19', max = 2)
    expect_true(inherits(out, "data.frame"))
    expect_gte(ncol(out), 13)
    expect_equal(nrow(out), 2)
    expect_equal(nrow(out), length(unique(out$speciesCode)))
    
    out2 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19',
                            sortKey = 'mrec', max = 2)
    expect_equal(out, out2)
    out3 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19',
                            sortKey = 'create', max = 2)
    expect_false(isTRUE(all.equal(out, out3)))
    
    out4 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19',
                            categories = 'all', max = 2)
    expect_equal(out, out4)
    out5 <- ebirdhistorical(loc = 'US-VA', date = '2017-03-19', categories = 'hybrid')
    expect_gte(nrow(out5), 2)
    
    out6 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19',max = 2)
    expect_equal(nrow(out6), 2)
    
    out7 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19',fieldSet = 'simple', max = 2)
    expect_equal(out, out7)
    out8 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19',fieldSet = 'full', max = 2)
    expect_gte(ncol(out8), 27)
    expect_equal(nrow(out8), length(unique(out8$speciesCode)))
    expect_equal(out7, out8[,colnames(out7)])

    out10 <- ebirdhistorical(loc = 'US-VA-003', date = '2017-03-19', limitToHotspots = TRUE, max = 2)
    expect_equal(nrow(out10), 2)
    
  })
  
  test_that("ebirdhistorical works correctly", {
    expect_error(ebirdhistorical(),"argument \"date\" is missing, with no default") 
    
    expect_error(ebirdhistorical(loc = "US-VA-003"), "argument \"date\" is missing, with no default")
    
    expect_error(ebirdhistorical(loc = 'US-VA-003', date = Sys.Date() + 1), "date must be in the past")
    
    expect_error(ebirdhistorical(loc = 'US-VA-003', '1066-10-16'), "date must be on or after 1800-01-01")
    
    expect_error(suppressWarnings(ebirdhistorical(locID = 'L99381', date = '2017-03-19', sleep = "adf")), 
                 "invalid 'time' value")
    
  })
})
