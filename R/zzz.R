#' @importFrom methods is

ebird_compact <- function(x) Filter(Negate(is.null), x)

ebase <- function() 'https://ebird.org/ws2.0/'

ebird_key <- Sys.getenv("EBIRD_KEY")

ebird_GET <- function(url, args, ...){
  tt <- GET(URLencode(url), query = args, 
            config = add_headers("X-eBirdApiToken" = Sys.getenv("EBIRD_KEY")), 
            ...)
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
      bind_rows(lapply(json, as_data_frame))
    }
  }
}

