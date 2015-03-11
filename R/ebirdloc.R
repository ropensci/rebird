#' Recent observations at a locality
#' 
#' Returns the most recent sighting information reported in a given vector 
#' of locations (including non-hotspots).
#' 
#' @param locID (required) Vector containing code(s) for up to 10 regions of interest; 
#' here, values that are not hotspots are returned. Values that are not valid are ignored. 
#' @param species Scientific name of the species of interest (not case 
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
#' @param simple Logical. Whether to return a simple (TRUE, default) or detailed
#'    (FALSE) set of results fields.
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
#' @return "subnational2Code": county code (returned if simple=FALSE)
#' @return "subnational2Name": county name (returned if simple=FALSE)
#' @return "subnational1Code": state/province ISO code (returned if simple=FALSE)
#' @return "subnational1Name": state/province name (returned if simple=FALSE)
#' @return "countryCode": country ISO code (returned if simple=FALSE)
#' @return "countryName": country name (returned if simple=FALSE)
#' @return "userDisplayName": first and last name of the observer (returned if simple=FALSE) 
#' @return "firstName": observer's first name (returned if simple=FALSE)
#' @return "lastName": observer's last name (returned if simple=FALSE)
#' @return "subID": submission ID (returned if simple=FALSE)
#' @return "obsID": observation ID (returned if simple=FALSE)
#' @return "checklistID": checklist ID (returned if simple=FALSE)
#' @return "presenceNoted": 'true' if user marked presence but did not count the
#'   number of birds. 'false' otherwise (returned if simple=FALSE)
#' @export
#' @examples \dontrun{
#' ebirdloc(locID = c('L99381','L99382'))
#' ebirdloc('L99381', 'Branta canadensis', provisional=TRUE)
#' }
#' @author Rafael Maia \email{rm72@@zips.uakron.edu}
#' @references \url{http://ebird.org/}

ebirdloc <-  function(locID, species=NULL, back = NULL, max = NULL, locale = NULL, 
  provisional = FALSE, simple = TRUE, sleep = 0, ...) 
{
  if (length(locID) > 10) {
    stop('Too many locations (max. 10)', call. = FALSE)
  }

  Sys.sleep(sleep)
  url <- paste0(ebase(), 'data/obs/', if(!is.null(species)) 'loc_spp/recent' else 'loc/recent')

  if(!is.null(back)) {
    back <- round(back) 
  }

  locID <- if(!is.null(locID)) locID <- paste0(locID, collapse = ",")
  args <- ebird_compact(list(
    fmt='json', sci=species,
    r=locID, back=back, maxResults=max,
    locale=locale
  ))
  if (provisional) args$includeProvisional <- 'true'
  if (!simple) args$detail <- 'full'
  
  ebird_GET(url, args, ...)
}
