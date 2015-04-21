#' Download historical frequencies of bird observations
#'
#' @param loctype 
#' @param loc 
#' @param startyear 
#' @param endyear 
#' @param startmonth 
#' @param endmonth 
#'
#' @return
#' @export
#'
#' @examples
get_freq <- function(loctype, loc, startyear, endyear, startmonth, endmonth) {
  args <- list(cmd = "getChart", displayType = "download", getLocations = loctype, 
               counties = loc, bYear = startyear, eYear = endyear, 
               bMonth = startmonth, eMonth = endmonth)
  
  url <- "http://ebird.org/ebird/canada/BarChart"
  ret <- GET(url, query = args)
  stop_for_status(ret)
  asChar <- readBin(ret$content, "character")
  freq <- read.delim(text = asChar, skip = 12, 
                     stringsAsFactors = FALSE)[,-50]
  names(freq) <- c("Species", sapply(month.name, paste ,1:4, sep="-"))
  freq_long <- tidyr::gather(freq[-1,], "mo_qt", "Freq", 2:length(freq), 
                             convert = TRUE)
  ss <- tidyr::gather(freq[1,-1], key = "mo_qt", value = "sample_size", 
                      convert = TRUE)
  freq_long <- merge(freq_long, ss, by = "mo_qt")
  freq_long
}

