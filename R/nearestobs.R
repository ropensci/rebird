#' Nearest species sightings
#'
#' Returns the most recent and nearest reported sighting information
#' with observations of a species.
#'
#' @export
#' 
#' @param species (required) Scientific name of the species of interest (not case
#'    sensitive). See eBird taxonomy for more information:
#'    http://ebird.org/content/ebird/about/ebird-taxonomy
#' @param lat Decimal latitude. value between -90.00 and 90.00, up to two
#'    decimal places of precision. Defaults to latitude basd on IP.
#' @param lng Decimal longitude. value between -180.00 and 180.00, up to
#'    two decimal places of precision. Defaults to longitude basd on IP.
#' @param back Number of days back to look for observations (between
#'    1 and 30, defaults to 14).
#' @param max Maximum number of result rows to return in this request
#'    (between 1 and 10000, defaults to all).
#' @param locale Language/locale of response (when translations are available).
#'    See http://java.sun.com/javase/6/docs/api/java/util/Locale.html
#'    (defaults to en_US).
#' @param provisional Should flagged records that have not been reviewed
#'    be included? (defaults to FALSE).
#' @param hotspot Should results be limited to sightings at birding hotspots?
#'    (defaults to FALSE).
#' @param sleep Time (in seconds) before function sends API call (defaults to
#'    zero. Set to higher number if you are using this function in a loop with
#'    many API calls).
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#' @return A data.frame containing the collected information:
#' @return "comName": species common name
#' @return "howMany": number of individuals observed, NA if only presence was noted
#' @return "lat": latitude of the location.
#' @return "lng": longitude of the location.
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
#' 
#' @author Rafael Maia \email{rm72@@zips.uakron.edu}
#' @references \url{http://ebird.org/}
#' @examples \dontrun{
#' nearestobs('branta canadensis', 42, -76)
#' nearestobs('branta canadensis', 42, -76, max=10, provisional=TRUE, hotspot=TRUE)
#' }

nearestobs <-  function(species, lat = NULL, lng = NULL, back = NULL, max = NULL, locale = NULL, 
  provisional = FALSE, hotspot = FALSE, sleep = 0, ...)
{
  Sys.sleep(sleep)

  geoloc <- c(lat,lng)
  if (is.null(geoloc)) geoloc <- getlatlng()

  if (abs(geoloc[1]) > 90) {
    stop("Please provide a latitude between -90 and 90 degrees.")
  }

  if (abs(geoloc[2]) > 180) {
    stop("Please provide a longitude between -180 and 180 degrees.")
  }

  if (!is.null(back)) {
    if (back > 30) {
      back <- 30
      warning("'Back' supplied was >30 days, using 30 days.")
    }
    back <- round(back)
  }

  args <- ebird_compact(list(
    fmt='json', sci=species,
    lat=round(geoloc[1],2), lng=round(geoloc[2],2),
    back=back, maxResults=max,
    locale=locale
  ))

  if(provisional) args$includeProvisional <- 'true'
  if(hotspot) args$hotspot <- 'true'

  ebird_GET(paste0(ebase(), 'data/nearest/geo_spp/recent'), args, ...)
}
