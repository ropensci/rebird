\name{hotspot_recent}
\alias{hotspot_recent}
\title{Returns the most recent sighting date and specific location for each species
of bird reported within the number of days specified by the "back" parameter
and reported at birding hotspots.}
\usage{
  hotspot_recent(LocIDs, back = NA, maxResults = NA,
    locale = NA, includeProvisional = F, sleep = 0, ...,
    url = "http://ebird.org/ws1.1/data/obs/hotspot/recent",
    curl = getCurlHandle())
}
\arguments{
  \item{LocIDs}{Code(s) for region of interest; here,
  regions are the locIDs of hotspots.  LocIDs that are not
  valid or are not hotspots are ignored. Maximum of 10
  locIDs.}

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
  Returns the most recent sighting date and specific
  location for each species of bird reported within the
  number of days specified by the "back" parameter and
  reported at birding hotspots.
}
\examples{
\dontrun{
hotspot_recent(c('L99381','L99382'))
hotspot_recent(c('L99381','L99382'), maxResults=10, includeProvisional=T, hotspot=T)
}
}

