#' Checklist feed on a date at a region or hotspot
#' 
#' Returns checklist-level information reported in a given region or hotspot. Note only bird
#' information is species count.
#' 
#' @param loc (required) Region code or locID (if a hotspot). Region code can
#'    be country code (e.g. "US"), subnational1 code (states/provinces, e.g. "US-NV"), or
#'    subnational2 code (counties, e.g. "US-VA-003").
#' @param date (required) Date of historic observation date formatted according 
#'    to ISO 8601 (e.g. 'YYYY-MM-DD', or 'YYYY-MM-DD hh:mm'). Hours and minutes 
#'    are excluded.
#' @param max Maximum number of result rows to return in this request (between 1 and 200, default 10)
#' @param sleep Time (in seconds) before function sends API call. The defaults is
#'    zero. Set this to a higher number if you are using this function in a loop with
#'    many API calls.
#' @param key eBird API key. You can obtain one from https://ebird.org/api/keygen.
#'    We strongly recommend storing it in your \code{.Renviron} file as an 
#'    environment variable called \code{EBIRD_KEY}.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}.
#' @return A data.frame containing the collected information:
#' @return "locId": unique identifier for the locations
#' @return "subId": submission (checklist) identifier
#' @return "userDisplayName": first and last name of the observer
#' @return "numSpecies": number of species reported
#' @return "obsDt": observation date formatted according to ISO 8601 
#'    (e.g. 'YYYY-MM-DD', or 'YYYY-MM-DD hh:mm'). Hours and minutes are excluded 
#'    if the observer did not report an observation time
#' @return "obsTime": observation time (24hr)
#' @return "subID": deprecated submission identifier
#' @return "loc": delimited string of location descriptors
#' @export
#' @examples \dontrun{
#' ebirdchecklistfeed(loc = "L207391", date = "2020-03-24", max = 10)
#' }
#' @author Marianna Foos \email{marianna.foos@@gmail.com}
#' @references \url{http://ebird.org/}
ebirdchecklistfeed <-  function(loc, date, max = 10, sleep = 0, key = NULL, ...)
{
  historicDate = as.Date(date)
  if (Sys.Date() < historicDate) {
    stop(paste0("date must be in the past"))
  }
  if (historicDate < '1800-01-01'){
    stop(paste0("date must be on or after 1800-01-01"))
  }
  Sys.sleep(sleep)

  url <- paste0(ebase(), 'product/lists/', loc, '/',format(historicDate, "%Y"),'/',
                format(historicDate, "%m"),'/',format(historicDate, "%d") )

  args <- list(maxResults = max)

  ebird_GET(url, args, key = key, ...)
}
