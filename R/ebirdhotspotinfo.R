#' Hotspot info
#'
#' @param locId The hotspot to be checked. A single hotspot only.
#' @param key ebird API key. You can obtain one from https://ebird.org/api/keygen.
#'    We strongly recommend storing it in your \code{.Renviron} file as an 
#'    environment variable called \code{EBIRD_KEY}.
#' @param ... Curl options passed on to \code{\link[httr]{GET}} 
#'
#' @return A data frame containing:
#' @return   "locId":             The hotspot ID
#' @return   "name":              The name of the hotspot
#' @return   "latitude":          hotspot latitude
#' @return   "longitude":         hotspot longitude
#' @return   "countryCode":       hostpot country code
#' @return   "countryName":       country name
#' @return   "subnational1Name":  Subnational name - e.g. state name
#' @return   "subnational1Code":  Subnational code e.g state code
#' @return   "subnational2Code":  Subnational 2 code e.g. county code
#' @return   "subnational2Name":  Subnational 2 code e.g. county name
#' @return   "isHotspot": true,   true if a hotspot 
#' @return   "hierarchical.name":  Composite of name beginning with country name
#' @return   "locID": "L99381"    The hotspot ID
#' 
#' @importFrom utils URLencode
#' @importFrom httr status_code
#' @export
#' 
#' @examples \dontrun{
#' ebirdhotspotinfo("L99381")
#' }
#' @author Guy Babineau \email{guy.babineauo@@gmail.com},
#' @references \url{http://ebird.org/}

ebirdhotspotinfo <- function(locId, key = NULL, ...) {
  if (length(locId) > 1) {
    stop("More than one hotspot specified")
  }
  
  
  url <- paste0(ebase(), "ref/hotspot/info/", locId)
  tt <- GET(URLencode(url), 
            add_headers("X-eBirdApiToken" = get_key(key)), ...)
  
  library('httr')
# Status code 410 indicates not found
  if(status_code(tt)==410 ) stop(paste("No hotspot with code", locId))

# Status code 200 indicates success. No other values are expected
  if(status_code(tt)!=200 ) stop(paste("Non success value for", locId))
  
  stop_for_status(tt)
  ss <- content(tt, as = "text", encoding = "UTF-8")
  json <- jsonlite::fromJSON(ss, FALSE)
  
  if (length(json) == 0) stop(paste("Unexpected error", locId))
  
  df <- as_data_frame(t(rapply(json, unlist))) 
  names(df) <- c("locId", "name", "latitude", "longitude", "countryCode", 
                 "countryName","subnational1Name","subNational1Code",
                 "Subnational2Code","subnational2Name",
                 "isHotspot","name2", "latitude2", "longitude2", "hierarchical.name", "locId2")
  df[,3:4] <- sapply(df[,3:4], as.numeric)
  if (df[11] == "TRUE") {
      df[11]<- TRUE
    }
  else {
      df[11]<- FALSE
    }
  df[,13:14] <- sapply(df[,13:14], as.numeric)
  df
}
