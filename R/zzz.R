ebird_compact <- function(x) Filter(Negate(is.null), x)

ebase <- function() 'http://ebird.org/ws1.1/'

ebird_GET <- function(url, args, ...){
  tt <- GET(url, query = args, ...)
  ss <- content(tt, as = "text", encoding = "UTF-8")
  json <- jsonlite::fromJSON(ss, FALSE)
  if (tt$status_code > 202) {
    warning(sprintf("%s", json[[1]]['errorMsg']))
    NA
  } else {
    if (!is.list(json)) { 
      return(NA) 
    } else {
      json <- lapply(json, function(x) lapply(x, function(a) {
        if (length(a) == 0) { 
          NA 
        } else if (length(a) > 1) {
          paste0(a, collapse = ",")
        } else {
          if (is(a, "list")) {
            a[[1]]
          } else {
            a
          }
        }
      }))
      rbind_all(lapply(json, data.frame, stringsAsFactors = FALSE))
    }
  }
}
