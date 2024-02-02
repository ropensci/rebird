#' View Checklist
#'
#' @param subId The checklist identifier
#' @param key eBird API key. You can obtain one from https://ebird.org/api/keygen.
#'    We strongly recommend storing it in your \code{.Renviron} file as an
#'    environment variable called \code{EBIRD_KEY}.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#' @param sleep Time (in seconds) before function sends API call (defaults to
#'    zero. Set to higher number if you are using this function in a loop with
#'    many API calls).
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

  args <- list()

  Sys.sleep(sleep)

  tt <- GET(URLencode(url),
            query = ebird_compact(args),
            add_headers("X-eBirdApiToken" = get_key(key)), # removed config = add_headers(...
            # to allow config = to be specified in ...
            ...)

  content(tt, as = "text", encoding = "UTF-8") |>
    fromJSON() |>
    bind_rows()
}
