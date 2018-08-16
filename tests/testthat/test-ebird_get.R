context("test-ebird_get")

test_that("ebird_GET errors with no API key", {
  old_key <- Sys.getenv("EBIRD_KEY")
  Sys.unsetenv("EBIRD_KEY")
  expect_error(ebird_GET(ebase(), args = list(), key = NULL), 
               "You must provide an API key")
  Sys.setenv(EBIRD_KEY = old_key)     
})
