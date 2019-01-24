#' Region and hotspot info
#'
#' @param loc The location or hotspot code to be checked. A single location only.
#' @param format Different options for displaying hierarchy of the region's name: [nameonly|namequal|detailed|detailednoqual|revdetailed|full], defaults to full. Not used for hotspots.
#' @param key eBird API key. You can obtain one from https://ebird.org/api/keygen.
#'    We strongly recommend storing it in your \code{.Renviron} file as an 
#'    environment variable called \code{EBIRD_KEY}.
#' @param ... Curl options passed on to \code{\link[httr]{GET}} 
#'
#' @return When region is a hotspot, a data frame (with some redundant information) containing:
#' @return "locId", "locID": hotspot ID
#' @return "name", "locName": hotspot name
#' @return "latitude", "longitude", "lat", "long": hotspot latitude and longitude (point location)
#' @return "countryCode", "countryName": code and name of the country where hotspot is located
#' @return "subnational1Code", "subnational1Name": code and name of the subnational1 area (e.g. state or province) where hotspot is located
#' @return "subnational2Code", "subnational2Name": code and name of the subnational2 area (e.g. county) where hotspot is located
#' @return "isHotspot": logical, whether region is a hotspot (should always be TRUE)
#' @return "hierarchicalName": full hotspot name including subnational1, subnational2, and country info
#' 
#' @return When region is a subnational1, subnational2, or country code, a data frame containing:
#' @return "region": name of the region, varies depending on value of "format" provided
#' @return "bounds.minX", "bounds.maxX", "bounds.minY", "bounds.maxY": lat/long bounds of the region 
#' 
#' @importFrom utils URLencode
#' @export
#' 
#' @examples \dontrun{
#' ebirdregioninfo("US")
#' ebirdregioninfo("CA-BC-GV")
#' ebirdregioninfo("CA-BC-GV", format = "revdetailed") # reverse order of region name
#' ebirdregioninfo("L196159")
#' }
#' @author Sebastian Pardo \email{sebpardo@@gmail.com},
#'    Andy Teucher \email{andy.teucher@@gmail.com}
#' @references \url{http://ebird.org/}

ebirdregioninfo <- function(loc, format = "full", key = NULL, ...) {
  if (length(loc) > 1) {
    stop("More than one location specified")
  }
  
  args <- list(regionNameFormat = format) 
  
  regtype <- "region" 
  if (grepl("^L[0-9]+$", loc)) regtype <- "hotspot" # check whether `loc` is a hotspot
  
  url <- paste0(ebase(), "ref/", regtype, "/info/", loc)
  
  tt <- GET(URLencode(url), 
            query = ebird_compact(args), 
            add_headers("X-eBirdApiToken" = get_key(key)), ...)
  stop_for_status(tt)
  
  ss <- content(tt, as = "text", encoding = "UTF-8")
  json <- jsonlite::fromJSON(ss, FALSE)
  if (length(json) == 0) stop(paste("No region with code", loc))
  
  df <- as_data_frame(t(rapply(json, unlist))) 
  # rename column name for region info (defaults to "result")
  if (names(df)[1] == "result") names(df)[1] <- "region" 
  
  df
}
