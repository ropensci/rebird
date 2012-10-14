\name{ebirdgeo}
\alias{ebirdgeo}
\title{Sightings at location determined by latitude/longitude}
\usage{
  ebirdgeo(lat, lng, species = NULL, dist = NULL,
    back = NULL, max = NULL, locale = NULL,
    provisional = FALSE, hotspot = FALSE, sleep = 0, ...)
}
\arguments{
  \item{lat}{(required) Decimal latitude. value between
  -90.00 and 90.00, up to two decimal places of precision.}

  \item{lng}{(required) Decimal longitude. value between
  -180.00 and 180.00, up to two decimal places of
  precision.}

  \item{species}{Scientific name of the species of interest
  (not case sensitive). Defaults to NULL, so sightings for
  all species are returned. See eBird taxonomy for more
  information:
  http://ebird.org/content/ebird/about/ebird-taxonomy}

  \item{dist}{Distance defining radius of interest from
  given lat/lng in kilometers (between 0 and 50, defaults
  to 25)}

  \item{back}{Number of days back to look for observations
  (between 1 and 30, defaults to 14).}

  \item{max}{Maximum number of result rows to return in
  this request (between 1 and 10000, defaults to all).}

  \item{locale}{Language/locale of response (when
  translations are available).  See
  http://java.sun.com/javase/6/docs/api/java/util/Locale.html
  (defaults to en_US).}

  \item{provisional}{Should flagged records that have not
  been reviewed be included? (defaults to FALSE).}

  \item{hotspot}{Should results be limited to sightings at
  birding hotspots?  (defaults to FALSE).}

  \item{sleep}{Time (in seconds) before function sends API
  call (defaults to zero. Set to higher number if you are
  using this function in a loop with many API calls).}

  \item{...}{additional parameters to be passed to curl.}
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
  Returns the most recent sighting date and specific
  location for the requested species of bird reported
  within the number of days specified and reported in the
  specified area.
}
\examples{
\dontrun{
ebirdgeo(42,-76,'spinus tristis')
ebirdgeo(42,-76, maxResults=10, includeProvisional=T, hotspot=T) }
}
\author{
  Rafael Maia \email{rm72@zips.uakron.edu}
}
\references{
  \url{http://ebird.org/}
}

