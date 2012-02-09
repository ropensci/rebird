#' Returns the most recent sighting date and specific location for each species of bird reported within the number of days specified by the "back" parameter and reported in the specified area.
#' @import RJSONIO plyr
#' @param lat decimal latitude - value between -90.00 and 90.00, two decimal places of precision required (is it?) 
#' @param lng decimal longitude - value between -180.00 and 180.00, two decimal places of precision required (?)
#' @param dist distance defining radius of interest from given lat/lng in kilometers - value between 0 and 50, defaults to 25
#' @param back the number of days back to look for observations - value between 1 and 30, defaults to 14
#' @param maxResults the maximum number of result rows to return in this request - value between 1 and 10000, defaults to all
#' @param locale Language/locale of response (when translations are available). See http://java.sun.com/javase/6/docs/api/java/util/Locale.html - defaults to en_US
#' @param includeProvisional should flagged records that have not been reviewed be included? - defaults to F
#' @param hotspot should results be limited to sightings at birding hotspots? - defaults to F
#' @param sleep Time (in seconds) before function sends API call - defaults to
#'    zero.  Set to higher number if you are using this function in a loop with 
#'    many API calls.
#' @return comName species common name
#' @return howMany number of individuals observed, NA if only presence was noted
#' @return lat latitude of the location
#' @return lng longitude of the location
#' @return locID unique identifier for the location
#' @return locName location name
#' @return locationPrivate TRUE if location is not a birding hotspot, FALSE otherwise
#' @return obsDt observation date formatted according to ISO 8601 (e.g. 'YYYY-MM-DD', or 'YYYY-MM-DD hh:mm').  Hours and minutes are excluded if the observer did not report an observation time. 
#' @return obsReviewed TRUE if observation has been reviewed, FALSE otherwise
#' @return obsValid TRUE if observation has been deemed valid by either the automatic filters or a regional viewer, FALSE otherwise
#' @return sciName species scientific name
#' @export
#' @examples \dontrun{
#' recentobs(42,-76)
#' recentobs(42,-76, maxResults=10, includeProvisional=T, hotspot=T)
#' }

#TODO: include erorr messages in case values are out of the accepted range
#TODO: include translation of API errors

recentobs <-  function(lat,lng, dist = 25, back = 14, maxResults = NA, locale = "en_US", includeProvisional = F, hotspot = F, 
  ...,
  url = 'http://ebird.org/ws1.1/data/obs/geo/recent?', 
  sleep = 0 
   ) {
    
  Sys.sleep(sleep)
  
  url2 <- paste(url, 'lng=', round(lng, 2), '&lat=', round(lat, 2), '&dist=', as.integer(dist), '&back', as.integer(back), '&locale=', locale, '&fmt=json', sep='')
    if(includeProvisional != F) url2 <- paste(url2, '&includeProvisional=true', sep='')
    if(hotspot != F) url2 <- paste(url2, '&hotspot=true', sep='')
    if(is.na(maxResults) == F) url2 <- paste(url2, '&maxResults=', maxResults, sep='')

  tt <- getURLContent(url2)
  res <- fromJSON(tt)
  
  tab <- ldply(res, data.frame)  
  
  return(tab)

}