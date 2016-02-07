#' get latitude and longitude from ip address
#'
#' Returns the most recent and nearest reported sighting information
#' with observations of a species.
#' 
#' @export
#' @return a vector of length 2 with lat, lng in that order
#' @examples \dontrun{
#' getlatlng()
#' }
#' @author Andy Teucher \email{andy.teucher@@gmail.com}
#' @references \url{http://ipinfo.io}

getlatlng <- function() {
  locs <- jsonlite::fromJSON(content(GET("http://ipinfo.io"), as = "text", encoding = "UTF-8"))
  warning(paste("As a complete lat/long pair was not provided, your location", 
                "was determined using your computer's public-facing IP", 
                "address. This will likely not reflect your physical", 
                "location if you are using a remote server or proxy."), call. = FALSE)
  as.numeric(strsplit(locs$loc, ",")[[1]])
}
