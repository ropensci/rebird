reBird
======

Linux: [![Build Status](https://api.travis-ci.org/ropensci/rebird.png)](https://travis-ci.org/ropensci/rebird)  
Windows: [![Build status](https://ci.appveyor.com/api/projects/status/9jee0co6w09faiop)](https://ci.appveyor.com/project/karthik/rebird)

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
## Source: local data frame [11 x 11]
## 
##               comName howMany      lat       lng    locID
## 1  American Goldfinch       1 42.08553 -76.03871 L2291049
## 2  American Goldfinch       2 41.97517 -75.91675 L1476807
## 3  American Goldfinch      NA 42.12503 -75.98304  L166647
## 4  American Goldfinch       1 42.17818 -75.88152  L505437
## 5  American Goldfinch      NA 42.08474 -76.08453  L270868
## 6  American Goldfinch      NA 42.16029 -75.98355  L487584
## 7  American Goldfinch       1 42.12617 -75.90142  L282327
## 8  American Goldfinch       2 41.94580 -75.90261  L717700
## 9  American Goldfinch       1 42.00900 -76.30417 L1191707
## 10 American Goldfinch       1 42.10770 -76.18350 L2347084
## 11 American Goldfinch      NA 42.12624 -75.99054 L1060822
## Variables not shown: locName (chr), locationPrivate (lgl), obsDt (chr),
##   obsReviewed (lgl), obsValid (lgl), sciName (chr)
```

### Recent observations at a region

Search for bird occurrences by region and species name


```r
ebirdregion(region = 'US', species = 'Setophaga caerulescens')
```

```
## Source: local data frame [329 x 11]
## 
##                        comName howMany      lat       lng    locID
## 1  Black-throated Blue Warbler       1 26.11568 -80.23916  L614607
## 2  Black-throated Blue Warbler       2 27.85683 -80.44876  L127386
## 3  Black-throated Blue Warbler       4 25.69530 -80.37340  L458792
## 4  Black-throated Blue Warbler       1 25.73408 -80.31086  L200830
## 5  Black-throated Blue Warbler       1 25.10079 -80.43446 L3141907
## 6  Black-throated Blue Warbler       2 26.15177 -80.14181 L1161428
## 7  Black-throated Blue Warbler       1 33.86518 -84.38024  L914689
## 8  Black-throated Blue Warbler       1 40.66389 -73.96861  L109516
## 9  Black-throated Blue Warbler       1 25.32295 -80.83315  L123123
## 10 Black-throated Blue Warbler       2 26.27687 -80.21406 L1306908
## ..                         ...     ...      ...       ...      ...
## Variables not shown: locName (chr), locationPrivate (lgl), obsDt (chr),
##   obsReviewed (lgl), obsValid (lgl), sciName (chr)
```


### Recent observations at hotspots

Search for bird occurrences by region and species name


```r
ebirdhotspot(locID = c('L99381','L99382'), species = 'larus delawarensis')
```

```
## Source: local data frame [2 x 11]
## 
##            comName howMany      lat       lng  locID      locName
## 1 Ring-billed Gull      30 42.46133 -76.50593 L99381 Stewart Park
## 2 Ring-billed Gull      45 42.46182 -76.52054 L99382     Hog Hole
## Variables not shown: locationPrivate (lgl), obsDt (chr), obsReviewed
##   (lgl), obsValid (lgl), sciName (chr)
```


## Meta

* Please report any issues or bugs](https://github.com/ropensci/rebird/issues).
* License: MIT
* Get citation information for `rebird` in R doing `citation(package = 'rebird')`

---
  
This package is part of a richer suite called [spocc - Species Occurrence Data](https://github.com/ropensci/spocc), along with several other packages, that provide access to occurrence records from multiple databases. We recommend using `spocc` as the primary R interface to `rebird` unless your needs are limited to this single source.

---

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
