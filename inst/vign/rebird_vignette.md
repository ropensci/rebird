<!--
%\VignetteEngine{knitr::docco_classic}
%\VignetteIndexEntry{rebird vignette}
-->

# Intro to the rebird package

A programmatic interface to the eBird database. Find out more about eBird at [their website](http://ebird.org/content/ebird/).

## Installation

You can install the stable version from CRAN


```r
install.packages("rebird")
```

Or the development version from Github


```r
install.packages("devtools")
devtools::install_github("ropensci/rebird")
```

Then load the package into the R sesssion


```r
library("rebird")
```

## Usage

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

Same, but with additional parameter settings, returning only 10 records, including provisional records, and hotspot records. 


```r
ebirdgeo(lat = 42, lng = -76, max = 10, includeProvisional = TRUE, hotspot = TRUE)
```

```
## Source: local data frame [10 x 11]
## 
##                   comName howMany      lat       lng    locID     locName
## 1                 Mallard       8 41.97517 -75.91675 L1476807 Quaker Lake
## 2       Northern Cardinal       1 41.97517 -75.91675 L1476807 Quaker Lake
## 3                Blue Jay       2 41.97517 -75.91675 L1476807 Quaker Lake
## 4       Belted Kingfisher       1 41.97517 -75.91675 L1476807 Quaker Lake
## 5       Pied-billed Grebe       7 41.97517 -75.91675 L1476807 Quaker Lake
## 6            Canada Goose       7 41.97517 -75.91675 L1476807 Quaker Lake
## 7              Ruddy Duck       6 41.97517 -75.91675 L1476807 Quaker Lake
## 8  Black-capped Chickadee       2 41.97517 -75.91675 L1476807 Quaker Lake
## 9      American Goldfinch       2 41.97517 -75.91675 L1476807 Quaker Lake
## 10          American Crow       2 41.97517 -75.91675 L1476807 Quaker Lake
## Variables not shown: locationPrivate (lgl), obsDt (chr), obsReviewed
##   (lgl), obsValid (lgl), sciName (chr)
```


### Recent sightings frm location IDs

Search for bird occurrences for two locations by their IDs 


```r
ebirdloc(locID = c('L99381','L99382'))
```

```
## Source: local data frame [106 x 11]
## 
##                comName howMany      lat       lng  locID      locName
## 1         Canada Goose     100 42.46133 -76.50593 L99381 Stewart Park
## 2  American Black Duck       2 42.46133 -76.50593 L99381 Stewart Park
## 3              Mallard      35 42.46133 -76.50593 L99381 Stewart Park
## 4    Green-winged Teal       1 42.46133 -76.50593 L99381 Stewart Park
## 5         Black Scoter       7 42.46133 -76.50593 L99381 Stewart Park
## 6           Bufflehead       4 42.46133 -76.50593 L99381 Stewart Park
## 7     Hooded Merganser       2 42.46133 -76.50593 L99381 Stewart Park
## 8     Common Merganser       5 42.46133 -76.50593 L99381 Stewart Park
## 9           Ruddy Duck       2 42.46133 -76.50593 L99381 Stewart Park
## 10   Pied-billed Grebe       5 42.46133 -76.50593 L99381 Stewart Park
## ..                 ...     ...      ...       ...    ...          ...
## Variables not shown: locationPrivate (lgl), obsDt (chr), obsReviewed
##   (lgl), obsValid (lgl), sciName (chr)
```

Search by location ID and species name, as well as some additional parameter settings 


```r
ebirdloc(locID = 'L99381', species = 'larus delawarensis', max = 10, provisional = TRUE, hotspot=TRUE)
```

```
## Source: local data frame [1 x 11]
## 
##            comName howMany      lat       lng  locID      locName
## 1 Ring-billed Gull      30 42.46133 -76.50593 L99381 Stewart Park
## Variables not shown: locationPrivate (lgl), obsDt (chr), obsReviewed
##   (lgl), obsValid (lgl), sciName (chr)
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

Search by location ID and species name, as well as some additional parameter settings. Note that we use `US-OH` to represent Ohio within the US. [See possible region values](https://confluence.cornell.edu/display/CLOISAPI/eBird-1.1-RegionCodeReference).


```r
ebirdregion(region = 'US-OH', max = 10, provisional = TRUE, hotspot = TRUE)
```

```
## Source: local data frame [10 x 11]
## 
##              comName howMany      lat       lng    locID
## 1        Common Loon       2 41.02637 -81.00213  L344785
## 2      Greater Scaup       2 41.02637 -81.00213  L344785
## 3   Bonaparte's Gull      65 41.02637 -81.00213  L344785
## 4   Great Blue Heron       2 41.02637 -81.00213  L344785
## 5   Ring-billed Gull      12 41.02637 -81.00213  L344785
## 6  Northern Shoveler       5 41.02637 -81.00213  L344785
## 7       Canada Goose      12 41.02637 -81.00213  L344785
## 8           Killdeer       1 40.97860 -81.10331  L625220
## 9    American Avocet       1 40.97860 -81.10331  L625220
## 10     Cooper's Hawk       1 40.19079 -82.96656 L1335935
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


### Recent notable sightings

Search for notable sightings at a given latitude and longitude


```r
ebirdnotable(lat = 42, lng = -70)
```

```
## Source: local data frame [889 x 11]
## 
##                   comName howMany      lat       lng    locID
## 1           Laughing Gull       9 43.86760 -69.99337  L479571
## 2         Eurasian Wigeon       1 41.39288 -71.57489  L815463
## 3             Pine Siskin      28 41.37219 -71.58563  L166161
## 4                  Osprey       1 42.80263 -71.25070 L1644653
## 5   Northern Saw-whet Owl       3 41.47650 -71.71549 L3142355
## 6               Mute Swan       5 42.78336 -72.52251 L2946415
## 7            Iceland Gull       1 43.00252 -71.38948 L3141739
## 8            Iceland Gull       1 43.00252 -71.38948 L3141739
## 9  Orange-crowned Warbler       1 43.04848 -70.71762 L1417537
## 10         Red-eyed Vireo       1 41.28284 -70.18813  L826086
## ..                    ...     ...      ...       ...      ...
## Variables not shown: locName (chr), locationPrivate (lgl), obsDt (chr),
##   obsReviewed (lgl), obsValid (lgl), sciName (chr)
```


### eBird taxonomy

Returns a data.frame of all species in the eBird taxonomy for the given parameter inputs


```r
ebirdtaxonomy()
```

```
## Source: local data frame [10,404 x 3]
## 
##                   comName                   sciName  taxonID
## 1                 Ostrich          Struthio camelus TC000001
## 2            Greater Rhea            Rhea americana TC000004
## 3             Lesser Rhea              Rhea pennata TC000005
## 4  Tawny-breasted Tinamou        Nothocercus julius TC000018
## 5        Highland Tinamou    Nothocercus bonapartei TC000019
## 6          Hooded Tinamou Nothocercus nigrocapillus TC000022
## 7            Gray Tinamou               Tinamus tao TC000023
## 8        Solitary Tinamou        Tinamus solitarius TC000024
## 9           Black Tinamou           Tinamus osgoodi TC000025
## 10          Great Tinamou             Tinamus major TC000026
## ..                    ...                       ...      ...
```

Search for hybrid species only


```r
ebirdtaxonomy(cat="hybrid")
```

```
## Source: local data frame [252 x 3]
## 
##                                              comName
## 1      Spotted x White-faced Whistling-Duck (hybrid)
## 2  Greater White-fronted x Bar-headed Goose (hybrid)
## 3        Greater White-fronted x Snow Goose (hybrid)
## 4                       Snow x Ross's Goose (hybrid)
## 5                        Brant x Snow Goose (hybrid)
## 6              Pink-footed x Barnacle Goose (hybrid)
## 7    Greater White-fronted x Barnacle Goose (hybrid)
## 8                  Graylag x Barnacle Goose (hybrid)
## 9                     Snow x Cackling Goose (hybrid)
## 10                  Ross's x Cackling Goose (hybrid)
## ..                                               ...
## Variables not shown: sciName (chr), taxonID (chr)
```
