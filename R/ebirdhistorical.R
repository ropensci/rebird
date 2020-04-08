#' Historic observations on a date at a region or hotspot
#' 
#' Returns a list of taxa reported in a given region or hotspot on a specific date
#' 
#' @param loc (required) Region code or locID (if a hotspot). Region code can
#'    be country code (e.g. "US"), subnational1 code (states/provinces, e.g. "US-NV"), or
#'    subnational2 code (counties, e.g. "US-VA-003").
#' @param date (required) Date of historic observation date formatted according 
#'    to ISO 8601 (e.g. 'YYYY-MM-DD', or 'YYYY-MM-DD hh:mm'). Hours and minutes 
#'    are excluded.
#' @param sortKey [mrec|create] Whether to order results by latest 
#'    observation date or by latest creation date. The default is by observation date.
#' @param categories [domestic|form|hybrid|intergrade|issf|slash|species|spuh] 
#'    This is useful for limiting results to certain taxonomic categories. The 
#'    default is all. Multiple categories may be comma-separated.
#' @param max Maximum number of result rows to return in this request.
#'    (A number between 1 and 10000. The default is 10000)
#' @param  fieldSet [simple|full] This is set to restrict results to either all 
#'     or a subset of sighting fields. The default is simple.
#' @param provisional Should flagged records that have not been reviewed
#'    be included? 
#' @param limitToHotspots Should results be limited to sightings at birding hotspots?
#'    The default is FALSE.
#' @param sleep Time (in seconds) before function sends API call. The defaults is
#'    zero. Set this to a higher number if you are using this function in a loop with
#'    many API calls.
#' @param key eBird API key. You can obtain one from https://ebird.org/api/keygen.
#'    We strongly recommend storing it in your \code{.Renviron} file as an 
#'    environment variable called \code{EBIRD_KEY}.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}.
#' @return A data.frame containing the collected information:
#' @return "speciesCode": species codes
#' @return "comName": species common names
#' @return "sciName" species' scientific names
#' @return "locId": unique identifier for the locations
#' @return "locName": location name
#' @return "obsDt": observation date formatted according to ISO 8601 
#'    (e.g. 'YYYY-MM-DD', or 'YYYY-MM-DD hh:mm'). Hours and minutes are excluded 
#'    if the observer did not report an observation time
#' @return "howMany": "howMany": number of individuals observed, NA if only presence was noted  
#' @return "obsValid": TRUE if observation has been deemed valid by either the 
#'    automatic filters or a regional viewer, FALSE otherwise
#' @return "obsReviewed": TRUE if observation has been reviewed, FALSE otherwise
#' @return "locationPrivate": TRUE if location is not a birding hotspot
#' @return "subID": submission ID 
#' @return "subnational2Code": county code (returned if simple=FALSE)
#' @return "subnational2Name": county name (returned if simple=FALSE)
#' @return "subnational1Code": state/province ISO code (returned if simple=FALSE)
#' @return "subnational1Name": state/province name (returned if simple=FALSE)
#' @return "countryCode": country ISO code (returned if simple=FALSE)
#' @return "countryName": country name (returned if simple=FALSE)
#' @return "userDisplayName": first and last name of the observer (returned if simple=FALSE) 
#' @return "obsID": observation ID (returned if simple=FALSE)
#' @return "checklistID": checklist ID (returned if simple=FALSE)
#' @return "presenceNoted": 'true' if user marked presence but did not count the
#'   number of birds. 'false' otherwise (returned if simple=FALSE)
#' @return "hasComments": 'true' if comments are included  (returned if simple=FALSE)
#' @return "hasRichMedia": 'true' if rich media (e.g. photos/sounds) are included (returned if simple=FALSE)
#' @return "firstName": observer's first name (returned if simple=FALSE)
#' @return "lastName": observer's last name (returned if simple=FALSE)
#' @export
#' @examples \dontrun{
#' ebirdhistorical(loc = 'US-VA-003', date='2019-02-14',max=10)
#' ebirdhistorical(loc = 'L196159', date='2019-02-14', fieldSet='full')
#' }
#' @author Guy Babineau \email{guy.babineau@@gmail.com}
#' @references \url{http://ebird.org/}
ebirdhistorical <-  function(loc, date, sortKey = 'mrec', categories = 'all', 
  max = 10000, fieldSet='simple', provisional = FALSE, limitToHotspots = FALSE, sleep=0, 
  key=NULL, ...)
{


  historicDate=as.Date(date)
  if (Sys.Date()<historicDate) {
    stop(paste0("date must be in the past"))
  }
  if (historicDate<'1800-01-01'){
    stop(paste0("date must be on or after 1800-01-01"))
  }
  Sys.sleep(sleep)

  url <- paste0(ebase(), 'data/obs/', loc, '/historic/',format(historicDate, "%Y"),'/',
                format(historicDate, "%m"),'/',format(historicDate, "%d") )

  args <- list(rank=sortKey,maxResults=max,detail=fieldSet,
               includeProvisional=provisional)
  if(categories != 'all') {
    args$cat=categories
  }
  if (limitToHotspots) args$hotspot <- 'true'

  ebird_GET(url, args, key = key, ...)
}