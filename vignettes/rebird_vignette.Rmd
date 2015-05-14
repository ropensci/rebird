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

Same, but with additional parameter settings, returning only 10 records, including provisional records, and hotspot records. 


```r
ebirdgeo(lat = 42, lng = -76, max = 10, includeProvisional = TRUE, hotspot = TRUE)
```

```
## Source: local data frame [10 x 11]
## 
##                 comName howMany      lat       lng   locID     locName
## 1         American Crow       1 42.17818 -75.88152 L505437 Boland Pond
## 2        Yellow Warbler       1 42.17818 -75.88152 L505437 Boland Pond
## 3          Barn Swallow       3 42.17818 -75.88152 L505437 Boland Pond
## 4        American Robin       1 42.17818 -75.88152 L505437 Boland Pond
## 5             Wood Duck       7 42.17818 -75.88152 L505437 Boland Pond
## 6          Tree Swallow      12 42.17818 -75.88152 L505437 Boland Pond
## 7         Swamp Sparrow       1 42.17818 -75.88152 L505437 Boland Pond
## 8  Red-winged Blackbird      12 42.17818 -75.88152 L505437 Boland Pond
## 9     Northern Cardinal       1 42.17818 -75.88152 L505437 Boland Pond
## 10             Killdeer       1 42.17818 -75.88152 L505437 Boland Pond
## Variables not shown: locationPrivate (lgl), obsDt (chr), obsReviewed
##   (lgl), obsValid (lgl), sciName (chr)
```


### Recent sightings frm location IDs

Search for bird occurrences for two locations by their IDs 


