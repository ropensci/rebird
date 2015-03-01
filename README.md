reBird
======

Linux: [![Build Status](https://api.travis-ci.org/ropensci/rebird.png)](https://travis-ci.org/ropensci/rebird)  
Windows: [![Build status](https://ci.appveyor.com/api/projects/status/9jee0co6w09faiop)](https://ci.appveyor.com/project/karthik/rebird)
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

## Examples


### Sightings at location determined by latitude/longitude

Search for bird occurrences by latitude and longitude point


```r
ebirdgeo(species = 'spinus tristis', lat = 42, lng = -76)
```

```
## Source: local data frame [27 x 11]
## 
##               comName howMany      lat       lng    locID
## 1  American Goldfinch       1 42.08553 -76.03871 L2291049
## 2  American Goldfinch       1 42.14559 -76.07031  L932555
## 3  American Goldfinch      10 42.08916 -75.90463  L197301
## 4  American Goldfinch      NA 42.04879 -75.93579 L1544184
## 5  American Goldfinch       5 42.08430 -75.95495 L1744580
## 6  American Goldfinch       1 42.11247 -76.00171  L274662
## 7  American Goldfinch       4 41.76206 -75.90543 L1793977
## 8  American Goldfinch      12 41.81636 -75.91297 L3357555
## 9  American Goldfinch       2 42.00900 -76.30417 L1191707
## 10 American Goldfinch       6 42.10002 -76.25698 L3390942
## ..                ...     ...      ...       ...      ...
## Variables not shown: locName (chr), locationPrivate (lgl), obsDt (chr),
##   obsReviewed (lgl), obsValid (lgl), sciName (chr)
```

### Recent observations at a region

Search for bird occurrences by region and species name


```r
ebirdregion(region = 'US', species = 'Setophaga caerulescens')
```

```
## Source: local data frame [19 x 11]
## 
##                        comName howMany      lat        lng    locID
## 1  Black-throated Blue Warbler       1 24.81497  -80.82018  L123591
## 2  Black-throated Blue Warbler       1 26.42877  -80.15696 L1139050
## 3  Black-throated Blue Warbler       1 25.38658  -80.62074 L3444787
## 4  Black-throated Blue Warbler       2 25.68065  -80.27264  L127425
## 5  Black-throated Blue Warbler       1 25.73408  -80.31086  L200830
## 6  Black-throated Blue Warbler       2 26.38290  -80.06920  L127416
## 7  Black-throated Blue Warbler       2 26.03731  -80.17166  L578423
## 8  Black-throated Blue Warbler       2 24.63433  -81.36030  L582112
## 9  Black-throated Blue Warbler       2 25.87870  -80.18590 L2753423
## 10 Black-throated Blue Warbler       1 26.14140  -80.10480  L127418
## 11 Black-throated Blue Warbler      NA 26.36755  -80.07529 L2043372
## 12 Black-throated Blue Warbler       1 25.61277  -80.39846 L1282387
## 13 Black-throated Blue Warbler       1 26.27687  -80.21406 L1306908
## 14 Black-throated Blue Warbler       1 37.21659 -121.98808 L2734561
## 15 Black-throated Blue Warbler       1 32.58926 -111.46634  L271327
## 16 Black-throated Blue Warbler       1 25.18770  -80.87418  L127437
## 17 Black-throated Blue Warbler       1 37.22013 -121.98232 L3308983
## 18 Black-throated Blue Warbler       1 31.87356 -109.18475 L3395838
## 19 Black-throated Blue Warbler       1 25.71961  -80.27697  L682100
## Variables not shown: locName (chr), locationPrivate (lgl), obsDt (chr),
##   obsReviewed (lgl), obsValid (lgl), sciName (chr)
```


### Recent observations at hotspots

Search for bird occurrences by region and species name


```r
ebirdhotspot(locID = c('L99381','L99382'), species = 'larus delawarensis')
```

```
## Source: local data frame [0 x 0]
```


## Meta

* Please report any issues or bugs](https://github.com/ropensci/rebird/issues).
* License: MIT
* Get citation information for `rebird` in R doing `citation(package = 'rebird')`

---
  
This package is part of a richer suite called [spocc - Species Occurrence Data](https://github.com/ropensci/spocc), along with several other packages, that provide access to occurrence records from multiple databases. We recommend using `spocc` as the primary R interface to `rebird` unless your needs are limited to this single source.

---

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
