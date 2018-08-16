#' @importFrom methods is

ebird_compact <- function(x) Filter(Negate(is.null), x)

ebase <- function() 'https://ebird.org/ws2.0/'

get_key <- function(key = NULL) {
  if (!is.null(key)) return(key)
  key <- Sys.getenv("EBIRD_KEY")
  if (!nzchar(key)) {
    stop(
    "You must provide an API key from ebird.
    You can pass it to the 'key' argument or store it as 
    an environment variable called EBIRD_KEY in your .Renvrion file.
    If you don't have a key, you can obtain one from:
    https://ebird.org/api/keygen.", call. = FALSE
    )
  }
  key
}

ebird_GET <- function(url, args, key = NULL, ...){
  
  tt <- GET(URLencode(url), 
            query = ebird_compact(args), 
            config = add_headers("X-eBirdApiToken" = get_key(key)), 
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

