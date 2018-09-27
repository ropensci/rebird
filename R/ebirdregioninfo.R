#' Region info
#'
#@param loctype One of: 'country', 'states', 'counties'
#' @param loc The location code to be checked. A single location only.
#' @param format Different options for displaying hierarchy of the region's name: [nameonly|namequal|detailed|detailednoqual|revdetailed|full], defaults to full.
#' @param key ebird API key. You can obtain one from https://ebird.org/api/keygen.
#'    We strongly recommend storing it in your \code{.Renviron} file as an 
#'    environment variable called \code{EBIRD_KEY}.
#' @param ... Curl options passed on to \code{\link[httr]{GET}} 
#'
#' @return A data frame containing:
#' @return "region": name of the region, varies depending on value of "format" provided
#' @return "minX", "maxX", "minY", "minY": lat/long bounds of the region 
#' 
#' @importFrom utils URLencode
#' @export
#' 
#' @examples \dontrun{
#' ebirdregioninfo("US")
#' ebirdregioninfo("CA-BC-GV")
#' }
#' @author Sebastian Pardo \email{sebpardo@@gmail.com},
#'    Andy Teucher \email{andy.teucher@@gmail.com}
#' @references \url{http://ebird.org/}

ebirdregioninfo <- function(loc, format = "full", key = NULL, ...) {
  if (length(loc) > 1) {
    stop("More than one location specified")
  }
  
  args <- list(regionNameFormat = format) 
  
  url <- paste0(ebase(), "ref/region/info/", loc)
  
  tt <- GET(URLencode(url), 
            query = ebird_compact(args), 
            add_headers("X-eBirdApiToken" = get_key(key)), ...)
  stop_for_status(tt)
  
  ss <- content(tt, as = "text", encoding = "UTF-8")
  json <- jsonlite::fromJSON(ss, FALSE)
  if (length(json) == 0) stop(paste("No region with code", loc))
  
  df <- as_data_frame(t(rapply(json, unlist))) 
  names(df) <- c("region", "minX", "maxX", "minY", "maxY")
  df[,2:5] <- sapply(df[,2:5], as.numeric)
  df
}
