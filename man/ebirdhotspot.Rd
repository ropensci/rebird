\name{ebirdhotspot}
\alias{ebirdhotspot}
\title{Recent observations at hotspots}
\usage{
  ebirdhotspot(locID, species = NULL, back = NULL,
    max = NULL, locale = NULL, provisional = FALSE,
    sleep = 0, ...)
}
\arguments{
  \item{locID}{(required) Vector containing code(s) for up
  to 10 regions of interest; here, regions are the locIDs
  of hotspots. Values that are not valid or are not
  hotspots are ignored.}

  \item{species}{Scientific name of the species of interest
  (not case sensitive). Defaults to NULL, in which case
  sightings for all species are returned. See eBird
  taxonomy for more information:
  http://ebird.org/content/ebird/about/ebird-taxonomy}

  \item{back}{Number of days back to look for observations
  (between 1 and 30, defaults to 14).}

  \item{max}{Maximum number of result rows to return in
  this request (between 1 and 10000, defaults to all)}

  \item{locale}{Language/locale of response (when
  translations are available).  See
  http://java.sun.com/javase/6/docs/api/java/util/Locale.html
  (defaults to en_US)}

  \item{provisional}{Should flagged records that have not
  been reviewed be included? (defaults to FALSE)}

  \item{sleep}{Time (in seconds) before function sends API
  call (defaults to zero.  Set to higher number if you are
  using this function in a loop with many API calls).}

  \item{...}{additional parameters to be passed to curl}
}
\value{
  A data.frame containing the collected information:

  "comName": species common name

  "howMany": number of individuals observed, NA if only
  presence was noted

  "lat": latitude of the location

  "lng": longitude of the location

  "locID": unique identifier for the location

  "locName": location name

  "locationPrivate": TRUE if location is not a birding
  hotspot

  "obsDt": observation date formatted according to ISO 8601
  (e.g. 'YYYY-MM-DD', or 'YYYY-MM-DD hh:mm').  Hours and
  minutes are excluded if the observer did not report an
  observation time.

  "obsReviewed": TRUE if observation has been reviewed,
  FALSE otherwise

  "obsValid": TRUE if observation has been deemed valid by
  either the automatic filters or a regional viewer, FALSE
  otherwise

  "sciName" species' scientific name
}
\description{
  Returns the most recent sighting information reported in
  a given vector of hotspots.
}
\examples{
\dontrun{
ebirdhotspot(locID=c('L99381','L99382'),'larus delawarensis')
ebirdhotspot('L99381', max=10, includeProvisional=T, hotspot=T)}
}
\author{
  Rafael Maia \email{rm72@zips.uakron.edu}
}
\references{
  \url{http://ebird.org/}
}

