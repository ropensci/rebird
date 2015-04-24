eloc_check <- function(loctype, loc) {
  url <- "http://ebird.org/ws1.1/ref/location/list"
  
  if (loctype == "country") { 
    args <- list(rtype = "country")
    } else
    if (loctype == "states") {
      args <- list(rtype = "subnational1",
                   countryCode = substr(loc, 1, 2)) 
      } else
      if (loctype == "counties") {
        args <- list(rtype = "subnational2",
                     subnational1Code = substr(loc, 1, 5)) 
      }
  r <- GET(url, query = args)
  loc %in% content(r)[, paste0(toupper(args$rtype), "_CODE")]
}
