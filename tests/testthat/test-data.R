test_that("tax dataset version is latest version", {
  latest_version <- ebirdtaxonomyversion(latest_only = TRUE)
  temp_env <- new.env()
  data("tax", envir = temp_env)
  dataset_tax_version <- temp_env$tax
  dataset_tax_version_version <- attr(dataset_tax_version, "version")
  expect_equal(latest_version, dataset_tax_version_version)
})
