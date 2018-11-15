#' @importFrom methods is
#' @importFrom utils URLencode
#' @importFrom dplyr bind_rows
#' @importFrom dplyr as_data_frame
#' @importFrom httr GET
#' @importFrom httr add_headers
#' @importFrom httr content
#' @importFrom httr stop_for_status
#' @importFrom httr http_error
#' @importFrom jsonlite fromJSON

ebird_compact <- function(x) Filter(Negate(is.null), x)

ebase <- function() 'https://ebird.org/ws2.0/'

get_key <- function(key = NULL) {
  if (!is.null(key)) return(key)
  key <- Sys.getenv("EBIRD_KEY")
  if (!nzchar(key)) {
    stop(
    "You must provide an API key from eBird.
    You can pass it to the 'key' argument or store it as 
    an environment variable called EBIRD_KEY in your .Renviron file.
    If you don't have a key, you can obtain one from:
    https://ebird.org/api/keygen.", call. = FALSE
    )
  }
  key
}

ebird_GET <- function(url, args, key = NULL, ...){
  
  tt <- GET(URLencode(url), 
            query = ebird_compact(args), 
            add_headers("X-eBirdApiToken" = get_key(key)), # removed config = add_headers(...
                                                           # to allow config = to be specified in ...
            ...)

  # Testing for errors and providing informative error messages
  # if request contains error information, provide that error message
  if (http_error(tt) & !is.raw(content(tt))) stop(paste(content(tt)$error[[1]], collapse = " -- "))
  # if API key is invalid the API gives error 403 but doesn't provide content so there isn't an error message.
  # Thus error message is specified below.
  if (tt$status_code == 403 & is.raw(content(tt))) {
    stop_for_status(tt, task = "connect to eBird API. Invalid token")
  }
  stop_for_status(tt)   # in case any cases fall through the cracks above
  
  ss <- content(tt, as = "text", encoding = "UTF-8")
  json <- fromJSON(ss, FALSE)
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

