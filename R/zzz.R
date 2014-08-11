#' ebird's compact fxn
#' @export
#' @param l Input list
#' @keywords internal
ebird_compact <- function (l) Filter(Negate(is.null), l)