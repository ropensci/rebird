% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ebirdnotable.R
\name{ebirdnotable}
\alias{ebirdnotable}
\title{Recent nearby notable observations}
\usage{
ebirdnotable(
  lat = NULL,
  lng = NULL,
  dist = NULL,
  locID = NULL,
  region = NULL,
  back = NULL,
  max = NULL,
  provisional = FALSE,
  hotspot = FALSE,
  simple = TRUE,
  sleep = 0,
  key = NULL,
  ...
)
}
\arguments{
\item{lat}{Decimal latitude. value between -90.00 and 90.00, up to two
decimal places of precision.}

\item{lng}{Decimal longitude. value between -180.00 and 180.00, up to
two decimal places of precision.}

\item{dist}{Distance defining radius of interest from given lat/lng in
kilometers (between 0 and 50, defaults to 25)}

\item{locID}{Vector containing code(s) for up to 10 locations of interest.}

\item{region}{Region code corresponding to selected region type.
For supported region and coding, see
https://confluence.cornell.edu/display/CLOISAPI/eBird-1.1-RegionCodeReference}

\item{back}{Number of days back to look for observations (between
1 and 30, defaults to 14).}

\item{max}{Maximum number of result rows to return in this request
(between 1 and 10000, defaults to all).}

\item{provisional}{Should flagged records that have not been reviewed
be included? (defaults to FALSE)}

\item{hotspot}{Should results be limited to sightings at birding hotspots?
(defaults to FALSE).}

\item{simple}{Logical. Whether to return a simple (TRUE, default) or detailed
(FALSE) set of results fields.}

\item{sleep}{Time (in seconds) before function sends API call (defaults to
zero.  Set to higher number if you are using this function in a loop with
many API calls).}

\item{key}{eBird API key. You can obtain one from https://ebird.org/api/keygen.
We strongly recommend storing it in your \code{.Renviron} file as an 
environment variable called \code{EBIRD_KEY}.}

\item{...}{Curl options passed on to \code{\link[httr]{GET}}}
}
\value{
A data.frame containing the collected information:

"speciesCode": species code

"comName": species common name

"sciName" species' scientific name

"locId": unique identifier for the location

"locName": location name

"obsDt": observation date formatted according to ISO 8601
   (e.g. 'YYYY-MM-DD', or 'YYYY-MM-DD hh:mm'). Hours and minutes are excluded
   if the observer did not report an observation time.

"howMany": number of individuals observed, NA if only presence was noted

"lat": latitude of the location

"lng": longitude of the location

"obsValid": TRUE if observation has been deemed valid by either the

"obsReviewed": TRUE if observation has been reviewed, FALSE otherwise

"locationPrivate": TRUE if location is not a birding hotspot
   automatic filters or a regional viewer, FALSE otherwise

"subId": submission ID

"exoticCategory": Exotic category

"subnational2Code": county code (returned if simple=FALSE)

"subnational2Name": county name (returned if simple=FALSE)

"subnational1Code": state/province ISO code (returned if simple=FALSE)

"subnational1Name": state/province name (returned if simple=FALSE)

"countryCode": country ISO code (returned if simple=FALSE)

"countryName": country name (returned if simple=FALSE)

"userDisplayName": observer's eBird username (returned if simple=FALSE)

"obsID": observation ID (returned if simple=FALSE)

"checklistID": checklist ID (returned if simple=FALSE)

"presenceNoted": 'true' if user marked presence but did not count the
  number of birds. 'false' otherwise (returned if simple=FALSE)

"firstName": observer's first name (returned if simple=FALSE)

"lastName": observer's last name (returned if simple=FALSE)
}
\description{
Returns the most recent notable observations by either latitude/longitude,
hotspot or location ID, or particular region.
}
\note{
\code{ebirdnotable} requires that either latitude/longitude, location ID,
or region be passed to the function. Multiple entries will result in the most
specific being used. If none is supplied, defaults to lat/lng based on your IP.
}
\examples{
\dontrun{
ebirdnotable(lat=42, lng=-70)
ebirdnotable(region='US', max=10)
ebirdnotable(region='US-OH')
ebirdnotable(region='CA-NS-HL')
ebirdnotable(locID = c('L275836','L124345'))
}
}
\references{
\url{http://ebird.org/}
}
\author{
Rafael Maia \email{rm72@zips.uakron.edu},
   Sebastian Pardo \email{sebpardo@gmail.com}
}
