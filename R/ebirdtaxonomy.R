#' eBird Taxonomy
#'
#' Returns a data.frame of all taxa in the eBird taxonomy for the given 
#' combination of categories. Defaults to all categories. Any taxon with 
#' the category of 'species' may be used as a parameter in service calls that 
#' take a species code. Any taxon not in this category will be rejected by 
#' these services at this time.
#' 
#' @export
#' 
#' @param cat Species category. String or character vector with one of more of:
#'    "domestic", "form", "hybrid", "intergrade", "issf", "slash", "species", "spuh". 
#'    If not specified, defaults to all.
#'    For more info about the meaning of species categories, see 
#'    \url{https://ebird.org/science/use-ebird-data/the-ebird-taxonomy}.
#' @param locale Language/locale of response (when translations are available).
#'    See \url{https://docs.oracle.com/javase/6/docs/api/java/util/Locale.html} and 
#'    \url{https://support.ebird.org/en/support/solutions/articles/48000804865-bird-names-in-ebird} 
#'    (defaults to en_US).
#' @param species Character vector of eBird taxonomy species code(s). Limits query
#'    results to only these taxa. Default is NULL, which does not limit taxa.
#' @param key eBird API key. You can obtain one from https://ebird.org/api/keygen.
#'    We strongly recommend storing it in your \code{.Renviron} file as an 
#'    environment variable called \code{EBIRD_KEY} to avoid having to constantly 
#'    supply the key, and to avoid accidentally sharing it publicly.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#' @return A data.frame containing the collected information:
#' @return "sciName": Taxon's scientific name.
#' @return "comName": Taxon's common name.
#' @return "speciesCode": Unique species code.
#' @return "category": Taxon's species category. 
#' @return "taxonOrder": Numeric value determining the order in which taxonomic lists are presented.
#' @return "bandingCodes": Taxon's ABA banding code(s).
#' @return "comNameCodes": Taxon's common name code(s).
#' @return "sciNameCodes": Taxon's scientific name code(s).
#' @return "order": Taxon's order.
#' @return "familyComName": Family's common name.
#' @return "familySciName": Family's scientific name.
#' @return "reportAs": Species code to report taxon as.
#' @return "extinct": Logical, whether the taxon is considered extinct.
#' @return "extinctYear": Year taxon became extinct. Currently unavailable.
#' 
#' @examples \dontrun{
#' ebirdtaxonomy()
#' ebirdtaxonomy(cat = c("spuh", "slash")) 
#' }
#' @author Andy Teucher \email{andy.teucher@@gmail.com},
#'    Sebastian Pardo \email{sebpardo@@gmail.com}
#' @references \url{http://ebird.org/}

ebirdtaxonomy <- function(cat=NULL, locale=NULL, species = NULL, key = NULL, ...){
  cats <- c("domestic", "form", "hybrid", "intergrade", "issf", "slash", "species", "spuh")
  
  if (!all(vapply(cat, function(x) x %in% cats, FUN.VALUE = logical(1)))) {
    stop("You have supplied an invalid species category")
  }
  cat <- if(!is.null(cat)) cat <- paste0(cat, collapse = ",")
  if (!is.null(species) && (length(species) == 0 || any(is.na(species)))){
    stop('Invalid species code(s)')
  }
  species <- if(!is.null(species)) species <- paste0(species, collapse = ",")
  args <- list(fmt='json', cat=cat, locale=locale, species=species)
  
  # Allow not using a key for just this function, it's the only endpoint 
  # that allows it
  if (is.null(key) && !nzchar(Sys.getenv("EBIRD_KEY"))) {
    key <- ""
  }
  
  tax <- ebird_GET(paste0(ebase(), 'ref/taxonomy/ebird'), args, key = key, ...)
  tax$comNameCodes <- sort_comma_separated(tax$comNameCodes)
  tax$sciNameCodes <- sort_comma_separated(tax$sciNameCodes)
  tax
}