```r
ebirdloc(locID = c('L99381','L99382'))
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

Search by location ID and species name, as well as some additional parameter settings 


```r
ebirdloc(locID = 'L99381', species = 'larus delawarensis', max = 10, provisional = TRUE, hotspot=TRUE)
```

```
## Source: local data frame [1 x 10]
## 
##            comName      lat       lng  locID      locName locationPrivate
## 1 Ring-billed Gull 42.46229 -76.50185 L99381 Stewart Park           FALSE
## Variables not shown: obsDt (chr), obsReviewed (lgl), obsValid (lgl),
##   sciName (chr)
```


### Recent observations at a region

Search for bird occurrences by region and species name


```r
ebirdregion(region = 'US', species = 'Setophaga caerulescens')
```

```
## Source: local data frame [809 x 11]
## 
##                        comName howMany      lat       lng    locID
## 1  Black-throated Blue Warbler       2 27.64145 -80.40593 L1943632
## 2  Black-throated Blue Warbler      NA 26.11568 -80.23916  L614607
## 3  Black-throated Blue Warbler       3 27.59746 -80.34379 L3605491
## 4  Black-throated Blue Warbler       1 40.23749 -76.48787 L3602875
## 5  Black-throated Blue Warbler       1 42.47123 -76.45924 L1133152
## 6  Black-throated Blue Warbler       2 37.52409 -77.47499  L268263
## 7  Black-throated Blue Warbler       1 38.43480 -79.03610  L718652
## 8  Black-throated Blue Warbler       1 43.23972 -74.51710  L618982
## 9  Black-throated Blue Warbler       2 25.28024 -80.29740  L768468
## 10 Black-throated Blue Warbler       1 40.16182 -74.13066  L291443
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
##                          comName howMany      lat       lng    locID
## 1               Great Blue Heron       1 39.59806 -84.29031 L1814116
## 2                      Wood Duck       2 39.59806 -84.29031 L1814116
## 3                   Tree Swallow      16 39.59806 -84.29031 L1814116
## 4                   Song Sparrow       2 39.59806 -84.29031 L1814116
## 5           Red-winged Blackbird       8 39.59806 -84.29031 L1814116
## 6                 Orchard Oriole       1 39.59806 -84.29031 L1814116
## 7  Northern Rough-winged Swallow       5 39.59806 -84.29031 L1814116
## 8              Northern Cardinal       4 39.59806 -84.29031 L1814116
## 9                  Mourning Dove       4 39.59806 -84.29031 L1814116
## 10                       Mallard       6 39.59806 -84.29031 L1814116
## Variables not shown: locName (chr), locationPrivate (lgl), obsDt (chr),
##   obsReviewed (lgl), obsValid (lgl), sciName (chr)
```


### Recent observations at hotspots

Search for bird occurrences by region and species name


```r
ebirdhotspot(locID = c('L99381','L99382'), species = 'larus delawarensis')
```

```
## Source: local data frame [1 x 10]
## 
##            comName      lat       lng  locID      locName locationPrivate
## 1 Ring-billed Gull 42.46229 -76.50185 L99381 Stewart Park           FALSE
## Variables not shown: obsDt (chr), obsReviewed (lgl), obsValid (lgl),
##   sciName (chr)
```


### Frequency of observations at hotspots or regions

Obtain historical frequencies of bird occurrences at a given hotspot


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

Same, but in wide format (for making bar charts)


```r
ebirdfreq(loctype = 'hotspots', loc = 'L196159', long = FALSE)
```

```
## Source: local data frame [151 x 49]
## 
##                        comName Jan-1      Jan-2      Jan-3      Jan-4
## 1                 Sample Size:  15.0 18.0000000 19.0000000 26.0000000
## 2  Greater White-fronted Goose   0.0  0.0000000  0.0000000  0.0000000
## 3                   Snow Goose   0.0  0.0000000  0.0000000  0.0000000
## 4               Cackling Goose   0.0  0.0000000  0.0000000  0.0000000
## 5                 Canada Goose   0.0  0.0000000  0.0000000  0.0000000
## 6               Trumpeter Swan   0.0  0.0000000  0.0000000  0.0000000
## 7                    Wood Duck   0.2  0.0000000  0.0000000  0.0000000
## 8                      Gadwall   0.0  0.0000000  0.0000000  0.0000000
## 9              Eurasian Wigeon   0.6  0.7777778  0.8421053  0.4230769
## 10             American Wigeon   1.0  1.0000000  0.9473684  0.9230769
## ..                         ...   ...        ...        ...        ...
## Variables not shown: Feb-1 (dbl), Feb-2 (dbl), Feb-3 (dbl), Feb-4 (dbl),
##   Mar-1 (dbl), Mar-2 (dbl), Mar-3 (dbl), Mar-4 (dbl), Apr-1 (dbl), Apr-2
##   (dbl), Apr-3 (dbl), Apr-4 (dbl), May-1 (dbl), May-2 (dbl), May-3 (dbl),
##   May-4 (dbl), Jun-1 (dbl), Jun-2 (dbl), Jun-3 (dbl), Jun-4 (dbl), Jul-1
##   (dbl), Jul-2 (dbl), Jul-3 (dbl), Jul-4 (dbl), Aug-1 (dbl), Aug-2 (dbl),
##   Aug-3 (dbl), Aug-4 (dbl), Sep-1 (dbl), Sep-2 (dbl), Sep-3 (dbl), Sep-4
##   (dbl), Oct-1 (dbl), Oct-2 (dbl), Oct-3 (dbl), Oct-4 (dbl), Nov-1 (dbl),
##   Nov-2 (dbl), Nov-3 (dbl), Nov-4 (dbl), Dec-1 (dbl), Dec-2 (dbl), Dec-3
##   (dbl), Dec-4 (dbl)
```

Obtain frequency data for a given state


```r
ebirdfreq(loctype = 'states', loc = 'CA-BC')
```

```
## Source: local data frame [31,248 x 4]
## 
##    monthQt                                               comName
## 1    Apr-1                                Fulvous Whistling-Duck
## 2    Apr-1                           Greater White-fronted Goose
## 3    Apr-1                                         Emperor Goose
## 4    Apr-1                                            Snow Goose
## 5    Apr-1                                          Ross's Goose
## 6    Apr-1                                     Snow/Ross's Goose
## 7    Apr-1                                                 Brant
## 8    Apr-1                                        Cackling Goose
## 9    Apr-1                                          Canada Goose
## 10   Apr-1 Graylag Goose (Domestic type) x Canada Goose (hybrid)
## ..     ...                                                   ...
## Variables not shown: frequency (dbl), sampleSize (dbl)
```

Or county


```r
ebirdfreq(loctype = 'counties', loc = 'CA-BC-GV')
```

```
## Source: local data frame [22,368 x 4]
## 
##    monthQt                     comName   frequency sampleSize
## 1    Apr-1 Greater White-fronted Goose 0.011224988       2049
## 2    Apr-1               Emperor Goose 0.000000000       2049
## 3    Apr-1                  Snow Goose 0.049780381       2049
## 4    Apr-1                Ross's Goose 0.000000000       2049
## 5    Apr-1           Snow/Ross's Goose 0.000000000       2049
## 6    Apr-1                       Brant 0.010736945       2049
## 7    Apr-1              Cackling Goose 0.001952172       2049
## 8    Apr-1                Canada Goose 0.349926794       2049
## 9    Apr-1       Cackling/Canada Goose 0.002440215       2049
## 10   Apr-1                   goose sp. 0.000000000       2049
## ..     ...                         ...         ...        ...
```

Obtain frequency data within a range of years and months


```r
ebirdfreq(loctype = 'hotspots', loc = 'L196159', startyear = 2010,
          endyear = 2014, startmonth = 1, endmonth = 3)
