#' View Checklist
#'
#' @param subId The checklist identifier
#' @param sleep Time (in seconds) before function sends API call (defaults to
#'   zero. Set to higher number if you are using this function in a loop with
#'   many API calls).
#' @param key eBird API key. You can obtain one from
#'   https://ebird.org/api/keygen. We strongly recommend storing it in your
#'   \code{.Renviron} file as an environment variable called \code{EBIRD_KEY}.
#' @param other FALSE (default) or TRUE. Whether to return some
#'   optional/deprecated/unsupported columns. Currently these are all columns in
#'   subAux, projId, howManyAt*, hideFlags, present, and submissionMethod*.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#'
#' @return A 'tibble' 'data.frame' containing checklist information:
#' @return "subId": submission ID
#' @return "protocolId": eBird protocol ID
#' @return "locId": location ID
#' @return "durationHrs": checklist duration, in hours
#' @return "allObsReported": whether all observations were reported, i.e.,
#'   whether it was a 'complete' checklist
#' @return "subComments": checklist comments
#' @return "creationDt": checklist creation date
#' @return "lastEditedDt": checklist last edited date
#' @return "obsDt": checklist date-time
#' @return "obsTimeValid": whether checklist date-time is valid
#' @return "checklistId" checklist ID
#' @return "numObservers" number of observers on checklist
#' @return "subnational1Code" country code and subnational1 code
#' @return "userDisplayName" eBird user display name
#' @return "numSpecies" number of species reported on checklist
#' @return "speciesCode" species codes reported on checklist
#' @return "obsId" observation IDs for each taxon on checklist
#' @return "howManyStr" number of individuals reported for each taxon
#' @return "exoticCategory" exotic species categories for each taxon
#' @return "obsComments" observation comments for each taxon
#' @return "photoCounts" number of photos for each taxon
#' @return "audioCounts" number of audio files for each taxon
#' @return "videoCounts" number of video files for each taxon
#' @return "auxCode" breeding code for each taxon

#' @export
#'
#' @examples \dontrun{
#' ebirdchecklist("S121423354")
#' }
#' @references \url{http://ebird.org/}
ebirdchecklist <- function(subId, sleep = 0, key = NULL, other = FALSE, ...) {

  url <- paste0(ebase(), "product/checklist/view/", subId)

  Sys.sleep(sleep)

  response <- GET(URLencode(url),
            query = ebird_compact(list()),
            add_headers("X-eBirdApiToken" = get_key(key)),
            ...)

  content_text <- content(response, as = "text", encoding = "UTF-8")
  content_json <- fromJSON(content_text, flatten = FALSE)

  # Check if the response contains an error message
  if (any(grepl('^error', names(content_json)))){
    err_msg <- 'Unknown error'
    err_msg <- try(content_json$errors$status, silent = TRUE)
    if (grepl('subId is invalid', content_json$errors$title)){
      err_msg <- 'subId is invalid'
      }
    stop(err_msg)
  }

  cl <- bind_rows(content_json)

  # extract sub df
  col_is_df <- vapply(cl, is.data.frame, TRUE)
  sub_df <- cl[1, !col_is_df]
  # 'comments' column has name duplicated with species comments
  names(sub_df)[names(sub_df) == 'comments'] <- 'subComments'

  # extract subAux df
  subAux_df <- cl$subAux[1,]
  # seems empty, and names conflict with breeding codes
  subAux_df$auxCode <- NULL
  subAux_df$entryMethodCode <- NULL

  # extract obsAux df
  obsAux_list <- cl$obs$obsAux
  # find the list entry that contains the data
  col_is_df <- vapply(obsAux_list, is.data.frame, TRUE)
  obsAux_df <- obsAux_list[[which(col_is_df)]]
  # redundant columns from sub_df
  obsAux_df$subId <- NULL
  obsAux_df$speciesCode <- NULL
  # duplicate info with uninformative name
  obsAux_df$value <- NULL
  # names conflict with sub_df, and not very important
  obsAux_df$fieldName <- NULL
  obsAux_df$entryMethodCode <- NULL

  # extract obs df
  obs_df <- cl$obs
  obs_df$obsAux <- NULL
  # hideFlags might be useful, but its structure is currently undocumented
  obs_df$hideFlags <- NULL
  # remove redundant sub-level columns already in sub_df
  obs_df$subnational1Code <- NULL
  obs_df$obsDt <- NULL
  obs_df$projId <- NULL
  # 'comments' column has name duplicated with checklist comments
  names(obs_df)[names(obs_df) == 'comments'] <- 'obsComments'

  # deal with mediaCounts
  if (! is.null(obs_df$mediaCounts)){
    mediaCounts <- obs_df$mediaCounts
    idx <- match(names(mediaCounts), c('P','A','V'))
    names(mediaCounts) <- c('photoCounts', 'audioCounts', 'videoCounts')[idx]
    obs_df$mediaCounts <- NULL
    obs_df <- cbind(obs_df, mediaCounts)
  }

  # join to get result df
  out_df <- sub_df
  if (! is.null(subAux_df) && other){
    out_df <- dplyr::left_join(out_df, subAux_df, by = 'subId')
  }
  out_df <- dplyr::left_join(out_df, obs_df, by = 'subId')
  if (! is.null(obsAux_df)){
    out_df <- dplyr::left_join(out_df, obsAux_df, by = 'obsId')
  }
  # remove some unneeded columns by default
  if (! other){
    regex <- '^projId$|^howManyAt|^hideFlags$|^present$|^submissionMethod'
    out_df <- out_df[, !grepl(regex, names(out_df)), drop = FALSE]
  }
  out_df
}
