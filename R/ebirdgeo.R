#' Sightings at location determined by latitude/longitude
#'
#' Returns the most recent sighting date and specific location for the requested
#' species of bird reported within the number of days specified and reported in 
#' the specified area.
#'
#' @param species Scientific name of the species of interest (not case
#'    sensitive). Defaults to NULL, so sightings for all species are returned.
#'    See eBird taxonomy for more information:
#'    http://ebird.org/content/ebird/about/ebird-taxonomy
#' @param lat Decimal latitude. value between -90.00 and 90.00, up to two
#'    decimal places of precision. Defaults to latitude basd on IP.
#' @param lng Decimal longitude. value between -180.00 and 180.00, up to
#'    two decimal places of precision. Defaults to longitude basd on IP.
#' @param dist Distance defining radius of interest from given lat/lng in
#'    kilometers (between 0 and 50, defaults to 25)
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
#'@param ... Curl options passed on to \code{\link[httr]{GET}}
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
#' ebirdgeo('spinus tristis', 42, -76)
#' ebirdgeo(lat=42, lng=-76, max=10, provisional=TRUE, hotspot=TRUE)
#' ebirdgeo('Anas platyrhynchos', 39, -121, max=5)
#' library('httr')
#' ebirdgeo('Anas platyrhynchos', 39, -121, max=5, config=verbose())
#' ebirdgeo('Anas platyrhynchos', 39, -121, max=5, config=user_agent("rebird"))
#' ebirdgeo('Anas platyrhynchos', 39, -121, max=5, config=progress())
#' # ebirdgeo('Anas platyrhynchos', 39, -121, max=5, config=timeout(0.1))
#' }
#' @author Rafael Maia \email{rm72@@zips.uakron.edu}
#' @references \url{http://ebird.org/}

ebirdgeo <-  function(species = NULL, lat = NULL, lng = NULL, dist = NULL, back = NULL, max = NULL, 
  locale = NULL, provisional = FALSE, hotspot = FALSE, sleep = 0, ...) 
{
  Sys.sleep(sleep)
  url <- paste0(ebase(), 'data/obs/', if(!is.null(species)) 'geo_spp/recent' else 'geo/recent')

  geoloc <- c(lat,lng)
  if (is.null(geoloc)) geoloc <- getlatlng()
  if (!is.null(dist)) {
    if (dist > 50) {
      dist <- 50
      warning("Distance supplied was >50km, using 50km.")
    }
    dist <- round(dist)
  }

  if (!is.null(back)) {
    if (back > 30) {
      back <- 30
      warning("'Back' supplied was >30 days, using 30 days.")
    }
    back <- round(back)
  }

  args <- ebird_compact(list(fmt='json', sci=species,
                             lat=round(geoloc[1],2), lng=round(geoloc[2],2),
                             dist=dist, back=back, maxResults=max,
                             locale=locale
  ))

  if (provisional) args$includeProvisional <- 'true'
  if (hotspot) args$hotspot <- 'true'
  ebird_GET(url, args, ...)
}
