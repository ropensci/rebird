#' eBird Taxonomy Version
#'
#' Returns a data.frame of available version numbers of
#' the eBird taxonomy or the latest version number of the
#' taxonomy.
#'
#' @param key eBird API key. You can obtain one from https://ebird.org/api/keygen.
#'    We strongly recommend storing it in your \code{.Renviron} file as an
#'    environment variable called \code{EBIRD_KEY} to avoid having to constantly 
#'    supply the key, and to avoid accidentally sharing it publicly.
#' @param latest_only Whether to return only the latest version number
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#' 
#' @return If `latest_only = FALSE`, a data.frame containing the collected information:
#' @return "authorityVer": Character of version.
#' @return "latest": Boolean indicating whether `authorityVer`` is the latest taxonomy version
#' @return If `latest_only = TRUE`, a character of the latest `authorityVer`
#' 
#' @export
#' 
#' @examples \dontrun{
#' ebirdtaxonomyversion()
#' ebirdtaxonomyversion(latest_only = TRUE)
#' }
#' @author Jordan Bradford \email{jrdnbradford@gmail.com}
#' @references \url{http://ebird.org/}
ebirdtaxonomyversion <- function(key = NULL, latest_only = FALSE, ...) {
  args <- list(fmt = 'json')

  # Allow not using a key for this function
  if (is.null(key) && !nzchar(Sys.getenv("EBIRD_KEY"))) {
    key <- ""
  }

  versions <- ebird_GET(paste0(ebase(), 'ref/taxonomy/versions'), args, key = key, ...)
  versions$authorityVer <- sub("0+$", "", as.character(versions$authorityVer))

  if (latest_only) {
    return(subset(versions, latest == TRUE)$authorityVer)
  }
  versions
}
