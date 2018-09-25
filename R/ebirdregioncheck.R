#' Check if a region type is valid
#'
#' @param loc The location code to be checked. 
#' @param key ebird API key. You can obtain one from https://ebird.org/api/keygen.
#'    We strongly recommend storing it in your \code{.Renviron} file as an 
#'    enivronment variable called \code{EBIRD_KEY}.
#' @param ... Curl options passed on to \code{\link[httr]{GET}} 
#'
#' @return Logical.
#' @export
#' 
#' @examples \dontrun{
#' ebirdregioncheck("US")
#' ebirdregioncheck("CA-BC")
#' ebirdregioncheck("CA-BC-GV")
#' }
#' @author Sebastian Pardo \email{sebpardo@@gmail.com},
#'    Andy Teucher \email{andy.teucher@@gmail.com}
#' @references \url{http://ebird.org/}

ebirdregioncheck <- function(loc, ...) {
  .Deprecated(new = "ebirdregioninfo", 
              msg = "Deprecated: 'ebirdregioncheck' will be removed in the next version of rebird. Use 'ebirdregioninfo' instead.")
  if (length(loc) > 1) {
    stop("More than one location specified")
  }
  out <- try(ebirdregioninfo(loc, ...), silent = TRUE)
  if ("try-error" %in% class(out) && 
      !grepl("No region with code", out) &&   # To avoid error when using "HTTP 404" as location
      grepl("HTTP [403|400]", out)) stop(out) # HTTP error codes that should 
                                              # throw errors rather than return false
  "tbl_df" %in% class(out)
}
