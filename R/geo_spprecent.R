#' Returns the most recent sighting date and specific location for the requested 
#' species of bird reported within the number of days specified
#'    and reported in the specified area.
#' @import RJSONIO plyr RCurl
#' @param lat decimal latitude - value between -90.00 and 90.00, two decimal
#'    places of precision required (is it?) 
#' @param lng decimal longitude - value between -180.00 and 180.00, two decimal
#'    places of precision required (?)
#' @param dist distance defining radius of interest from given lat/lng in 
#'    kilometers - value between 0 and 50, defaults to 25
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
#' geo_spprecent('spinus tristis',42,-76)
#' geo_spprecent('spinus tristis', 42,-76, maxResults=10, includeProvisional=T, hotspot=T)
#' }

#TODO: include error messages in case values are out of the accepted range
#TODO: include translation of API errors



geo_spprecent <-  function(species,lat,lng, dist = NA, back = NA, 
  maxResults = NA, locale = NA, includeProvisional = F, 
  hotspot = F, sleep = 0,
  ..., #additional parameters inside curl
  url = 'http://ebird.org/ws1.1/data/obs/geo_spp/recent',
  curl = getCurlHandle() ) {
    
  Sys.sleep(sleep)


  
  args <- list(fmt='json')
    args$sci <- species
    args$lat <- round(lat, 2)
    args$lng <- round(lng, 2)
  if(!is.na(dist))
    args$dist <- as.integer(dist)
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
