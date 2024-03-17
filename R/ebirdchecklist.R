#' View Checklist
#'
#' @param subId The checklist identifier
#' @param sleep Time (in seconds) before function sends API call (defaults to
#'    zero. Set to higher number if you are using this function in a loop with
#'    many API calls).
#' @param key eBird API key. You can obtain one from https://ebird.org/api/keygen.
#'    We strongly recommend storing it in your \code{.Renviron} file as an
#'    environment variable called \code{EBIRD_KEY}.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#'
#' @return A data.frame containing:
#' @export
#'
#' @examples \dontrun{
#' ebirdchecklist("S121423354")
#' }
#' @references \url{http://ebird.org/}
ebirdchecklist <- function(subId, sleep = 0, key = NULL, ...) {

  url <- paste0(ebase(), "product/checklist/view/", subId)

  Sys.sleep(sleep)

  response <- GET(URLencode(url),
            query = ebird_compact(list()),
            add_headers("X-eBirdApiToken" = get_key(key)),
            ...)

  content_text <- content(response, as = "text", encoding = "UTF-8")
  content_json <- fromJSON(content_text, flatten = FALSE)

  # Check if the response contains an error message
  if ("error" %in% names(content_json) || "errors" %in% names(content_json)) {
    error_message <- ifelse("error" %in% names(content_json),
                            paste("Error detected:", content_json$error$status, content_json$error$title),
                            paste("Errors detected:", content_json$errors$status, content_json$errors$title))
    stop("Checklist ID is invalid")
  }

  bind_rows(content_json)
}
