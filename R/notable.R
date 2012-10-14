#' Notable sightings
#'
#' Returns the most recent notable observations by either latitude/longitude,
#' hotspot or location ID, or particular region.
#' @import RJSONIO plyr RCurl
#' @param lat Decimal latitude. value between -90.00 and 90.00, up to two 
#'    decimal places of precision.
#' @param lng Decimal longitude. value between -180.00 and 180.00, up to
#'    two decimal places of precision.
#' @param locID Vector containing code(s) for up to 10 regions of interest.
#' @param region Region code corresponding to selected region type.
#' For supported region and coding, see
#' https://confluence.cornell.edu/display/CLOISAPI/eBird-1.1-RegionCodeReference
#' @param regtype Region type you are interested in. can be "country" 
#' (e.g. "US"), "subnational1" (states/provinces, e.g. "US-NV") or 
#' "subnational" (counties, not yet implemented, e.g. "US-NY-109"). Default
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
#' @param sleep Time (in seconds) before function sends API call (defaults to
#'    zero.  Set to higher number if you are using this function in a loop with 
#'    many API calls).
#' @param ... additional parameters to be passed to curl.
#' @note \code{ebirdnotable} requires that either latitude/longitude, location ID,
#' or region be passed to the function. Multiple entries (or lack of one) will result
#' in error.
#' @return A data.frame containing the collected information:
#' @return "comName": species common name
#' @return "howMany": number of individuals observed, NA if only presence was noted
#' @return "lat": latitude of the location
#' @return "lng": longitude of the location
#' @return "locID": unique identifier for the location
#' @return "locName": location name
#' @return "locationPrivate": TRUE if location is not a birding hotspot
#' @return "obsDt": observation date formatted according to ISO 8601 
#'    (e.g. 'YYYY-MM-DD', or 'YYYY-MM-DD hh:mm').  Hours and minutes are excluded 
#'    if the observer did not report an observation time. 
#' @return "obsReviewed": TRUE if observation has been reviewed, FALSE otherwise
#' @return "obsValid": TRUE if observation has been deemed valid by either the 
#'    automatic filters or a regional viewer, FALSE otherwise
#' @return "sciName" species' scientific name
#' @export
#' @examples \dontrun{
#' ebirdnotable(lat=42,lng=-70)
#' ebirdnotable(locID = c('L99381','L99382'))
#' ebirdnotable(region='US', max=10)
#' ebirdnotable(region='US-OH', regtype='subnational1')
#' }
#' @examples \donttest{
#' ebirdnotable(locID='L99381',region='US') #ERROR 
#' }
#' @author Rafael Maia \email{rm72@@zips.uakron.edu}
#' @references \url{http://ebird.org/}


ebirdnotable <-  function(lat = NULL, lng = NULL, dist = NULL,
  locID = NULL, region = NULL, 
  regtype = c("country", "subnational1", "subnational2"), 
  back = NULL, max = NULL, locale = NULL, 
  provisional = FALSE, hotspot = FALSE,
  sleep = 0,
  ... #additional parameters inside curl
   ) {

  url <- 'http://ebird.org/ws1.1/data/notable/geo/recent'
  curl <- getCurlHandle()
  
  Sys.sleep(sleep)

  if(!is.null(back))
    back <- round(back)

  args <- list(
  fmt='json', back=back, 
  maxResults=max, locale=locale
  )

  if(provisional)
    args$includeProvisional <- 'true' 
  if(hotspot)
    args$hotspot <- 'true' 

  if(!is.null(lat)){
	url <- 'http://ebird.org/ws1.1/data/notable/geo/recent'
    args$lat <- lat
    args$lng <- lng
 
     if(!is.null(dist))
       args$dist <- round(dist)
  }
  
  if(!is.null(locID[1])){

    if(length(locID) > 10)
      stop('Too many locations (maximum 10)')

  	url <- 'http://ebird.org/ws1.1/data/notable/loc/recent'
  	args$r <- locID
  	
    if(!is.null(dist))
      args$dist <- as.integer(dist)

 	args$hotspot <- NULL 	 	
  }
 
 if(!is.null(region)){
 	url <- 'http://ebird.org/ws1.1/data/notable/region/recent'
    regtype <- match.arg(regtype)
 	args$r <- region
 	args$rtype <- regtype
 }

# this is kinda convoluted, checking if user has entered +1 search option
# Taking suggestions.

  args <- compact(args)

if(length(c(lat,locID[1],region)) != 1)    
  stop('multiple search options chosen. Please enter only lat/long, locID or region')

content <- getForm(url, 
            .params = args, 
            ... ,
            curl = curl)

res <- fromJSON(content)    
ldply(res, data.frame)  
}