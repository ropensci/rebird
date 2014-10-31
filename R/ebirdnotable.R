#' Notable sightings
#'
#' Returns the most recent notable observations by either latitude/longitude,
#' hotspot or location ID, or particular region.
#' 
#' @param lat Decimal latitude. value between -90.00 and 90.00, up to two
#'    decimal places of precision.
#' @param lng Decimal longitude. value between -180.00 and 180.00, up to
#'    two decimal places of precision.
#' @param locID Vector containing code(s) for up to 10 locations of interest.
#' @param region Region code corresponding to selected region type.
#' For supported region and coding, see
#' https://confluence.cornell.edu/display/CLOISAPI/eBird-1.1-RegionCodeReference
#' @param regtype Region type you are interested in. can be "country"
#' (e.g. "US"), "subnational1" (states/provinces, e.g. "US-NV") or
#' "subnational2" (counties, not yet implemented, e.g. "US-NY-109"). Default
#' behavior is to try and match according to the region specified.
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
#'    be included? (defaults to FALSE)
#' @param hotspot Should results be limited to sightings at birding hotspots?
#'    (defaults to FALSE).
#' @param simple Logical. Whether to return a simple (TRUE, default) or detailed
#'    (FALSE) set of results fields.
#' @param sleep Time (in seconds) before function sends API call (defaults to
#'    zero.  Set to higher number if you are using this function in a loop with
#'    many API calls).
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#' @note \code{ebirdnotable} requires that either latitude/longitude, location ID,
#' or region be passed to the function. Multiple entries will result in the most
#' specific being used. If none is supplied, defaults to lat/lng based on your IP.
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
#' @return "subnational2Code": county code (returned if simple=FALSE)
#' @return "subnational2Name": county name (returned if simple=FALSE)
#' @return "subnational1Code": state/province ISO code (returned if simple=FALSE)
#' @return "subnational1Name": state/province name (returned if simple=FALSE)
#' @return "countryCode": country ISO code (returned if simple=FALSE)
#' @return "countryName": country name (returned if simple=FALSE)
#' @return "firstName": observer's first name (returned if simple=FALSE)
#' @return "lastName": observer's last name (returned if simple=FALSE)
#' @return "subID": submission ID (returned if simple=FALSE)
#' @return "obsID": observation ID (returned if simple=FALSE)
#' @return "checklistID": checklist ID (returned if simple=FALSE)
#' @return "presenceNoted": 'true' if user marked presence but did not count the
#'   number of birds. 'false' otherwise (returned if simple=FALSE)
#' @export
#' @examples \dontrun{
#' ebirdnotable(lat=42, lng=-70)
#' ebirdnotable(region='US', max=10)
#' ebirdnotable(region='US-OH', regtype='subnational1')
#' }
#' @author Rafael Maia \email{rm72@@zips.uakron.edu}
#' @references \url{http://ebird.org/}

ebirdnotable <-  function(lat = NULL, lng = NULL, dist = NULL, locID = NULL, region = NULL, 
  regtype = NULL, back = NULL, max = NULL, locale = NULL, provisional = FALSE, hotspot = FALSE, 
  simple=TRUE, sleep = 0, ...) 
{
  Sys.sleep(sleep)

  if (!is.null(back)) {
    if (back > 30) {
      back <- 30
      warning("'Back' supplied was > 30 days, using 30 days.")
    }
    back <- round(back)
  }

  args <- list(fmt='json', back=back, maxResults=max, locale=locale)
  if (provisional) args$includeProvisional <- 'true'
  if (hotspot) args$hotspot <- 'true'
  if (!simple) args$detail <- 'full'

  multilocs <- length(c(lat,locID[1],region)) > 1

  # Choose most specific of the locations provided (lat/lng > locID > region)
  if (!is.null(lat)) {
    loctype <- "lat/lng"
    if (abs(lat) > 90) {
      stop("Please provide a latitude between -90 and 90 degrees.")
    }
    if (abs(lng) > 180) {
      stop("Please provide a longitude between -180 and 180 degrees.")
    }
  } else if (!is.null(locID)) {
    loctype <- "locID"
    if (length(locID) > 10) {
      locID <- locID[1:10]
      warning("You supplied > 10 locations, using the first 10")
    }
    url <- paste0(ebase(), 'data/notable/loc/recent')
    args$r <- locID
  } else if (!is.null(region)) {
    loctype <- "region"
    url <- paste0(ebase(), 'data/notable/region/recent')
    args$r <- region
    if (!is.null(regtype)) {
      args$rtype <- regtype
    }
  } else {
    # Get IP location information from http://freegeoip.net
    loctype <- "lat/lng"
    loc <- fromJSON(readLines("http://freegeoip.net/json/", warn=FALSE))
    lat <- loc$latitude
    lng <- loc$longitude
    warning(paste("As no location was provided, your location",
                  "was determined using your computer's public-facing IP",
                  "address. This will likely not reflect your physical",
                  "location if you are using a remote server or proxy.\n",
                  "lat: ", lat, ", lng: ", lng))
  }

  if (loctype == "lat/lng") {
    url <- paste0(ebase(), 'data/notable/geo/recent')
    args$lat <- lat
    args$lng <- lng
    if (!is.null(dist)) {
      if (dist > 50) {
        dist <- 50
        warning("Distance supplied was > 50km, using 50km.")
      }
      args$dist <- round(dist)
    }
  }

  if (multilocs) {
    warning(paste0("You supplied more than one location type, using the most",
                   "specific (", loctype, ")"))
  }

  args <- ebird_compact(args)
  ebird_GET(url, args, ...)
}
