context("test-ebird_get")

test_that_without_key("ebird_GET errors with no API key", {
  expect_error(ebird_GET(ebase(), args = list(), key = NULL), 
               "You must provide an API key")
})
