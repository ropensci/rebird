\name{ebird_geo}
\alias{ebird_geo}
\title{Sightings at location determined by latitude/longitude}
\usage{
  ebird_geo(lat, lng, species = NA, dist = NA, back = NA,
    maxResults = NA, locale = NA, includeProvisional = F,
    hotspot = F, sleep = 0, ...,
    url = "http://ebird.org/ws1.1/data/obs/geo/recent",
    curl = getCurlHandle())
}
\arguments{
  \item{species}{scientific name of the species of interest
  (not case sensitive). See eBird-1.1-SpeciesReference for
  a complete list of supported scientific names}

  \item{lat}{decimal latitude - value between -90.00 and
  90.00, two decimal places of precision required (is it?)}

  \item{lng}{decimal longitude - value between -180.00 and
  180.00, two decimal places of precision required (?)}

  \item{dist}{distance defining radius of interest from
  given lat/lng in kilometers - value between 0 and 50,
  defaults to 25}

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
  A data.frame containing the collected information:

  'comName' species common name

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
  Returns the most recent sighting date and specific
  location for the requested species of bird reported
  within the number of days specified and reported in the
  specified area.
}
\examples{
\dontrun{
ebird_geo(42,-76,'spinus tristis')
ebird_geo(42,-76, maxResults=10, includeProvisional=T, hotspot=T)
}
}