```

```
## Source: local data frame [3,792 x 4]
## 
##    monthQt                             comName frequency sampleSize
## 1    Apr-1                        Canada Goose     0.375          8
## 2    Apr-1                           Wood Duck     0.125          8
## 3    Apr-1                             Gadwall     0.000          8
## 4    Apr-1                     Eurasian Wigeon     0.375          8
## 5    Apr-1                     American Wigeon     1.000          8
## 6    Apr-1 Eurasian x American Wigeon (hybrid)     0.000          8
## 7    Apr-1                             Mallard     1.000          8
## 8    Apr-1                   Northern Shoveler     0.875          8
## 9    Apr-1                    Northern Pintail     0.000          8
## 10   Apr-1                   Green-winged Teal     0.000          8
## ..     ...                                 ...       ...        ...
```


### Recent notable sightings

Search for notable sightings at a given latitude and longitude


```r
ebirdnotable(lat = 42, lng = -70)
```

```
## Source: local data frame [855 x 11]
## 
##                comName howMany      lat       lng    locID
## 1    Pied-billed Grebe       1 41.63473 -70.89272  L777463
## 2         Common Raven       1 42.28156 -71.18548  L350679
## 3     Common Merganser       6 42.33418 -71.15639  L457287
## 4         Lesser Scaup       2 42.19266 -71.04850  L455487
## 5     Common Goldeneye       1 42.19266 -71.04850  L455487
## 6               Dunlin       1 42.46124 -71.64811  L682249
## 7       Indigo Bunting       1 42.43312 -71.21488 L3604499
## 8     Ring-necked Duck      21 42.53462 -72.27278 L1438066
## 9  Boat-tailed Grackle       1 41.26199 -72.55482  L298379
## 10        Purple Finch       2 41.07558 -72.44159  L140623
## ..                 ...     ...      ...       ...      ...
## Variables not shown: locName (chr), locationPrivate (lgl), obsDt (chr),
##   obsReviewed (lgl), obsValid (lgl), sciName (chr)
```


### eBird taxonomy

Returns a data.frame of all species in the eBird taxonomy for the given parameter inputs


```r
ebirdtaxonomy()
```

```
## Source: local data frame [10,404 x 9]
## 
##    bandingCodes category                comName   comNameCodes
## 1            NA  species                Ostrich SOOS,OSTR,COOS
## 2            NA  species           Greater Rhea           GRRH
## 3            NA  species            Lesser Rhea           LERH
## 4            NA  species Tawny-breasted Tinamou           TBTI
## 5          HITI  species       Highland Tinamou             NA
## 6            NA  species         Hooded Tinamou           HOTI
## 7            NA  species           Gray Tinamou           GRTI
## 8            NA  species       Solitary Tinamou           SOTI
## 9            NA  species          Black Tinamou           BLTI
## 10         GRTI  species          Great Tinamou             NA
## ..          ...      ...                    ...            ...
## Variables not shown: sciName (chr), sciNameCodes (chr), speciesCode (chr),
##   taxonID (chr), taxonOrder (dbl)
```

Search for hybrid species only


```r
ebirdtaxonomy(cat="hybrid")
```

```
## Source: local data frame [252 x 9]
## 
##    bandingCodes category                                           comName
## 1            NA   hybrid     Spotted x White-faced Whistling-Duck (hybrid)
## 2            NA   hybrid Greater White-fronted x Bar-headed Goose (hybrid)
## 3            NA   hybrid       Greater White-fronted x Snow Goose (hybrid)
## 4          SRGH   hybrid                      Snow x Ross's Goose (hybrid)
## 5            NA   hybrid                       Brant x Snow Goose (hybrid)
## 6            NA   hybrid             Pink-footed x Barnacle Goose (hybrid)
## 7            NA   hybrid   Greater White-fronted x Barnacle Goose (hybrid)
## 8            NA   hybrid                 Graylag x Barnacle Goose (hybrid)
## 9            NA   hybrid                    Snow x Cackling Goose (hybrid)
## 10           NA   hybrid                  Ross's x Cackling Goose (hybrid)
## ..          ...      ...                                               ...
## Variables not shown: comNameCodes (chr), sciName (chr), sciNameCodes
##   (chr), speciesCode (chr), taxonID (chr), taxonOrder (dbl)
```


### Check eBird region

Check if region is valid in eBird database


```r
ebirdregioncheck(loctype = 'counties', loc = 'CA-BC-GV')
```

```
## [1] TRUE
```
