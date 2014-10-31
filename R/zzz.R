ebird_compact <- function (l) Filter(Negate(is.null), l)

ebase <- function() 'http://ebird.org/ws1.1/'

ebird_GET <- function(url, args, ...){
  tt <- GET(url, query=args, ...)
  ss <- content(tt, as = "text")
  json <- jsonlite::fromJSON(ss, FALSE)
  if(tt$status_code > 202){
    warning(sprintf("%s", json[[1]]['errorMsg']))
    NA
  } else {
    if(!is.list(json)) NA else rbind_all(lapply(json, data.frame, stringsAsFactors=FALSE))    
  }
}
