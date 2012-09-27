#' Returns a list of recent notable observations by either latitude/longitude,
#' hotspot or location ID, or particular region.
#' @import RJSONIO plyr RCurl
#' @param lat decimal latitude - value between -90.00 and 90.00, two decimal
#'    places of precision required (is it?) 
#' @param lng decimal longitude - value between -180.00 and 180.00, two decimal
#'    places of precision required (?)
#' @param LocIDs Code(s) for region of interest. 
#' @param region region code corresponding to selected region type. See
#' https://confluence.cornell.edu/display/CLOISAPI/eBird-1.1-RegionCodeReference
#' @param regtype the region type you are interested in. can be "country" 
#' (e.g. "US"), "subnational1" (states/provinces, e.g. "US-NV") or 
#' "subnational" (counties, not yet implemented, e.g. "US-NY-109")
#' @param back the number of days back to look for observations - value between
#'    1 and 30, defaults to 14
#' @param maxResults the maximum number of result rows to return in this request
#'    - value between 1 and 10000, defaults to all
#' @param locale Language/locale of response (when translations are available).
#'    See http://java.sun.com/javase/6/docs/api/java/util/Locale.html 
#'    - defaults to en_US
#' @param includeProvisional should flagged records that have not been reviewed 
#'    be included? - defaults to F
#' @param hotspot should results be limited to sightings at birding hotspots? 
#'    - defaults to F
#' @param sleep Time (in seconds) before function sends API call - defaults to
#'    zero.  Set to higher number if you are using this function in a loop with 
#'    many API calls.
#' @return comName species common name
#' @return howMany number of individuals observed, NA if only presence was noted
#' @return lat latitude of the location
#' @return lng longitude of the location
#' @return locID unique identifier for the location
#' @return locName location name
#' @return locationPrivate TRUE if location is not a birding hotspot
#' @return obsDt observation date formatted according to ISO 8601 
#'    (e.g. 'YYYY-MM-DD', or 'YYYY-MM-DD hh:mm').  Hours and minutes are excluded 
#'    if the observer did not report an observation time. 
#' @return obsReviewed TRUE if observation has been reviewed, FALSE otherwise
#' @return obsValid TRUE if observation has been deemed valid by either the 
#'    automatic filters or a regional viewer, FALSE otherwise
#' @return sciName species scientific name
#' @export
#' @examples \dontrun{
#' ebird_notable(lat=42,lng=-70)
#' ebird_notable(locID = c('L99381','L99382'))
#' ebird_notable(region='US', max=10)
#' ebird_notable(region='US-OH', regtype='subnational1')
#' }

#TODO: include error messages in case values are out of the accepted range
#TODO: include translation of API errors



ebird_notable <-  function(lat = NA, lng = NA, dist = NA,
  locID = NA, region = NA, 
  regtype = c("country", "subnational1", "subnational2"), 
  back = NA, maxResults = NA, locale = NA, 
  includeProvisional = F, hotspot = F,
  sleep = 0,
  ..., #additional parameters inside curl
  url = 'http://ebird.org/ws1.1/data/notable/geo/recent',
  curl = getCurlHandle() ) {
    
  Sys.sleep(sleep)
  

  args <- list(fmt='json')
  if(!is.na(back))
    args$back <- as.integer(back)
  if(!is.na(maxResults))
    args$maxResults <- maxResults
  if(!is.na(locale))
    args$locale <- locale
  if(includeProvisional)
    args$includeProvisional <- 'true' 
  if(hotspot)
    args$hotspot <- 'true' 

  if(!is.na(lat)){
	url <- 'http://ebird.org/ws1.1/data/notable/geo/recent'
    args$lat <- lat
    args$lng <- lng
 
     if(!is.na(dist))
       args$dist <- as.integer(dist)
  }
  
  if(!is.na(locID[1])){

    if(length(LocIDs) > 10)
      stop('Too many locations (max. 10)')

  	url <- 'http://ebird.org/ws1.1/data/notable/loc/recent'
  	args$r <- locID
  	
    if(!is.na(dist))
      args$dist <- as.integer(dist)

 	args$hotspot <- NA 	 	
  }
 
 if(!is.na(region)){
 	url <- 'http://ebird.org/ws1.1/data/notable/region/recent'
    regtype <- match.arg(regtype)
 	args$r <- region
 	args$rtype <- regtype
 }

# this is kinda convoluted, checking if user has entered +1 search option
# Taking suggestions.

if(length(c(lat,locID,region)[is.na(c(lat,locID,region))]) != 2)    
  stop('multiple search options chosen. Please enter only lat/long, locID or region')

content <- getForm(url, 
            .params = args, 
            ... ,
            curl = curl)
res <- fromJSON(content)  
  
ldply(res, data.frame)  

}