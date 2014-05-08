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
library("devtools")
install_github("ropensci/rebird")
```

Then load the package into the R sesssion


```r
library("rebird")
```

## Usage

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

Same, but with additional parameter settings, returning only 10 records, including provisional records, and hotspot records. 


```r
out1 <- ebirdgeo(lat = 42, lng = -76, max = 10, includeProvisional = TRUE, hotspot = TRUE)
head(out1)
```

```
##                 comName howMany   lat lng   locID             locName
## 1        Yellow Warbler       8 42.11 -76 L274662 River Rd. (Endwell)
## 2 Yellow-rumped Warbler       6 42.11 -76 L274662 River Rd. (Endwell)
## 3 Yellow-throated Vireo       1 42.11 -76 L274662 River Rd. (Endwell)
## 4    American Goldfinch       4 42.11 -76 L274662 River Rd. (Endwell)
## 5     American Redstart       3 42.11 -76 L274662 River Rd. (Endwell)
## 6        American Robin       1 42.11 -76 L274662 River Rd. (Endwell)
##   locationPrivate            obsDt obsReviewed obsValid
## 1           FALSE 2014-05-08 15:52       FALSE     TRUE
## 2           FALSE 2014-05-08 15:52       FALSE     TRUE
## 3           FALSE 2014-05-08 15:52       FALSE     TRUE
## 4           FALSE 2014-05-08 15:52       FALSE     TRUE
## 5           FALSE 2014-05-08 15:52       FALSE     TRUE
## 6           FALSE 2014-05-08 15:52       FALSE     TRUE
##               sciName
## 1  Setophaga petechia
## 2  Setophaga coronata
## 3    Vireo flavifrons
## 4      Spinus tristis
## 5 Setophaga ruticilla
## 6  Turdus migratorius
```

```r
nrow(out1)
```

```
## [1] 10
```


### Recent sightings frm location IDs

Search for bird occurrences for two locations by their IDs 


```r
out2 <- ebirdloc(locID = c('L99381','L99382'))
head(out2)
```

```
##                comName howMany   lat    lng  locID      locName
## 1       Warbling Vireo       1 42.46 -76.51 L99381 Stewart Park
## 2         Palm Warbler       4 42.46 -76.51 L99381 Stewart Park
## 3         Canada Goose      20 42.46 -76.51 L99381 Stewart Park
## 4              Mallard       4 42.46 -76.51 L99381 Stewart Park
## 5 Greater/Lesser Scaup       3 42.46 -76.51 L99381 Stewart Park
## 6     Common Merganser       1 42.46 -76.51 L99381 Stewart Park
##   locationPrivate            obsDt obsReviewed obsValid
## 1           FALSE 2014-05-07 19:05       FALSE     TRUE
## 2           FALSE 2014-05-07 19:05       FALSE     TRUE
## 3           FALSE 2014-05-06 19:50       FALSE     TRUE
## 4           FALSE 2014-05-06 19:50       FALSE     TRUE
## 5           FALSE 2014-05-06 19:50       FALSE     TRUE
## 6           FALSE 2014-05-06 19:50       FALSE     TRUE
##                 sciName
## 1          Vireo gilvus
## 2    Setophaga palmarum
## 3     Branta canadensis
## 4    Anas platyrhynchos
## 5 Aythya marila/affinis
## 6      Mergus merganser
```

Search by location ID and species name, as well as some additional parameter settings 


```r
ebirdloc(locID = 'L99381', species = 'larus delawarensis', max = 10, provisional = TRUE, hotspot=TRUE)
```

```
##            comName howMany   lat    lng  locID      locName
## 1 Ring-billed Gull      25 42.46 -76.51 L99381 Stewart Park
##   locationPrivate            obsDt obsReviewed obsValid            sciName
## 1           FALSE 2014-05-06 19:50       FALSE     TRUE Larus delawarensis
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

