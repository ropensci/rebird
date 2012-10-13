\name{ebird_notable}
\alias{ebird_notable}
\title{Returns a list of recent notable observations by either latitude/longitude,
hotspot or location ID, or particular region.}
\usage{
  ebird_notable(lat = NA, lng = NA, dist = NA, locID = NA,
    region = NA,
    regtype = c("country", "subnational1", "subnational2"),
    back = NA, maxResults = NA, locale = NA,
    includeProvisional = F, hotspot = F, sleep = 0, ...,
    url = "http://ebird.org/ws1.1/data/notable/geo/recent",
    curl = getCurlHandle())
}
\arguments{
  \item{lat}{decimal latitude - value between -90.00 and
  90.00, two decimal places of precision required (is it?)}

  \item{lng}{decimal longitude - value between -180.00 and
  180.00, two decimal places of precision required (?)}

  \item{LocIDs}{Code(s) for region of interest.}

  \item{region}{region code corresponding to selected
  region type. See
  https://confluence.cornell.edu/display/CLOISAPI/eBird-1.1-RegionCodeReference}

  \item{regtype}{the region type you are interested in. can
  be "country" (e.g. "US"), "subnational1"
  (states/provinces, e.g. "US-NV") or "subnational"
  (counties, not yet implemented, e.g. "US-NY-109")}

  \item{back}{the number of days back to look for
  observations - value between 1 and 30, defaults to 14}

  \item{maxResults}{the maximum number of result rows to
  return in this request - value between 1 and 10000,
  defaults to all}

  \item{locale}{Language/locale of response (when
  translations are available).  See
  http://java.sun.com/javase/6/docs/api/java/util/Locale.html
  - defaults to en_US}

  \item{includeProvisional}{should flagged records that
  have not been reviewed be included? - defaults to F}

  \item{hotspot}{should results be limited to sightings at
  birding hotspots?  - defaults to F}

  \item{sleep}{Time (in seconds) before function sends API
  call - defaults to zero.  Set to higher number if you are
  using this function in a loop with many API calls.}
}
\value{
  comName species common name

  howMany number of individuals observed, NA if only
  presence was noted

  lat latitude of the location

  lng longitude of the location

  locID unique identifier for the location

  locName location name

  locationPrivate TRUE if location is not a birding hotspot

  obsDt observation date formatted according to ISO 8601
  (e.g. 'YYYY-MM-DD', or 'YYYY-MM-DD hh:mm').  Hours and
  minutes are excluded if the observer did not report an
  observation time.

  obsReviewed TRUE if observation has been reviewed, FALSE
  otherwise

  obsValid TRUE if observation has been deemed valid by
  either the automatic filters or a regional viewer, FALSE
  otherwise

  sciName species scientific name
}
\description{
  Returns a list of recent notable observations by either
  latitude/longitude, hotspot or location ID, or particular
  region.
}
\examples{
\dontrun{
ebird_notable(lat=42,lng=-70)
ebird_notable(locID = c('L99381','L99382'))
ebird_notable(region='US', max=10)
ebird_notable(region='US-OH', regtype='subnational1')
}
}

