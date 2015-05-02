reBird
======

[![Build Status](https://api.travis-ci.org/ropensci/rebird.png)](https://travis-ci.org/ropensci/rebird)
[![Build status](https://ci.appveyor.com/api/projects/status/s3dobn991c20t2kg?svg=true)](https://ci.appveyor.com/project/sckott/rebird)
[![Coverage Status](https://coveralls.io/repos/ropensci/rebird/badge.svg)](https://coveralls.io/r/ropensci/rebird)

`reBird` is a package to interface with the eBird webservices.

eBird is a real-time, online bird checklist program. For more information, visit their website: http://www.ebird.org

the API for the eBird webservices can be accessed here: https://confluence.cornell.edu/display/CLOISAPI/eBird+API+1.1

## Install

You can install the stable version from CRAN


```r
install.packages("rebird")
```

Or the development version from Github


```r
install.packages("devtools")
devtools::install_github("ropensci/rebird")
```

Then load the package


```r
library("rebird")
```

## Sightings at location determined by latitude/longitude

Search for bird occurrences by latitude and longitude point


```r
ebirdgeo(species = 'spinus tristis', lat = 42, lng = -76)
```

```
## Source: local data frame [45 x 11]
## 
##               comName      lat       lng    locID
## 1  American Goldfinch 42.09055 -76.06251  L837941
## 2  American Goldfinch 42.20641 -75.83381  L212476
## 3  American Goldfinch 42.08916 -75.90463  L197301
## 4  American Goldfinch 42.12462 -76.22163 L3580318
## 5  American Goldfinch 41.84560 -75.85645 L3254954
## 6  American Goldfinch 42.08553 -76.03871 L2291049
## 7  American Goldfinch 42.08182 -75.96821  L447646
## 8  American Goldfinch 42.16490 -76.25615 L2149891
## 9  American Goldfinch 41.76206 -75.90543 L1793977
## 10 American Goldfinch 41.94141 -75.90484  L917161
## ..                ...      ...       ...      ...
## Variables not shown: locName (chr), locationPrivate (lgl), obsDt (chr),
##   obsReviewed (lgl), obsValid (lgl), sciName (chr), howMany (int)
```

## Recent observations at a region

Search for bird occurrences by region and species name


```r
ebirdregion(region = 'US', species = 'Setophaga caerulescens')
```

```
## Source: local data frame [810 x 11]
## 
##                        comName howMany      lat       lng    locID
## 1  Black-throated Blue Warbler       2 27.64145 -80.40593 L1943632
## 2  Black-throated Blue Warbler      NA 26.11568 -80.23916  L614607
## 3  Black-throated Blue Warbler       3 27.59746 -80.34379 L3605491
## 4  Black-throated Blue Warbler       1 40.23749 -76.48787 L3602875
## 5  Black-throated Blue Warbler       1 42.47123 -76.45924 L1133152
## 6  Black-throated Blue Warbler       1 38.43480 -79.03610  L718652
## 7  Black-throated Blue Warbler       1 43.23972 -74.51710  L618982
## 8  Black-throated Blue Warbler       2 25.28024 -80.29740  L768468
## 9  Black-throated Blue Warbler       1 40.16182 -74.13066  L291443
## 10 Black-throated Blue Warbler       1 42.50105 -72.39450 L2073431
## ..                         ...     ...      ...       ...      ...
## Variables not shown: locName (chr), locationPrivate (lgl), obsDt (chr),
##   obsReviewed (lgl), obsValid (lgl), sciName (chr)
```


## Recent observations at hotspots

Search for bird occurrences by region


```r
ebirdhotspot(locID = c('L99381','L99382'))
```

```
## Source: local data frame [82 x 11]
## 
##                     comName      lat       lng  locID      locName
## 1              Canada Goose 42.46229 -76.50185 L99381 Stewart Park
## 2                   Mallard 42.46229 -76.50185 L99381 Stewart Park
## 3          Common Merganser 42.46229 -76.50185 L99381 Stewart Park
## 4          Great Blue Heron 42.46229 -76.50185 L99381 Stewart Park
## 5          Ring-billed Gull 42.46229 -76.50185 L99381 Stewart Park
## 6              Herring Gull 42.46229 -76.50185 L99381 Stewart Park
## 7  Lesser Black-backed Gull 42.46229 -76.50185 L99381 Stewart Park
## 8   Great Black-backed Gull 42.46229 -76.50185 L99381 Stewart Park
## 9              Caspian Tern 42.46229 -76.50185 L99381 Stewart Park
## 10            American Crow 42.46229 -76.50185 L99381 Stewart Park
## ..                      ...      ...       ...    ...          ...
## Variables not shown: locationPrivate (lgl), obsDt (chr), obsReviewed
##   (lgl), obsValid (lgl), sciName (chr), howMany (int)
```


## Frequency of observations at hotspots or regions

Obtain historical frequencies of bird occurrences by hotspot or region


```r
ebirdfreq(loctype = 'hotspots', loc = 'L196159')
```

```
## Source: local data frame [7,200 x 4]
## 
##    monthQt                             comName frequency sampleSize
## 1    Apr-1         Greater White-fronted Goose    0.0000         16
## 2    Apr-1                          Snow Goose    0.0000         16
## 3    Apr-1                      Cackling Goose    0.0000         16
## 4    Apr-1                        Canada Goose    0.3750         16
## 5    Apr-1                      Trumpeter Swan    0.0625         16
## 6    Apr-1                           Wood Duck    0.0625         16
## 7    Apr-1                             Gadwall    0.0000         16
## 8    Apr-1                     Eurasian Wigeon    0.1875         16
## 9    Apr-1                     American Wigeon    1.0000         16
## 10   Apr-1 Eurasian x American Wigeon (hybrid)    0.0000         16
## ..     ...                                 ...       ...        ...
```


## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rebird/issues).
* License: MIT
* Get citation information for `rebird` in R doing `citation(package = 'rebird')`

---

This package is part of a richer suite called [spocc - Species Occurrence Data](https://github.com/ropensci/spocc), along with several other packages, that provide access to occurrence records from multiple databases. We recommend using `spocc` as the primary R interface to `rebird` unless your needs are limited to this single source.

---

[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
