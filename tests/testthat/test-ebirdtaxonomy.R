vcr::use_cassette("ebirdtaxonomy", {
  test_that("ebirdtaxonomy works correctly", {
    out <- ebirdtaxonomy("domestic", species = c('btbwar', 'mallar2', 'gragoo1'))
    expect_true(inherits(out, "data.frame"))
    expect_true(inherits(out, "tbl_df"))
    expect_equal(nrow(out), 2)

    out2 <- ebirdtaxonomy(cat=c("spuh", "slash"),
                          species = c('passer1', 'bird1', 'amewoo', 'y00335'))
    expect_equal(nrow(out2), 3)
    expect_true(inherits(out2, "data.frame"))
    expect_true(inherits(out2, "tbl_df"))
    expect_true(inherits(out2$comName, "character"))
    expect_true(inherits(out2$taxonOrder, "numeric"))
  })

  test_that("ebirdtaxonomy fails correctly", {
    mssg <- "You have supplied an invalid species category"
    expect_error(ebirdtaxonomy("asf"), mssg)
    expect_error(ebirdtaxonomy(2), mssg)
    isc <- 'Invalid species code'
    expect_error(ebirdtaxonomy(species = character(0)), isc)
    expect_error(ebirdtaxonomy(species = NA_character_), isc)
  })

  test_that("ebirdtaxonomy works without an API key", {
    withr::with_envvar(
      c('EBIRD_KEY' = NA),
      {
        expect_equal(Sys.getenv('EBIRD_KEY'), "")
        rwbl <- ebirdtaxonomy(species = 'rewbla')
        expect_true(inherits(rwbl, "data.frame"))
        expect_gte(ncol(rwbl), 12L)
        expect_true(nrow(rwbl) == 1)
      }
    )
  })
})
