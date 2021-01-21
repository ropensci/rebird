#' Get a list of species codes ever seen in a location.
#'
#' Returns the eBird codes for all species-level taxa recorded in a particular
#' region or location. Codes are returned in taxonomic order.
#'
#' @param location Any valid location, USFWS region, subnational2, subnational1,
#' country, or custom region code. (Location can be a hotspot or personal location).
#' @param key eBird API key. You can obtain one from https://ebird.org/api/keygen.
#'    We strongly recommend storing it in your \code{.Renviron} file as an
#'    environment variable called \code{EBIRD_KEY}.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#'
#' @return A single column data.frame containing the collected information:
#' @return "speciesCode": eBird species code, suitable for joining
#'    to the \code{\link[rebird]{ebirdtaxonomy}}
#'
#' @importFrom dplyr tibble
#' @export
#'
#' @examples
#' \dontrun{
#' ebirdregionspecies("GB") # all in Great Britain
#' ebirdregionspecies("GB-ENG") # all in England
#' ebirdregionspecies("GB-ENG-LND") # all in London
#'
#' library(dplyr)
#' taxonomy <- ebirdtaxonomy()
#' localSpecies <- ebirdregionspecies("L5803024") # specific hotspot
#' inner_join(localSpecies, taxonomy)
#' }
#'
ebirdregionspecies <- function(location, key = NULL, ...) {
  url <- paste0(ebase(), "product/spplist/", location)

  if (length(location) > 1) {
    stop("More than one location specified")
  }

  args <- list()

  tt <- GET(URLencode(url),
    query = ebird_compact(args),
    add_headers("X-eBirdApiToken" = get_key(key))
  )

  ss <- content(tt, as = "text", encoding = "UTF-8")
  json <- fromJSON(ss, T)

  tibble(speciesCode = json)
}
