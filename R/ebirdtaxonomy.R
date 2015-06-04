#' eBird Taxonomy
#'
#' Returns a data.frame of all species in the eBird taxonomy for the given 
#' combination of categories. The default category is "species". Any taxon with 
#' the category of 'species' may be used as a parameter in service calls that 
#' take a scientific name. Any taxon not in this category will be rejected by 
#' these services at this time.
#' 
#' @import jsonlite httr dplyr
#' @export
#' 
#' @param cat Species category. String or character vector with one of more of:
#'    "domestic", "form", "hybrid", "intergrade", "issf", "slash", "species", "spuh". 
#'    For more info about the meaning of species categories, see 
#'    http://ebird.org/content/ebird/about/ebird-taxonomy
#' @param locale Language/locale of response (when translations are available).
#'    See \url{http://java.sun.com/javase/6/docs/api/java/util/Locale.html}
#'    (defaults to en_US).
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#' @return A data.frame containing the collected information:
#' @return "comName": species' common name
#' @return "sciName": species' scientific name
#' @return "taxonID": Taxonomic Concept identifier, note this is currently in test
#' 
#' @examples \dontrun{
#' ebirdtaxonomy()
#' ebirdtaxonomy(cat=c("spuh", "slash")) 
#' }
#' @author Andy Teucher \email{andy.teucher@@gmail.com}
#' @references \url{http://ebird.org/}

ebirdtaxonomy <- function(cat=NULL, locale=NULL, ...){
  cats <- c("domestic", "form", "hybrid", "intergrade", "issf", "slash", "species", "spuh")
  
  if (!all(vapply(cat, function(x) x %in% cats, FUN.VALUE = logical(1)))) {
    stop("You have supplied an invalid species category")
  }
  cat <- if(!is.null(cat)) cat <- paste0(cat, collapse = ",")
  args <- ebird_compact(list(fmt='json', cat=cat, locale=locale))
  ebird_GET(paste0(ebase(), 'ref/taxa/ebird'), args, ...)
}
