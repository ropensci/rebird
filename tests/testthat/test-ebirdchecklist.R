vcr::use_cassette("ebirdchecklist", {
  test_that("ebirdchecklist succeeds reproducibly", {

    expect_no_error(out1 <- ebirdchecklist("S117450946"))

    # check all list-columns removed during preprocessing
    expect_false(any(vapply(out1, is.list, logical(1))))

    # Works with breeding code
    expect_true('ON' %in% out1$auxCode)

    expect_is(out1, "data.frame")
    expect_true(nrow(out1) == 6)
    expect_true(ncol(out1) > 0)
    expect_true("checklistId" %in% names(out1))
    expect_equal(out1$checklistId[1], "CL24321")

    # works with media
    expect_no_error(out2 <- ebirdchecklist("S89475689", other = TRUE))
    expect_true('audioCounts' %in% colnames(out2))
    expect_equal(nrow(out2), 2)

  })

  test_that("ebirdchecklist errors for bad input", {

    invalid_checklist_id <- "invalid_id"

    # Expect an error and check if the error message matches the expected pattern
    expect_error(ebirdchecklist(invalid_checklist_id), "subId is invalid")
  })
})
