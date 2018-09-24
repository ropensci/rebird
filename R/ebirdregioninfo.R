#' Check if a region type is valid
#'
#' @param loctype One of: 'country', 'states', 'counties'
#' @param loc The location code to be checked. A single location only,
#'   unless \code{loctype = 'country'}.
#' @param ... Curl options passed on to \code{\link[httr]{GET}} 
#'
#' @return A logical vector of the same length as \code{loc}.
#' @export
#' 
#' @examples \dontrun{
#' ebirdregioncheck("country", c("US", "CA"))
#' ebirdregioncheck("states", "CA-BC")
#' ebirdregioncheck("counties","CA-BC-GV")
#' }
#' @author Sebastian Pardo \email{sebpardo@@gmail.com},
#'    Andy Teucher \email{andy.teucher@@gmail.com}
#' @references \url{http://ebird.org/}

ebirdregioncheck <- function(loctype, loc, ...) {

  if (loctype != "country" && length(loc) > 1) {
    stop("More than one location specified")
  }
  
  if (loctype == "country") { 
    args <- list(rtype = "country")
  } else if (loctype == "states") {
    args <- list(rtype = "subnational1", countryCode = substr(loc, 1, 2)) 
  } else if (loctype == "counties") {
    args <- list(rtype = "subnational2",
                 subnational1Code = substr(loc, 1, 5)) 
  } else {
    stop("loctype must be one of 'country', 'states', 'counties'", call. = FALSE)
  }
  
  r <- GET(paste0(ebase(), "ref/location/list"), query = args, ...)
  stop_for_status(r)
  tmp <- read.delim(text = content(r, "text", encoding = "UTF-8"), sep = ",", stringsAsFactors = FALSE)
  loc %in% tmp[, paste0(toupper(args$rtype), "_CODE")]
}