Search by location ID and species name, as well as some additional parameter settings. Note that we use `US-OH` to represent Ohio within the US. [See possible region values](https://confluence.cornell.edu/display/CLOISAPI/eBird-1.1-RegionCodeReference).


```r
ebirdregion(region = 'US-OH', max = 10, provisional = TRUE, hotspot = TRUE)
```

```
##                      comName howMany  lat    lng   locID
## 1             American Robin       1 39.8 -83.88 L619562
## 2         Carolina Chickadee      NA 39.8 -83.88 L619562
## 3              Carolina Wren       1 39.8 -83.88 L619562
## 4                 House Wren       1 39.8 -83.88 L619562
## 5      Louisiana Waterthrush       1 39.8 -83.88 L619562
## 6    White-breasted Nuthatch       2 39.8 -83.88 L619562
## 7     Red-bellied Woodpecker       1 39.8 -83.88 L619562
## 8             Red-eyed Vireo       2 39.8 -83.88 L619562
## 9  Ruby-throated Hummingbird       1 39.8 -83.88 L619562
## 10           Scarlet Tanager       1 39.8 -83.88 L619562
##                locName locationPrivate            obsDt obsReviewed
## 1  Glen Helen Preserve           FALSE 2014-05-08 16:00       FALSE
## 2  Glen Helen Preserve           FALSE 2014-05-08 16:00       FALSE
## 3  Glen Helen Preserve           FALSE 2014-05-08 16:00       FALSE
## 4  Glen Helen Preserve           FALSE 2014-05-08 16:00       FALSE
## 5  Glen Helen Preserve           FALSE 2014-05-08 16:00       FALSE
## 6  Glen Helen Preserve           FALSE 2014-05-08 16:00       FALSE
## 7  Glen Helen Preserve           FALSE 2014-05-08 16:00       FALSE
## 8  Glen Helen Preserve           FALSE 2014-05-08 16:00       FALSE
## 9  Glen Helen Preserve           FALSE 2014-05-08 16:00       FALSE
## 10 Glen Helen Preserve           FALSE 2014-05-08 16:00       FALSE
##    obsValid                  sciName
## 1      TRUE       Turdus migratorius
## 2      TRUE     Poecile carolinensis
## 3      TRUE Thryothorus ludovicianus
## 4      TRUE        Troglodytes aedon
## 5      TRUE       Parkesia motacilla
## 6      TRUE       Sitta carolinensis
## 7      TRUE     Melanerpes carolinus
## 8      TRUE          Vireo olivaceus
## 9      TRUE     Archilochus colubris
## 10     TRUE         Piranga olivacea
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


### Recent notable sightings

Search for notable sightings at a given latitude and longitude


```r
out4 <- ebirdnotable(lat = 42, lng = -70)
head(out4)
```

```
##                  comName howMany   lat    lng    locID
## 1    Boat-tailed Grackle       1 41.26 -72.55  L298379
## 2 Semipalmated Sandpiper       3 41.68 -70.11  L516715
## 3            Common Tern      25 42.88 -70.81  L461272
## 4           Iceland Gull       1 42.88 -70.81  L461272
## 5      Northern Wheatear       1 43.56 -70.36  L448189
## 6     Pectoral Sandpiper       1 41.64 -70.85 L1112937
##                          locName locationPrivate            obsDt
## 1           Hammonasset Beach SP           FALSE 2014-05-08 17:16
## 2    Bells Neck Road, W. Harwich            TRUE 2014-05-08 16:15
## 3                 Seabrook Beach           FALSE 2014-05-08 15:40
## 4                 Seabrook Beach           FALSE 2014-05-08 15:40
## 5 Scarborough Marsh--Eastern Rd.           FALSE 2014-05-08 14:00
## 6                Shaws Cove Road            TRUE 2014-05-08 13:00
##   obsReviewed obsValid            sciName
## 1       FALSE    FALSE    Quiscalus major
## 2       FALSE    FALSE   Calidris pusilla
## 3       FALSE    FALSE     Sterna hirundo
## 4       FALSE    FALSE   Larus glaucoides
## 5       FALSE    FALSE  Oenanthe oenanthe
## 6       FALSE    FALSE Calidris melanotos
```


### eBird taxonomy

Returns a data.frame of all species in the eBird taxonomy for the given parameter inputs


```r
out5 <- ebirdtaxonomy()
head(out5)
```

```
##              comName                    sciName  taxonID
## 1            Ostrich           Struthio camelus TC000001
## 2       Greater Rhea             Rhea americana TC000004
## 3        Lesser Rhea               Rhea pennata TC000005
## 4 Southern Cassowary        Casuarius casuarius TC000008
## 5    Dwarf Cassowary         Casuarius bennetti TC000009
## 6 Northern Cassowary Casuarius unappendiculatus TC000010
```

Search for hybrid species only


```r
out6 <- ebirdtaxonomy(cat="hybrid")
head(out6)
```

```
##                                         comName
## 1 Spotted x White-faced Whistling-Duck (hybrid)
## 2   Greater White-fronted x Snow Goose (hybrid)
## 3                  Snow x Ross's Goose (hybrid)
## 4                   Brant x Snow Goose (hybrid)
## 5             Graylag x Barnacle Goose (hybrid)
## 6                Snow x Cackling Goose (hybrid)
##                                 sciName  taxonID
## 1         Dendrocygna guttata x viduata TC013397
## 2   Anser albifrons x Chen caerulescens TC000095
## 3            Chen caerulescens x rossii TC000106
## 4   Branta bernicla x Chen caerulescens TC013017
## 5        Anser anser x Branta leucopsis TC012915
## 6 Chen caerulescens x Branta hutchinsii TC013042
```
