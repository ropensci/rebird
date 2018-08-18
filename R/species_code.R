#' Return species code
#' 
#' Returns the species code for a given scientific name. Uses an internally-stored
#'  version of the taxonomy. Also provides a message with the common name, scientific
#'  name, and species code of the species.
#' 
#' @param sciname (required) Character string of length 1 with the scientific name to
#' look for. Case insensitive.
#' @return A character string with the eBird species code.
#' 
#' @importFrom assertthat assert_that
#' @export
#' @examples 
#' species_code("Anhinga anhinga")
#' @author Sebastian Pardo \email{sebpardo@@gmail.com}
#' @references \url{http://ebird.org/}

species_code <- function(sciname = NULL) {
  assertthat::assert_that(is.character(sciname))
  assertthat::assert_that(length(sciname) == 1) 
  
  spp <- tax[which(tolower(tax$sciName) == tolower(sciname)), ]
  
  if (nrow(spp) == 0) stop("No species in eBird taxonomy with matching scientific name.")
  
  message(paste0(spp["comName"]," (", spp["sciName"], "): ", spp["speciesCode"]))
  return(as.character(spp["speciesCode"]))
}

