#' eBird Taxonomy Version
#'
#' Returns a data.frame of available version numbers of the eBird taxonomy
#'
#' @param key optional eBird API key. You can obtain one from https://ebird.org/api/keygen.
#'    We strongly recommend storing it in your \code{.Renviron} file as an
#'    environment variable called \code{EBIRD_KEY} to avoid having to constantly
#'    supply the key, and to avoid accidentally sharing it publicly.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#'
#' @return data.frame containing the collected information:
#' @return "authorityVer": Character of version.
#' @return "latest": Boolean indicating whether `authorityVer` is the latest taxonomy version
#'
#' @export
#'
#' @examples \dontrun{
#' ebirdtaxonomyversion()
#' }
#' @author Jordan Bradford \email{jrdnbradford@gmail.com}
#' @references \url{http://ebird.org/}
ebirdtaxonomyversion <- function(key = NULL, ...) {
  args <- list(fmt = 'json')

  # Allow not using a key for this function
  if (is.null(key) && !nzchar(Sys.getenv("EBIRD_KEY"))) {
    key <- ""
  }

  ebird_GET(paste0(ebase(), 'ref/taxonomy/versions'), args, key = key, ...)
}
