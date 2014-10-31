#' Recent observations at a region
#' 
#' Returns the most recent sighting information reported in a given region.
#' 
#' @param region (required) Region code corresponding to selected region type.
#' For supported region and coding, see
#' https://confluence.cornell.edu/display/CLOISAPI/eBird-1.1-RegionCodeReference
#' @param regtype Region type you are interested in. can be "country"
#' (e.g. "US"), "subnational1" (states/provinces, e.g. "US-NV") or
#' "subnational" (counties, not yet implemented, e.g. "US-NY-109"). Default
#' behavior is to try and match according to the region specified.
#' @param species scientific name of the species of interest (not case
#' sensitive). Defaults to NULL, in which case sightings for all species are returned.
#' See eBird taxonomy for more information:
#' http://ebird.org/content/ebird/about/ebird-taxonomy
#' @param back Number of days back to look for observations (between
#'    1 and 30, defaults to 14).
#' @param max Maximum number of result rows to return in this request
#'    (between 1 and 10000, defaults to all)
#' @param locale Language/locale of response (when translations are available).
#'    See http://java.sun.com/javase/6/docs/api/java/util/Locale.html
#'    (defaults to en_US)
#' @param provisional Should flagged records that have not been reviewed
#'    be included? (defaults to FALSE)
#' @param hotspot Should results be limited to sightings at birding hotspots?
#'    (defaults to FALSE).
#' @param sleep Time (in seconds) before function sends API call (defaults to
#'    zero.  Set to higher number if you are using this function in a loop with
#'    many API calls).
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
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
#' ebirdregion(region = 'US', species = 'Setophaga caerulescens')
#' ebirdregion('US-OH', max=10, provisional=TRUE, hotspot=TRUE)
#' }
#' @author Rafael Maia \email{rm72@@zips.uakron.edu}
#' @references \url{http://ebird.org/}

ebirdregion <-  function(region, species = NULL, regtype = NULL, back = NULL, max = NULL, 
  locale = NULL, provisional = FALSE, hotspot = FALSE, sleep = 0, ...)
{
  Sys.sleep(sleep)
  url <- paste0(ebase(), 'data/obs/', if(!is.null(species)) 'region_spp/recent' else 'region/recent')

  if(!is.null(regtype))
    regtype <- match.arg(regtype, choices = c("country", "subnational1", "subnational2"))
  if(!is.null(back)) back <- round(back)

  args <- ebird_compact(list(
    fmt='json', r=region, rtype=regtype,
    sci=species, back=back,
    maxResults=max, locale=locale
  ))
  if(provisional) args$includeProvisional <- 'true'
  if(hotspot) args$hotspot <- 'true'
  
  ebird_GET(url, args, ...)
}
