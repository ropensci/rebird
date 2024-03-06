vcr::use_cassette("ebirdhotspot", {
  test_that("ebirdhotspot works correctly", {

    expect_warning(out <- ebirdhotspot('L99381', max = 3, provisional = TRUE))
    expect_is(out, "data.frame")
    expect_is(out$comName, "character")
    expect_warning(expect_error(ebirdhotspot(locID = letters)))
    expect_warning(expect_error(ebirdhotspot(locID = 'L99381', back = 40)))
  })
})
