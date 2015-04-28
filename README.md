reBird
======

[![Build Status](https://api.travis-ci.org/ropensci/rebird.png)](https://travis-ci.org/ropensci/rebird)  
[![Build status](https://ci.appveyor.com/api/projects/status/s3dobn991c20t2kg?svg=true)](https://ci.appveyor.com/project/sckott/rebird)
[![Coverage Status](https://coveralls.io/repos/ropensci/rebird/badge.svg)](https://coveralls.io/r/ropensci/rebird)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/rebird)](https://github.com/metacran/cranlogs.app)

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
## Source: local data frame [10 x 11]
## 
##               comName howMany      lat       lng    locID
## 1  American Goldfinch       1 42.08553 -76.03871 L2291049
## 2  American Goldfinch       2 42.08430 -75.95495 L1744580
## 3  American Goldfinch       3 42.10113 -76.17596 L3466633
## 4  American Goldfinch       4 42.08127 -76.31897 L3466847
## 5  American Goldfinch       3 42.08916 -75.90463  L197301
## 6  American Goldfinch       4 42.14559 -76.07031  L932555
## 7  American Goldfinch      25 42.14630 -75.96305  L275793
## 8  American Goldfinch       1 42.18595 -76.01614 L1846430
## 9  American Goldfinch       5 41.76206 -75.90543 L1793977
## 10 American Goldfinch      NA 42.12455 -76.22139 L1809615
## Variables not shown: locName (chr), locationPrivate (lgl), obsDt (chr),
##   obsReviewed (lgl), obsValid (lgl), sciName (chr)
```

## Recent observations at a region

Search for bird occurrences by region and species name


```r
ebirdregion(region = 'US', species = 'Setophaga caerulescens')
```

```
## Source: local data frame [19 x 11]
## 
##                        comName howMany      lat        lng    locID
## 1  Black-throated Blue Warbler       1 25.13917  -80.93750  L123130
## 2  Black-throated Blue Warbler       1 24.81497  -80.82018  L123591
## 3  Black-throated Blue Warbler       1 25.07778  -80.46183 L3468658
## 4  Black-throated Blue Warbler       1 25.28024  -80.29740  L768468
## 5  Black-throated Blue Warbler       1 25.86239  -80.19745  L613962
## 6  Black-throated Blue Warbler       1 26.37544  -81.60402  L127407
## 7  Black-throated Blue Warbler       1 32.58926 -111.46634  L271327
## 8  Black-throated Blue Warbler       2 25.17583  -80.36944  L127439
## 9  Black-throated Blue Warbler       1 26.34487  -81.65708 L1895941
## 10 Black-throated Blue Warbler       1 25.62582  -80.30560  L779318
## 11 Black-throated Blue Warbler       1 25.61600  -80.31416 L3263463
## 12 Black-throated Blue Warbler       1 25.62951  -80.31797 L3452272
## 13 Black-throated Blue Warbler       2 25.90170  -80.16423 L1109964
## 14 Black-throated Blue Warbler       1 25.73408  -80.31086  L200830
## 15 Black-throated Blue Warbler       1 26.27687  -80.21406 L1306908
## 16 Black-throated Blue Warbler       1 26.42877  -80.15696 L1139050
## 17 Black-throated Blue Warbler       1 25.38658  -80.62074 L3444787
## 18 Black-throated Blue Warbler       2 25.68065  -80.27264  L127425
## 19 Black-throated Blue Warbler       2 26.57162  -81.82589  L424819
## Variables not shown: locName (chr), locationPrivate (lgl), obsDt (chr),
##   obsReviewed (lgl), obsValid (lgl), sciName (chr)
```


## Recent observations at hotspots

Search for bird occurrences by region


```r
ebirdhotspot(locID = c('L99381','L99382'))
```

```
## Source: local data frame [17 x 11]
## 
##                    comName howMany      lat       lng  locID      locName
## 1      Eastern Screech-Owl       1 42.46229 -76.50185 L99381 Stewart Park
## 2             Canada Goose      50 42.46229 -76.50185 L99381 Stewart Park
## 3              Tundra Swan       2 42.46229 -76.50185 L99381 Stewart Park
## 4         Downy Woodpecker       1 42.46229 -76.50185 L99381 Stewart Park
## 5         Peregrine Falcon       1 42.46229 -76.50185 L99381 Stewart Park
## 6            American Crow       3 42.46229 -76.50185 L99381 Stewart Park
## 7              Horned Lark      30 42.46229 -76.50185 L99381 Stewart Park
## 8             Canada Goose       1 42.46182 -76.52054 L99382     Hog Hole
## 9             Herring Gull     700 42.46182 -76.52054 L99382     Hog Hole
## 10 Great Black-backed Gull     100 42.46182 -76.52054 L99382     Hog Hole
## 11        Downy Woodpecker       3 42.46182 -76.52054 L99382     Hog Hole
## 12           American Crow       6 42.46182 -76.52054 L99382     Hog Hole
## 13  Black-capped Chickadee       4 42.46182 -76.52054 L99382     Hog Hole
## 14 White-breasted Nuthatch       3 42.46182 -76.52054 L99382     Hog Hole
## 15       European Starling       5 42.46182 -76.52054 L99382     Hog Hole
## 16      American Goldfinch       1 42.46182 -76.52054 L99382     Hog Hole
## 17           House Sparrow       4 42.46182 -76.52054 L99382     Hog Hole
## Variables not shown: locationPrivate (lgl), obsDt (chr), obsReviewed
##   (lgl), obsValid (lgl), sciName (chr)
```


## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rebird/issues).
* License: MIT
* Get citation information for `rebird` in R doing `citation(package = 'rebird')`

---
  
This package is part of a richer suite called [spocc - Species Occurrence Data](https://github.com/ropensci/spocc), along with several other packages, that provide access to occurrence records from multiple databases. We recommend using `spocc` as the primary R interface to `rebird` unless your needs are limited to this single source.

---

[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
