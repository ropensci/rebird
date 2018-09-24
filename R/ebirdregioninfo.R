#' Region info
#'
#@param loctype One of: 'country', 'states', 'counties'
#' @param loc The location code to be checked. A single location only.
#' @param format [nameonly|namequal|detailed|detailednoqual|revdetailed|full] Different options for displaying hieararchy of the region's name. Defaults to full.
#' @param ... Curl options passed on to \code{\link[httr]{GET}} 
#'
#' @return A tibble containing:
#' @return "region": name of the region, varies depending on value of "format" provided
#' @return "bounds.minX", "bounds.maxX", "bounds.minY", "bounds.minY": lat/long bounds of the region 
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
  
  #ebird_GET(url, args, key = key, ...)
#  browser()
  tt <- GET(URLencode(url), 
            query = ebird_compact(args), 
            add_headers("X-eBirdApiToken" = get_key(key)), ...)
  stop_for_status(tt)
  ss <- content(tt, as = "text", encoding = "UTF-8")
  json <- jsonlite::fromJSON(ss, FALSE)
  if (length(json) == 0) stop(paste("No region with code", loc))
  as_data_frame(t(rapply(json, unlist))) %>% 
    rename(region = result) %>% 
    mutate_at(vars(bounds.minX:bounds.maxY), as.numeric)
  #r <- GET(paste0(ebase(), "ref/region/info/", loc), query = args, key = key, ...)
  #stop_for_status(r)
  #tmp <- read.delim(text = content(r, "text", encoding = "UTF-8"), sep = ",", stringsAsFactors = FALSE)
  #loc %in% tmp[, paste0(toupper(args$rtype), "_CODE")]
}
