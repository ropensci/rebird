test_that_without_key <- function(desc, code) {
  old_key <- Sys.getenv("EBIRD_KEY")
  Sys.unsetenv("EBIRD_KEY")
  on.exit(Sys.setenv(EBIRD_KEY = old_key))
  test_that(desc, code)
}
