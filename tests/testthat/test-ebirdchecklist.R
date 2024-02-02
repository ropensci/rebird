context("ebirdchecklist")

test_that("ebirdchecklist succeeds reproducibly", {
  skip_on_cran()
  skip_on_ci()

  # You will need a valid eBird API key for testing
  valid_checklist_id <- "S160276772"

  out1 <- ebirdchecklist(valid_checklist_id)


  expect_is(out1, "data.frame")
  expect_true(nrow(out1) > 0)
  expect_true(ncol(out1) > 0)
  expect_true("checklistId" %in% names(out1),
              info = "checklistId column not found in the output")

  # Check if the first row's checklistId is "CL28273"
  expect_equal(out1$checklistId[1], "CL28273",
               info = "First row's checklistId is not CL28273")
})

test_that("ebirdchecklist errors for bad input", {
  skip_on_cran()
  skip_on_ci()

  invalid_checklist_id <- "invalid_id"

  expect_error(ebirdchecklist(invalid_checklist_id))
})
