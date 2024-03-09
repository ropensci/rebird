vcr::use_cassette("ebirdhotspotlist", {
  test_that("ebirdhotspotlist works correctly", {
    common_tests <- function(i){
      expect_true(inherits(i, "data.frame"))
      expect_true(inherits(i, "tbl_df"))
      expect_gte(NCOL(i), 8)
      expect_true(inherits(i$locId, "character"))
      expect_true(inherits(i$numSpeciesAllTime, "integer"))
    }
    out1 <- ebirdhotspotlist("VA")
    common_tests(out1)
    expect_message(
      out2 <- ebirdhotspotlist(lat = 37.698, lng = -123.008, dist = 1),
      "No region code provided"
    )
    common_tests(out2)
    expect_warning(
      out3 <- ebirdhotspotlist("VA", back = 31),
      "using 30 days"
    )
    common_tests(out3)
    expect_message(
      expect_warning(ebirdhotspotlist(lat = 0, lng = 0, dist = 1000))
    )
  })
  
  test_that("ebirdhotspotlist fails correctly", {
    expect_error(ebirdhotspotlist(c("CA-NS-HL","CA-NS-YA")))
    expect_error(ebirdhotspotlist(""))
    expect_error(ebirdhotspotlist("foobar"))
    expect_error(ebirdhotspotlist("CA-NS-HA"))
    expect_error(ebirdhotspotlist(lat = 40))
    expect_error(ebirdhotspotlist(lat = -91, lng = 0))
    expect_error(ebirdhotspotlist(lat = 0, lng = 181))
    expect_error(ebirdhotspotlist(lat = 51.5, lng = 0, dist = -1))
  })
})
