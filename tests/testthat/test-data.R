test_that("tax dataset version is latest version", {
  latest_version <- subset(ebirdtaxonomyversion(), latest == TRUE)$authorityVer
  tax <- rebird::tax
  dataset_tax_version <- attr(tax, "version")
  expect_equal(latest_version, dataset_tax_version)
})
