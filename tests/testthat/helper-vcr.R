library("vcr") # *Required* as vcr is set up on loading
invisible(vcr::vcr_configure(
  filter_sensitive_data = list("<<<redacted>>>" = Sys.getenv('EBIRD_KEY')),
  # Remove sensitive information about tester from cassettes
  filter_sensitive_data_regex = list(
    '"ip": "redacted"' = '"ip": "[0-9.]+"',
    '"hostname": "redacted"' = '"hostname": "[^"]*"',
    '"org": "redacted"' = '"org": "[^"]*"'
  ),
  dir = vcr::vcr_test_path("fixtures")
))
vcr::check_cassette_names()
# Create fake EBIRD_KEY if not present (e.g, on CI or CRAN)
if (!nzchar(Sys.getenv("EBIRD_KEY"))) {
  Sys.setenv("EBIRD_KEY" = "fake_key")
}
