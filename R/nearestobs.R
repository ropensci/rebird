#' Nearest species sightings
#'
#' Returns the most recent and nearest reported sighting information
#' with observations of a species.
#' @import RJSONIO plyr RCurl
#' @param lat (required) Decimal latitude. value between -90.00 and 90.00, up to two 
#'    decimal places of precision.
#' @param lng (required) Decimal longitude. value between -180.00 and 180.00, up to
#'    two decimal places of precision.
#' @param species (required) Scientific name of the species of interest (not case 
#' sensitive). See eBird taxonomy for more information: 
#' http://ebird.org/content/ebird/about/ebird-taxonomy
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
#' @param ... additional parameters to be passed to curl.
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
#' nearestobs(42,-76,'spizella arborea')
#' nearestobs(42,-76,'spizella arborea', max=10, provisional=T, hotspot=T) }
#' @author Rafael Maia \email{rm72@@zips.uakron.edu}
#' @references \url{http://ebird.org/}


nearestobs <-  function(lat,lng, species, dist = NULL, back = NULL, 
  max = NULL, locale = NULL, provisional = FALSE, 
  hotspot = FALSE, sleep = 0,
  ... #additional parameters inside curl
   ) {

  url <- 'http://ebird.org/ws1.1/data/nearest/geo_spp/recent'
  curl <- getCurlHandle()
    
  Sys.sleep(sleep)

  if(!is.null(dist))
    dist <- round(dist)
  if(!is.null(back))
    back <- round(back)
  
  args <- compact(list(
  fmt='json', sci=species,
  lat=round(lat,2), lng=round(lng,2),
  dist=dist, back=back, maxResults=max,
  locale=locale
  ))

  if(provisional)
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
