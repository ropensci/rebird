\name{ebirdnotable}
\alias{ebirdnotable}
\title{Notable sightings}
\usage{
  ebirdnotable(lat = NULL, lng = NULL, dist = NULL,
    locID = NULL, region = NULL,
    regtype = c("country", "subnational1", "subnational2"),
    back = NULL, max = NULL, locale = NULL,
    provisional = FALSE, hotspot = FALSE, sleep = 0, ...)
}
\arguments{
  \item{lat}{Decimal latitude. value between -90.00 and
  90.00, up to two decimal places of precision.}

  \item{lng}{Decimal longitude. value between -180.00 and
  180.00, up to two decimal places of precision.}

  \item{locID}{Vector containing code(s) for up to 10
  regions of interest.}

  \item{region}{Region code corresponding to selected
  region type. For supported region and coding, see
  https://confluence.cornell.edu/display/CLOISAPI/eBird-1.1-RegionCodeReference}

  \item{regtype}{Region type you are interested in. can be
  "country" (e.g. "US"), "subnational1" (states/provinces,
  e.g. "US-NV") or "subnational" (counties, not yet
  implemented, e.g. "US-NY-109"). Default behavior is to
  try and match according to the region specified.}

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
  been reviewed be included? (defaults to FALSE)}

  \item{hotspot}{Should results be limited to sightings at
  birding hotspots?  (defaults to FALSE).}

  \item{sleep}{Time (in seconds) before function sends API
  call (defaults to zero.  Set to higher number if you are
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
  Returns the most recent notable observations by either
  latitude/longitude, hotspot or location ID, or particular
  region.
}
\note{
  \code{ebirdnotable} requires that either
  latitude/longitude, location ID, or region be passed to
  the function. Multiple entries (or lack of one) will
  result in error.
}
\examples{
\dontrun{
ebirdnotable(lat=42,lng=-70)
ebirdnotable(locID = c('L99381','L99382'))
ebirdnotable(region='US', max=10)
ebirdnotable(region='US-OH', regtype='subnational1')
}
}
\author{
  Rafael Maia \email{rm72@zips.uakron.edu}
}
\references{
  \url{http://ebird.org/}
}

