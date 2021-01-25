#' List sub-regions within a specified region.
#'
#' @param regionType The type of region to search for. Must be one of 'country',
#'  'subnational1' or 'subnational2'.
#' @param parentRegionCode The region to search within. Must be a valid 
#' country or subnational1 code. If `regionType` is 'country' then this 
#' parameter is ignored (since the search will automatically be world-wide).
#' @param key eBird API key. You can obtain one from https://ebird.org/api/keygen.
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
#' ebirdsubregionlist("country")
#' ebirdsubregionlist("subnational1", "US")
#' ebirdsubregionlist("subnational2", "US-NY")
#' }
#' @author David Bradnum \email{dbradnum@@gmail.com}
#' @references \url{http://ebird.org/}
ebirdsubregionlist <- function(regionType = c("country", "subnational1", "subnational2"),
                               parentRegionCode, key = NULL, ...) {
  regionType <- match.arg(regionType)

  if (regionType == "country") {
    parentRegionCode = "world"
  } else {
    # check whether region code exists
    invisible(ebirdregioninfo(parentRegionCode, key = key))
    if (grepl("[A-Z]{2}-[A-Z]{2,3}-[A-Z0-9]{2,3}", parentRegionCode)) {
      stop("Value of 'parentRegionCode' is subnational2. Change to subnational1 or country code.")
    }
  }
  
  url <- paste0(ebase(), "ref/region/list/", regionType, "/", parentRegionCode)

  args <- list()

  ebird_GET(url, args, key = key, ...)
}
