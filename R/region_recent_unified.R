#' Returns recent sightings of a species in a region
#' @import RJSONIO plyr RCurl
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
#' ebird_recent('US','Setophaga caerulescens')
#' ebird_recent('US-OH', maxResults=10, includeProvisional=T, hotspot=T)
#' }

#TODO: include error messages in case values are out of the accepted range
#TODO: include translation of API errors



ebird_recent <-  function(region, species = NA,
  regtype = c("country", "subnational1", "subnational2"), 
  back = NA, maxResults = NA, locale = NA, 
  includeProvisional = F, hotspot = F,
  sleep = 0,
  ..., #additional parameters inside curl
  url = 'http://ebird.org/ws1.1/data/obs/region/recent',
  curl = getCurlHandle() ) {
    
  Sys.sleep(sleep)
  
  regtype <- match.arg(regtype)

  if(!is.na(species))
	url <- 'http://ebird.org/ws1.1/data/obs/region_spp/recent'

   
  args <- list(fmt='json')
	args$sci <- species  
    args$r <- region
    args$rtype <- regtype
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

    

content <- getForm(url, 
            .params = args, 
            ... ,
            curl = curl)
res <- fromJSON(content)  
  
ldply(res, data.frame)  

}