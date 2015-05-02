#' Download historical frequencies of bird observations from eBird
#'
#' @param loctype String with location type. Either "states", "counties", 
#'   or "hotspots".
#' @param loc String with location identifier. If querying states 
#'   or provinces, the two letter country code followed by the 
#'   two letter state code and separated by "-" (e.g. "US-NY"). 
#'   If querying counties, is as in states/provinces, but appending 
#'   county identifier after a dash. For counties in the US, 
#'   the county codes is a 3-digit number specific to each state 
#'   (e.g. Bronx County: "US-NY-005"). For counties in Canada, 
#'   county codes are two-letter identifiers (e.g. Metro Vancouver:
#'   "CA-BC-GV"). 
#'   If querying hotspots then the unique identifier is a 6-digit
#'   number prepended with an "L" (e.g. "L196159"). All these codes
#'   can be found by looking at the URL in the Explore Data eBird
#'   page (http://ebird.org//GuideMe?cmd=changeLocation).
#' @param startyear Starting year for query. Defaults to 1900.
#' @param endyear Ending year for query. Defaults to current year 
#'   specified by Sys.Date().
#' @param startmonth Starting month for query as an integer (1-12). 
#'   Defaults to January.
#' @param endmonth Ending month for query as an integer (1-12).
#'   Defaults to December.
#' @param long Logical, Should output be in long format? Defaults 
#'   to TRUE. If FALSE then output will be in wide format.
#'
#' @return A data frame containing the collected information. If in long format:
#' @return "monthQt": month and week (eBird data divides each month by four weeks)
#' @return "comName": species common name
#' @return "frequency": proportion of times the species was seen in a specified week
#' @return "sampleSize" number of complete eBird checklists submitted for 
#'    specified given week
#'  @return If in wide format, then first column is the species list and all
#'   other columns are of individual weeks (four in each month). First row 
#'   contains the number of complete checklists for each week.
#'   
#' @import tidyr httr dplyr
#' @export
#' @examples \dontrun{
#' ebirdfreq("states", "US-NY", 2014, 2014, 1, 12)
#' ebirdfreq("counties", "CA-BC-GV", 1900, 2015, 1, 3)
#' ebirdfreq("hotspots", "L196159", long=FALSE)
#' }
#' @author Andy Teucher \email{andy.teucher@@gmail.com},
#'    Sebastian Pardo \email{sebpardo@@gmail.com}
#' @references \url{http://ebird.org/}

ebirdfreq <- function(loctype, loc, startyear = 1900, 
                     endyear = format(Sys.Date(), "%Y"),
                     startmonth = 1, endmonth = 12, long = TRUE) {
  
  if (!all(c(startmonth, endmonth) %in% 1:12)) {
    stop("Invalid month provided (must be integer between 1 and 12)")
  } else 
  currentyear <- max(format(Sys.Date(), "%Y"), 2015)  
  if (!all(c(startyear, endyear) %in% 1900:currentyear)) {
    stop(paste0("Invalid year provided (must be integer between 1900 and ", currentyear, ")"))
  } else
  
  if (loctype == "counties") {
    args2 <- list(counties = loc)
  } else if (loctype == "hotspots") {
    if (!grepl("^L\\d{1,8}$", loc)) {
      stop("Invalid hotspot code")
    } else
    args2 <- list(hotspots = loc)
  } else if (loctype == "states") {
    args2 <- list(states = loc)
  } else {
    stop("Not a valid location type")
  }
  
  if (loctype != "hotspots") {
    if (!ebirdregioncheck(loctype, loc)) stop("Specified location doesn't exist")
  }
  
  args1 <- list(cmd = "getChart", displayType = "download", 
                getLocations = loctype)
  args3 <- list(bYear = startyear, eYear = endyear, bMonth = startmonth, 
                eMonth = endmonth)
  
  args <- c(args1, args2, args3)
  url <- "http://ebird.org/ebird/BarChart"
  ret <- GET(url, query = args)
  stop_for_status(ret)
  asChar <- readBin(ret$content, "character")
  freq <- tbl_df(read.delim(text = asChar, skip = 12, 
                     stringsAsFactors = FALSE)[,-50])
  if (loctype == "hotspots" && all(is.na(freq[, -1]))) {
    warning("No observations returned, check hotspot code")
  } 
  names(freq) <- c("comName", sapply(month.abb, paste ,1:4, sep="-"))
  if (!long) {
    return(freq)
  } else {
    freq_long <- gather(freq[-1,], "monthQt", "frequency", 2:length(freq), 
                        convert = TRUE)
    ss <- gather(freq[1,-1], key = "monthQt", value = "sampleSize", 
                 convert = TRUE)
    freq_long <- merge(freq_long, ss, by = "monthQt")
    tbl_df(freq_long)
  }
}

