reBird
======

[![Build Status](https://api.travis-ci.org/ropensci/rebird.png)](https://travis-ci.org/ropensci/rebird)

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
library("devtools")
install_github("ropensci/rebird")
```

Then load the package into the R sesssion


```r
library("rebird")
```

## Examples


### Sightings at location determined by latitude/longitude

Search for bird occurrences by latitude and longitude point


```r
out <- ebirdgeo(species = 'spinus tristis', lat = 42, lng = -76)
head(out)
```

```
##              comName howMany   lat    lng    locID
## 1 American Goldfinch       4 42.11 -76.00  L274662
## 2 American Goldfinch       1 42.08 -75.96 L1744580
## 3 American Goldfinch       4 42.21 -75.83  L212476
## 4 American Goldfinch       4 41.95 -75.90  L717700
## 5 American Goldfinch       7 42.08 -75.97  L447646
## 6 American Goldfinch       2 42.13 -76.00  L519103
##                                 locName locationPrivate            obsDt
## 1                   River Rd. (Endwell)           FALSE 2014-05-08 15:52
## 2                           Vestal Area            TRUE 2014-05-08 13:45
## 3                    Chenango Valley SP           FALSE 2014-05-08 12:11
## 4                            PA-Sq-Home            TRUE 2014-05-08 11:30
## 5 Binghamton University Nature Preserve           FALSE 2014-05-08 09:30
## 6                    Waterman--IBM Glen           FALSE 2014-05-08 08:15
##   obsReviewed obsValid        sciName
## 1       FALSE     TRUE Spinus tristis
## 2       FALSE     TRUE Spinus tristis
## 3       FALSE     TRUE Spinus tristis
## 4       FALSE     TRUE Spinus tristis
## 5       FALSE     TRUE Spinus tristis
## 6       FALSE     TRUE Spinus tristis
```

### Recent observations at a region

Search for bird occurrences by region and species name


```r
out3 <- ebirdregion(region = 'US', species = 'Setophaga caerulescens')
head(out3)
```

```
##                       comName howMany   lat    lng   locID
## 1 Black-throated Blue Warbler       1 43.12 -77.47 L868257
## 2 Black-throated Blue Warbler       1 39.95 -75.20 L715912
## 3 Black-throated Blue Warbler       2 40.74 -73.99 L525218
## 4 Black-throated Blue Warbler       1 43.13 -72.53 L509797
## 5 Black-throated Blue Warbler       2 39.29 -76.58 L449982
## 6 Black-throated Blue Warbler       1 40.86 -73.45 L123000
##                           locName locationPrivate            obsDt
## 1  4 Woodside Drive, Penfield, NY            TRUE 2014-05-08 16:00
## 2             Woodlands Cemetery            FALSE 2014-05-08 15:30
## 3             Madison Square Park           FALSE 2014-05-08 15:22
## 4 Hitchcock Hill Saxtons River VT            TRUE 2014-05-08 14:45
## 5                  Patterson Park           FALSE 2014-05-08 14:45
## 6           Uplands Farm Preserve           FALSE 2014-05-08 14:07
##   obsReviewed obsValid                sciName
## 1       FALSE     TRUE Setophaga caerulescens
## 2       FALSE     TRUE Setophaga caerulescens
## 3       FALSE     TRUE Setophaga caerulescens
## 4       FALSE     TRUE Setophaga caerulescens
## 5       FALSE     TRUE Setophaga caerulescens
## 6       FALSE     TRUE Setophaga caerulescens
```


### Recent observations at hotspots

Search for bird occurrences by region and species name


```r
ebirdhotspot(locID = c('L99381','L99382'), species = 'larus delawarensis')
```

```
##            comName howMany   lat    lng  locID      locName
## 1 Ring-billed Gull      25 42.46 -76.51 L99381 Stewart Park
## 2 Ring-billed Gull       2 42.46 -76.52 L99382     Hog Hole
##   locationPrivate            obsDt obsReviewed obsValid            sciName
## 1           FALSE 2014-05-06 19:50       FALSE     TRUE Larus delawarensis
## 2           FALSE 2014-04-28 17:00       FALSE     TRUE Larus delawarensis
```


## Meta

Please report any issues or bugs](https://github.com/ropensci/rebird/issues).

License: MIT

This package is part of the [rOpenSci](http://ropensci.org/packages) project.

To cite package `rebird` in publications use:


```

To cite package 'rebird' in publications use:

  Rafael Maia, Scott Chamberlain and Andy Teucher (2012). rebird:
  Interface to eBird. R package version 0.1.1.
  http://github.com/ropensci/rebird

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {rebird: Interface to eBird},
    author = {Rafael Maia and Scott Chamberlain and Andy Teucher},
    year = {2012},
    note = {R package version 0.1.1},
    url = {http://github.com/ropensci/rebird},
  }
```

Get citation information for `rebird` in R doing `citation(package = 'rebird')`

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
