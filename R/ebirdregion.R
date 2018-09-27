#' Recent observations at a region or hotspot
#' 
#' Returns the most recent sighting information reported in a given region or hotspot.
#' 
#' @param loc (required) Region code or locID (for hotspots). Region code can
#' be country code (e.g. "US"), subnational1 (states/provinces, e.g. "US-NV"), or
#' subnational2 code (counties, e.g. "CA-BC-GV").
#' @param species eBird species code. See \code{\link{ebirdtaxonomy}} for a full
#' list of scientific names, common names, and species codes. Alternatively, 
#' you can wrap the scientific name in the \code{\link{species_code}} function 
#' which will return the eBird species code.
#' Defaults to NULL, in which case sightings for all species are returned.
#' See eBird taxonomy for more information:
#' http://ebird.org/content/ebird/about/ebird-taxonomy
#' @param back Number of days back to look for observations (between
#'    1 and 30, defaults to 14).
#' @param max Maximum number of result rows to return in this request
#'    (between 1 and 10000, defaults to all)
#' @param provisional Should flagged records that have not been reviewed
#'    be included? (defaults to FALSE)
#' @param hotspot Should results be limited to sightings at birding hotspots?
#'    (defaults to FALSE).
#' @param simple Logical. Whether to return a simple (TRUE, default) or detailed
#'    (FALSE) set of results fields. Detailed results are only available if 
#'    \code{loc} is a locID.
#' @param sleep Time (in seconds) before function sends API call (defaults to
#'    zero.  Set to higher number if you are using this function in a loop with
#'    many API calls).
#' @inheritParams ebirdtaxonomy
#' @return A data.frame containing the collected information:
#' @return "comName": species common name
#' @return "howMany": number of individuals observed, NA if only presence was noted
#' @return "lat": latitude of the location
#' @return "lng": longitude of the location
#' @return "locID": unique identifier for the location
#' @return "locName": location name
#' @return "locationPrivate": TRUE if location is not a birding hotspot
#' @return "obsDt": observation date formatted according to ISO 8601
#'    (e.g. 'YYYY-MM-DD', or 'YYYY-MM-DD hh:mm'). Hours and minutes are excluded
#'    if the observer did not report an observation time.
#' @return "obsReviewed": TRUE if observation has been reviewed, FALSE otherwise
#' @return "obsValid": TRUE if observation has been deemed valid by either the
#'    automatic filters or a regional viewer, FALSE otherwise
#' @return "sciName" species' scientific name
#' @export
#' @examples \dontrun{
#' ebirdregion(loc = 'US', species = 'btbwar')
#' ebirdregion(loc = 'US', species = species_code('Setophaga caerulescens')) # same as above
#' ebirdregion(loc = 'L196159', species = 'bkcchi', back = 30)
#' ebirdregion('US-OH', max = 10, provisional = TRUE, hotspot = TRUE)
#' }
#' @author Rafael Maia \email{rm72@@zips.uakron.edu}
#' @references \url{http://ebird.org/}

ebirdregion <-  function(loc, species = NULL, back = NULL, max = NULL, 
  locale = NULL, provisional = FALSE, hotspot = FALSE, simple = TRUE, 
  sleep = 0, key = NULL, ...)
{
  Sys.sleep(sleep)
  url <- paste0(ebase(), 'data/obs/', loc, '/recent/', species)

  if (!is.null(back)) back <- round(back)

  args <- list(back=back, maxResults=max, locale=locale)
  
  if (provisional) args$includeProvisional <- 'true'
  if (hotspot) args$hotspot <- 'true'
  if (!simple) args$detail <- 'full'
  
  ebird_GET(url, args, key = key, ...)
}
