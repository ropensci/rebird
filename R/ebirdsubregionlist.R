#' List sub-regions within a specified region.
#'
#' @param regionType The type of region to search for. Must be one of 'country',
#'  'subnational1' or 'subnational2'.
#' @param parentRegionCode The region to search within. Must be a valid 
#' country or subnational1 code, or 'world'. (The latter is only valid when 
#' searching for regionType of 'country').
#' @param key ebird API key. You can obtain one from https://ebird.org/api/keygen.
#'    We strongly recommend storing it in your \code{.Renviron} file as an
#'    environment variable called \code{EBIRD_KEY}.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#'
#' @return A data.frame containing:
#' @return "code": eBird code for the subregion
#' @return "name": full name for the subregion

#' @export
#'
#' @examples \dontrun{
#' ebirdsubregionlist("country", "world")
#' ebirdsubregionlist("subnational1", "US")
#' ebirdsubregionlist("subnational2", "US-NY")
#' }
#' @author David Bradnum \email{dbradnum@@gmail.com}
#' @references \url{http://ebird.org/}
ebirdsubregionlist <- function(regionType = c("country", "subnational1", "subnational2"),
                               parentRegionCode, key = NULL, ...) {
  regionType <- match.arg(regionType)

  if (regionType == "country") {
    if (parentRegionCode != "world") {
      stop("Invalid input: can only choose regionType of 'country' with parentRegionCode of 'world'.")
    }
  } else {
    # check whether region code exists
    invisible(ebirdregioninfo(parentRegionCode, key = key))
  }
  
  url <- paste0(ebase(), "ref/region/list/", regionType, "/", parentRegionCode)

  args <- list()

  ebird_GET(url, args, key = key, ...)
}
