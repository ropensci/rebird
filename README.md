reBird
======

[![Build Status](https://api.travis-ci.org/ropensci/rebird.png)](https://travis-ci.org/ropensci/rebird)
[![Build status](https://ci.appveyor.com/api/projects/status/s3dobn991c20t2kg?svg=true)](https://ci.appveyor.com/project/sckott/rebird)
[![Coverage Status](https://coveralls.io/repos/ropensci/rebird/badge.svg)](https://coveralls.io/r/ropensci/rebird)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/rebird)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/rebird)](https://cran.rstudio.com/package=rebird/)

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
## Source: local data frame [22 x 11]
## 
##               obsDt       lng
##               (chr)     (dbl)
## 1  2016-03-22 15:50 -76.03871
## 2  2016-03-22 09:35 -76.00722
## 3  2016-03-21 08:10 -75.89760
## 4  2016-03-20 11:00 -75.89836
## 5  2016-03-20 08:00 -75.85645
## 6  2016-03-20 07:30 -75.96821
## 7  2016-03-20 07:00 -76.01614
## 8  2016-03-19 16:45 -76.03404
## 9  2016-03-19 10:52 -75.98304
## 10 2016-03-19 10:50 -75.91689
## ..              ...       ...
## Variables not shown: locName (chr), obsValid (lgl), comName (chr),
##   obsReviewed (lgl), sciName (chr), locationPrivate (lgl), howMany (int),
##   lat (dbl), locID (chr)
```

## Recent observations at a region

Search for bird occurrences by region and species name


```r
ebirdregion(region = 'US', species = 'Setophaga caerulescens')
```

```
## Source: local data frame [12 x 11]
## 
##               obsDt       lng                                      locName
##               (chr)     (dbl)                                        (chr)
## 1  2016-03-21 12:15 -81.36384           US-Florida-Lake Mary-Extended Stay
## 2  2016-03-20 11:29 -80.31086                            A. D. Barnes Park
## 3  2016-03-20 11:00 -81.54980                               Crooked Holler
## 4  2016-03-20 09:53 -81.84061                     Dave  and  Tammy's House
## 5  2016-03-19 17:20 -80.14181 Richardson Historic Park and Nature Preserve
## 6  2016-03-19 10:00 -80.34860                              Cutler Wetlands
## 7  2016-03-19 07:45 -80.44960                       Castellow Hammock Park
## 8  2016-03-17 08:15 -80.17166                      Topeekeegee Yugnee Park
## 9  2016-03-16 13:41 -80.82018                                  Long Key SP
## 10 2016-03-12 09:48 -80.39846                                    Zoo Miami
## 11 2016-03-11 11:36 -80.41000                 John Pennekamp Coral Reef SP
## 12 2016-03-11 09:00 -80.15430                               Greynolds Park
## Variables not shown: obsValid (lgl), comName (chr), obsReviewed (lgl),
##   sciName (chr), locationPrivate (lgl), howMany (int), lat (dbl), locID
##   (chr)
```


## Recent observations at hotspots

Search for bird occurrences by region


```r
ebirdhotspot(locID = c('L99381','L99382'))
```

```
## Source: local data frame [99 x 11]
## 
##               obsDt       lng      locName obsValid           comName
##               (chr)     (dbl)        (chr)    (lgl)             (chr)
## 1  2016-03-23 08:23 -76.50375 Stewart Park     TRUE        Snow Goose
## 2  2016-03-23 08:23 -76.50375 Stewart Park     TRUE      Canada Goose
## 3  2016-03-23 08:23 -76.50375 Stewart Park     TRUE         Wood Duck
## 4  2016-03-23 08:23 -76.50375 Stewart Park     TRUE           Mallard
## 5  2016-03-23 08:23 -76.50375 Stewart Park     TRUE      Lesser Scaup
## 6  2016-03-23 08:23 -76.50375 Stewart Park     TRUE  Hooded Merganser
## 7  2016-03-23 08:23 -76.50375 Stewart Park     TRUE  Common Merganser
## 8  2016-03-23 08:23 -76.50375 Stewart Park     TRUE        Ruddy Duck
## 9  2016-03-23 08:23 -76.50375 Stewart Park     TRUE Pied-billed Grebe
## 10 2016-03-23 08:23 -76.50375 Stewart Park     TRUE      Horned Grebe
## ..              ...       ...          ...      ...               ...
## Variables not shown: obsReviewed (lgl), sciName (chr), locationPrivate
##   (lgl), howMany (int), lat (dbl), locID (chr)
```


## Frequency of observations at hotspots or regions

Obtain historical frequencies of bird occurrences by hotspot or region


```r
ebirdfreq(loctype = 'hotspots', loc = 'L196159')
```

```
## Source: local data frame [8,304 x 4]
## 
##                        comName   monthQt frequency sampleSize
##                          (chr)     (chr)     (dbl)      (dbl)
## 1  Greater White-fronted Goose January-1 0.0000000         22
## 2                   Snow Goose January-1 0.0000000         22
## 3               Cackling Goose January-1 0.0000000         22
## 4                 Canada Goose January-1 0.0000000         22
## 5        Cackling/Canada Goose January-1 0.0000000         22
## 6               Trumpeter Swan January-1 0.0000000         22
## 7                    Wood Duck January-1 0.1818182         22
## 8                      Gadwall January-1 0.0000000         22
## 9              Eurasian Wigeon January-1 0.4090909         22
## 10             American Wigeon January-1 1.0000000         22
## ..                         ...       ...       ...        ...
```


## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rebird/issues).
* License: MIT
* Get citation information for `rebird` in R doing `citation(package = 'rebird')`

---

This package is part of a richer suite called [spocc - Species Occurrence Data](https://github.com/ropensci/spocc), along with several other packages, that provide access to occurrence records from multiple databases. We recommend using `spocc` as the primary R interface to `rebird` unless your needs are limited to this single source.

---

[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
