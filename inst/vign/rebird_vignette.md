<!--
%\VignetteEngine{knitr::docco_classic}
%\VignetteIndexEntry{rebird vignette}
-->

# Intro to the rebird package

A programmatic interface to the eBird database. Find out more about eBird at [their website](http://ebird.org/home/).

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

The [eBird API server](https://documenter.getpostman.com/view/664302/ebird-api-20/2HTbHW) 
has been updated and thus there are a couple major changes in the way `rebird` works.
API requests to eBird now require users to provide an API key, which is linked to your 
eBird user account. 
You can pass it to the 'key' argument in `rebird` functions, but we highly recommend
storing it as an environment variable called EBIRD_KEY in your .Renviron file.
If you don't have a key, you can obtain one from <https://ebird.org/api/keygen>.

You can keep your .Renviron file in your global R home directory (`R.home()`), your user's home
directory (`Sys.getenv("HOME")`), or your current working directory (`getwd()`). Remember
that .Renviron is loaded once when you start R, so if you add your API key to the file you will
have to restart your R session. See <https://csgillespie.github.io/efficientR/r-startup.html> for
more information on R's startup files.

Furthermore, functions now use species codes, rather than scientific names, for species-specific requests.
We've made the switch easy by providing the `species_code` function, which converts a scientific name to
its species code:


```r
species_code('sula variegata')
```

```
## Peruvian Booby (Sula variegata): perboo1
```

```
## [1] "perboo1"
```

The `species_code` function can be called within other `rebird` functions, or the species code 
can be specified directly.

### Sightings at location determined by latitude/longitude

Search for bird occurrences by latitude and longitude point


```r
ebirdgeo(species = species_code('spinus tristis'), lat = 42, lng = -76)
```

```
## American Goldfinch (Spinus tristis): amegfi
```

```
## # A tibble: 45 x 12
##    speciesCode comName  sciName  locId locName   obsDt howMany   lat   lng
##    <chr>       <chr>    <chr>    <chr> <chr>     <chr>   <int> <dbl> <dbl>
##  1 amegfi      America… Spinus … L447… Binghamt… 2018…       2  42.1 -76.0
##  2 amegfi      America… Spinus … L207… Workwalk  2018…       1  42.1 -75.9
##  3 amegfi      America… Spinus … L495… Binghamt… 2018…       1  42.1 -76.0
##  4 amegfi      America… Spinus … L527… R Tee Go… 2018…       1  42.2 -75.9
##  5 amegfi      America… Spinus … L795… US-New Y… 2018…       7  42.1 -76.0
##  6 amegfi      America… Spinus … L978… Murphys … 2018…       5  42.1 -76.0
##  7 amegfi      America… Spinus … L209… Aquaterr… 2018…       9  42.0 -75.9
##  8 amegfi      America… Spinus … L320… Hillcres… 2018…       1  42.2 -75.9
##  9 amegfi      America… Spinus … L285… Camp Sus… 2018…       1  42.0 -75.9
## 10 amegfi      America… Spinus … L519… IBM Glen… 2018…       3  42.1 -76.0
## # ... with 35 more rows, and 3 more variables: obsValid <lgl>,
## #   obsReviewed <lgl>, locationPrivate <lgl>
```

Same, but with additional parameter settings, returning only 10 records, including provisional records, and hotspot records. 


```r
ebirdgeo(lat = 42, lng = -76, max = 10, includeProvisional = TRUE, hotspot = TRUE)
```

```
## # A tibble: 10 x 12
##    speciesCode comName  sciName  locId  locName  obsDt howMany   lat   lng
##    <chr>       <chr>    <chr>    <chr>  <chr>    <chr>   <int> <dbl> <dbl>
##  1 cangoo      Canada … Branta … L1869… Cheri A… 2018…       4  42.1 -75.9
##  2 mallar3     Mallard  Anas pl… L1869… Cheri A… 2018…      20  42.1 -75.9
##  3 rocpig      Rock Pi… Columba… L1869… Cheri A… 2018…       3  42.1 -75.9
##  4 doccor      Double-… Phalacr… L1869… Cheri A… 2018…       5  42.1 -75.9
##  5 grbher3     Great B… Ardea h… L1869… Cheri A… 2018…       1  42.1 -75.9
##  6 greegr      Great E… Ardea a… L1869… Cheri A… 2018…       5  42.1 -75.9
##  7 blujay      Blue Jay Cyanoci… L1869… Cheri A… 2018…       1  42.1 -75.9
##  8 amecro      America… Corvus … L1869… Cheri A… 2018…       1  42.1 -75.9
##  9 grycat      Gray Ca… Dumetel… L1869… Cheri A… 2018…       1  42.1 -75.9
## 10 normoc      Norther… Mimus p… L1869… Cheri A… 2018…       2  42.1 -75.9
## # ... with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>
```


### Recent sightings from location IDs

Search for bird occurrences for in a hotspot using its ID


```r
ebirdregion(loc = 'L99381')
```

```
## # A tibble: 64 x 12
##    speciesCode comName   sciName   locId locName obsDt howMany   lat   lng
##    <chr>       <chr>     <chr>     <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 wooduc      Wood Duck Aix spon… L993… Stewar… 2018…       4  42.5 -76.5
##  2 mallar3     Mallard   Anas pla… L993… Stewar… 2018…      16  42.5 -76.5
##  3 ambduc      American… Anas rub… L993… Stewar… 2018…       1  42.5 -76.5
##  4 rocpig      Rock Pig… Columba … L993… Stewar… 2018…       4  42.5 -76.5
##  5 ribgul      Ring-bil… Larus de… L993… Stewar… 2018…     110  42.5 -76.5
##  6 hergul      Herring … Larus ar… L993… Stewar… 2018…       1  42.5 -76.5
##  7 lbbgul      Lesser B… Larus fu… L993… Stewar… 2018…       1  42.5 -76.5
##  8 gbbgul      Great Bl… Larus ma… L993… Stewar… 2018…       5  42.5 -76.5
##  9 doccor      Double-c… Phalacro… L993… Stewar… 2018…     118  42.5 -76.5
## 10 grnher      Green He… Butoride… L993… Stewar… 2018…       1  42.5 -76.5
## # ... with 54 more rows, and 3 more variables: obsValid <lgl>,
## #   obsReviewed <lgl>, locationPrivate <lgl>
```

Search by location ID and species name, as well as some additional parameter settings 


```r
ebirdregion(loc = 'L99381', species = species_code('larus delawarensis'), 
         max = 10, provisional = TRUE, hotspot = TRUE)
```

```
## Ring-billed Gull (Larus delawarensis): ribgul
```

```
## # A tibble: 1 x 12
##   speciesCode comName   sciName   locId locName obsDt  howMany   lat   lng
##   <chr>       <chr>     <chr>     <chr> <chr>   <chr>    <int> <dbl> <dbl>
## 1 ribgul      Ring-bil… Larus de… L993… Stewar… 2018-…     110  42.5 -76.5
## # ... with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>
```


## Nearest observations of a species

Search for a species' occurrences near a given latitude and longitude


```r
nearestobs(species_code('branta canadensis'), 42, -76)
```

```
## Canada Goose (Branta canadensis): cangoo
```

```
## # A tibble: 27 x 12
##    speciesCode comName  sciName  locId locName   obsDt howMany   lat   lng
##    <chr>       <chr>    <chr>    <chr> <chr>     <chr>   <int> <dbl> <dbl>
##  1 cangoo      Canada … Branta … L186… Cheri A.… 2018…       4  42.1 -75.9
##  2 cangoo      Canada … Branta … L207… Workwalk  2018…      26  42.1 -75.9
##  3 cangoo      Canada … Branta … L287… Vestal R… 2018…      49  42.1 -76.0
##  4 cangoo      Canada … Branta … L527… R Tee Go… 2018…      53  42.2 -75.9
##  5 cangoo      Canada … Branta … L728… State Ga… 2018…      23  41.9 -75.7
##  6 cangoo      Canada … Branta … L504… Rt. 12A … 2018…      65  42.2 -75.9
##  7 cangoo      Canada … Branta … L468… "Boland … 2018…      12  42.2 -75.9
##  8 cangoo      Canada … Branta … L285… Camp Sus… 2018…       2  42.0 -75.9
##  9 cangoo      Canada … Branta … L447… Binghamt… 2018…       2  42.1 -76.0
## 10 cangoo      Canada … Branta … L501… William … 2018…      50  42.1 -76.0
## # ... with 17 more rows, and 3 more variables: obsValid <lgl>,
## #   obsReviewed <lgl>, locationPrivate <lgl>
```


### Recent observations at a region

Search for bird occurrences by region and species name


```r
ebirdregion(loc = 'US', species = species_code('Setophaga caerulescens'))
```

```
## Black-throated Blue Warbler (Setophaga caerulescens): btbwar
```

```
## # A tibble: 1,041 x 12
##    speciesCode comName  sciName  locId  locName  obsDt howMany   lat   lng
##    <chr>       <chr>    <chr>    <chr>  <chr>    <chr>   <int> <dbl> <dbl>
##  1 btbwar      Black-t… Setopha… L3572… Cornell… 2018…       2  42.4 -76.5
##  2 btbwar      Black-t… Setopha… L7962… Pisgah … 2018…       1  36.2 -81.7
##  3 btbwar      Black-t… Setopha… L2785… Kiwanis… 2018…       1  27.0 -82.1
##  4 btbwar      Black-t… Setopha… L1109… Enchant… 2018…       3  25.9 -80.2
##  5 btbwar      Black-t… Setopha… L7814… Wissahi… 2018…       2  40.1 -75.2
##  6 btbwar      Black-t… Setopha… L5987… Codding… 2018…       2  42.3 -76.4
##  7 btbwar      Black-t… Setopha… L4023… Home - … 2018…       1  40.2 -75.4
##  8 btbwar      Black-t… Setopha… L5862… Indrio … 2018…       1  27.5 -80.4
##  9 btbwar      Black-t… Setopha… L1301… Ashland… 2018…       2  39.8 -75.7
## 10 btbwar      Black-t… Setopha… L1877… Pinecra… 2018…       1  27.3 -82.5
## # ... with 1,031 more rows, and 3 more variables: obsValid <lgl>,
## #   obsReviewed <lgl>, locationPrivate <lgl>
```

Search by location ID and species name, as well as some additional parameter settings. Note that we use `US-OH` to represent Ohio within the US.


```r
ebirdregion(loc = 'US-OH', max = 10, provisional = TRUE, hotspot = TRUE)
```

```
## # A tibble: 10 x 12
##    speciesCode comName  sciName  locId locName   obsDt howMany   lat   lng
##    <chr>       <chr>    <chr>    <chr> <chr>     <chr>   <int> <dbl> <dbl>
##  1 belkin1     Belted … Megacer… L416… Big Cree… 2018…       1  41.4 -81.8
##  2 norcar      Norther… Cardina… L416… Big Cree… 2018…       2  41.4 -81.8
##  3 greegr      Great E… Ardea a… L416… Big Cree… 2018…       6  41.4 -81.8
##  4 grbher3     Great B… Ardea h… L416… Big Cree… 2018…       3  41.4 -81.8
##  5 cangoo      Canada … Branta … L416… Big Cree… 2018…      54  41.4 -81.8
##  6 blujay      Blue Jay Cyanoci… L416… Big Cree… 2018…       2  41.4 -81.8
##  7 amecro      America… Corvus … L500… Hueston … 2018…       1  39.6 -84.8
##  8 carwre      Carolin… Thryoth… L500… Hueston … 2018…       3  39.6 -84.8
##  9 bongul      Bonapar… Chroico… L500… Hueston … 2018…       1  39.6 -84.8
## 10 barswa      Barn Sw… Hirundo… L500… Hueston … 2018…       1  39.6 -84.8
## # ... with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>
```


### Frequency of observations at hotspots or regions

Obtain historical frequencies of bird occurrences at a given hotspot


```r
ebirdfreq(loctype = 'hotspots', loc = 'L196159')
```

```
## # A tibble: 9,072 x 4
##    comName                     monthQt   frequency sampleSize
##    <chr>                       <chr>         <dbl>      <dbl>
##  1 Snow Goose                  January-1     0.           27.
##  2 Greater White-fronted Goose January-1     0.           27.
##  3 Cackling Goose              January-1     0.           27.
##  4 Canada Goose                January-1     0.           27.
##  5 Cackling/Canada Goose       January-1     0.           27.
##  6 Trumpeter Swan              January-1     0.           27.
##  7 Wood Duck                   January-1     0.185        27.
##  8 Blue-winged Teal            January-1     0.           27.
##  9 Cinnamon Teal               January-1     0.           27.
## 10 Blue-winged/Cinnamon Teal   January-1     0.           27.
## # ... with 9,062 more rows
```

Same, but in wide format (for making bar charts)


```r
ebirdfreq(loctype = 'hotspots', loc = 'L196159', long = FALSE)
```

```
## # A tibble: 190 x 49
##    comName    `January-1` `January-2` `January-3` `January-4` `February-1`
##    <chr>            <dbl>       <dbl>       <dbl>       <dbl>        <dbl>
##  1 Sample Si…      27.0       27.0       39.0        102.          41.0   
##  2 Snow Goose       0.         0.         0.           0.           0.    
##  3 Greater W…       0.         0.         0.           0.           0.    
##  4 Cackling …       0.         0.         0.           0.           0.    
##  5 Canada Go…       0.         0.         0.00150      0.0980       0.220 
##  6 Cackling/…       0.         0.         0.           0.           0.    
##  7 Trumpeter…       0.         0.         0.           0.           0.    
##  8 Wood Duck        0.185      0.0370     0.           0.0196       0.0488
##  9 Blue-wing…       0.         0.         0.           0.           0.    
## 10 Cinnamon …       0.         0.         0.           0.           0.    
## # ... with 180 more rows, and 43 more variables: `February-2` <dbl>,
## #   `February-3` <dbl>, `February-4` <dbl>, `March-1` <dbl>,
## #   `March-2` <dbl>, `March-3` <dbl>, `March-4` <dbl>, `April-1` <dbl>,
## #   `April-2` <dbl>, `April-3` <dbl>, `April-4` <dbl>, `May-1` <dbl>,
## #   `May-2` <dbl>, `May-3` <dbl>, `May-4` <dbl>, `June-1` <dbl>,
## #   `June-2` <dbl>, `June-3` <dbl>, `June-4` <dbl>, `July-1` <dbl>,
## #   `July-2` <dbl>, `July-3` <dbl>, `July-4` <dbl>, `August-1` <dbl>,
## #   `August-2` <dbl>, `August-3` <dbl>, `August-4` <dbl>,
## #   `September-1` <dbl>, `September-2` <dbl>, `September-3` <dbl>,
## #   `September-4` <dbl>, `October-1` <dbl>, `October-2` <dbl>,
## #   `October-3` <dbl>, `October-4` <dbl>, `November-1` <dbl>,
## #   `November-2` <dbl>, `November-3` <dbl>, `November-4` <dbl>,
## #   `December-1` <dbl>, `December-2` <dbl>, `December-3` <dbl>,
## #   `December-4` <dbl>
```

Obtain frequency data for a given state


```r
ebirdfreq(loctype = 'states', loc = 'CA-BC')
```

```
## # A tibble: 35,424 x 4
##    comName                                   monthQt  frequency sampleSize
##    <chr>                                     <chr>        <dbl>      <dbl>
##  1 Fulvous Whistling-Duck                    January… 0.            14197.
##  2 Emperor Goose                             January… 0.00150       14197.
##  3 Snow Goose                                January… 0.0279        14197.
##  4 Ross's Goose                              January… 0.            14197.
##  5 Snow x Ross's Goose (hybrid)              January… 0.            14197.
##  6 Snow/Ross's Goose                         January… 0.            14197.
##  7 Swan Goose (Domestic type)                January… 0.0000704     14197.
##  8 Graylag x Swan Goose (Domestic type) (hy… January… 0.            14197.
##  9 Greater White-fronted Goose               January… 0.00768       14197.
## 10 Pink-footed Goose                         January… 0.            14197.
## # ... with 35,414 more rows
```

Or county


```r
ebirdfreq(loctype = 'counties', loc = 'CA-BC-GV')
```

```
## # A tibble: 24,624 x 4
##    comName                         monthQt   frequency sampleSize
##    <chr>                           <chr>         <dbl>      <dbl>
##  1 Emperor Goose                   January-1   0.           4714.
##  2 Snow Goose                      January-1   0.0653       4714.
##  3 Ross's Goose                    January-1   0.           4714.
##  4 Snow/Ross's Goose               January-1   0.           4714.
##  5 Greater White-fronted Goose     January-1   0.00530      4714.
##  6 Brant                           January-1   0.0255       4714.
##  7 Cackling Goose                  January-1   0.0119       4714.
##  8 Canada Goose                    January-1   0.200        4714.
##  9 Graylag x Canada Goose (hybrid) January-1   0.           4714.
## 10 Cackling/Canada Goose           January-1   0.00170      4714.
## # ... with 24,614 more rows
```

Obtain frequency data within a range of years and months


```r
ebirdfreq(loctype = 'hotspots', loc = 'L196159', startyear = 2010,
          endyear = 2014, startmonth = 1, endmonth = 3)
```

```
## # A tibble: 3,792 x 4
##    comName                             monthQt   frequency sampleSize
##    <chr>                               <chr>         <dbl>      <dbl>
##  1 Canada Goose                        January-1     0.           10.
##  2 Wood Duck                           January-1     0.400        10.
##  3 Northern Shoveler                   January-1     0.800        10.
##  4 Gadwall                             January-1     0.           10.
##  5 Eurasian Wigeon                     January-1     0.400        10.
##  6 American Wigeon                     January-1     1.00         10.
##  7 Eurasian x American Wigeon (hybrid) January-1     0.           10.
##  8 Mallard                             January-1     1.00         10.
##  9 Northern Pintail                    January-1     0.           10.
## 10 Green-winged Teal                   January-1     0.           10.
## # ... with 3,782 more rows
```


### Recent notable sightings

Search for notable sightings at a given latitude and longitude


```r
ebirdnotable(lat = 42, lng = -70)
```

```
## # A tibble: 802 x 12
##    speciesCode comName  sciName  locId locName   obsDt howMany   lat   lng
##    <chr>       <chr>    <chr>    <chr> <chr>     <chr>   <int> <dbl> <dbl>
##  1 rthhum      Ruby-th… Archilo… L584… US-New H… 2018…       1  42.9 -71.0
##  2 ameoys      America… Haemato… L765… Basket I… 2018…       2  43.5 -70.4
##  3 rthhum      Ruby-th… Archilo… L497… stakeout… 2018…       1  42.3 -71.6
##  4 ycnher      Yellow-… Nyctana… L382… Lake War… 2018…       1  42.4 -72.6
##  5 ovenbi1     Ovenbird Seiurus… L168… Brenton … 2018…       1  41.5 -71.4
##  6 hoowar      Hooded … Setopha… L514… 000  31 … 2018…       1  43.3 -71.0
##  7 ycnher      Yellow-… Nyctana… L796… Mt. Warn… 2018…       1  42.4 -72.6
##  8 ycnher      Yellow-… Nyctana… L796… Lake War… 2018…       1  42.4 -72.6
##  9 ycnher      Yellow-… Nyctana… L796… Lake War… 2018…       1  42.4 -72.6
## 10 sora        Sora     Porzana… L420… Tiogue L… 2018…       1  41.7 -71.6
## # ... with 792 more rows, and 3 more variables: obsValid <lgl>,
## #   obsReviewed <lgl>, locationPrivate <lgl>
```

or a region


```r
ebirdnotable(locID = 'US-NY-109')
```

```
## # A tibble: 71 x 12
##    speciesCode comName   sciName  locId locName  obsDt howMany   lat   lng
##    <chr>       <chr>     <chr>    <chr> <chr>    <chr>   <int> <dbl> <dbl>
##  1 buggna      Blue-gra… Poliopt… L177… Sapsuck… 2018…       1  42.5 -76.4
##  2 comgal1     Common G… Gallinu… L518… Hile Sc… 2018…       1  42.5 -76.4
##  3 buggna1     Blue-gra… Poliopt… L124… Sapsuck… 2018…       1  42.5 -76.5
##  4 buggna      Blue-gra… Poliopt… L515… Sapsuck… 2018…       1  42.5 -76.5
##  5 comnig      Common N… Chordei… L518… Hile Sc… 2018…       1  42.5 -76.4
##  6 blkvul      Black Vu… Coragyp… L398… 14## Ha… 2018…       1  42.5 -76.5
##  7 blkvul      Black Vu… Coragyp… L286… Sapsuck… 2018…       1  42.5 -76.5
##  8 blkvul      Black Vu… Coragyp… L212… Stevens… 2018…       1  42.4 -76.4
##  9 sora        Sora      Porzana… L594… Ridgewa… 2018…       1  42.3 -76.4
## 10 conwar      Connecti… Opororn… L446… Durland… 2018…       1  42.4 -76.4
## # ... with 61 more rows, and 3 more variables: obsValid <lgl>,
## #   obsReviewed <lgl>, locationPrivate <lgl>
```


### eBird taxonomy

Returns a data.frame of all species in the eBird taxonomy for the given parameter inputs


```r
ebirdtaxonomy()
```

```
## # A tibble: 16,248 x 14
##    sciName        comName     speciesCode category taxonOrder bandingCodes
##    <chr>          <chr>       <chr>       <chr>         <dbl> <chr>       
##  1 Struthio came… Common Ost… ostric2     species          1. <NA>        
##  2 Struthio moly… Somali Ost… ostric3     species          6. <NA>        
##  3 Struthio came… Common/Som… y00934      slash            7. <NA>        
##  4 Rhea americana Greater Rh… grerhe1     species          8. <NA>        
##  5 Rhea pennata   Lesser Rhea lesrhe2     species         14. <NA>        
##  6 Rhea pennata … Lesser Rhe… lesrhe4     issf            15. <NA>        
##  7 Rhea pennata … Lesser Rhe… lesrhe3     issf            18. <NA>        
##  8 Nothocercus j… Tawny-brea… tabtin1     species         19. <NA>        
##  9 Nothocercus b… Highland T… higtin1     species         20. HITI        
## 10 Nothocercus b… Highland T… higtin2     issf            21. <NA>        
## # ... with 16,238 more rows, and 8 more variables: comNameCodes <chr>,
## #   sciNameCodes <chr>, order <chr>, familyComName <chr>,
## #   familySciName <chr>, reportAs <chr>, extinct <lgl>, extinctYear <int>
```

Search for hybrid species only


```r
ebirdtaxonomy(cat = "hybrid")
```

```
## # A tibble: 415 x 11
##    sciName      comName       speciesCode category taxonOrder bandingCodes
##    <chr>        <chr>         <chr>       <chr>         <dbl> <chr>       
##  1 Dendrocygna… Spotted x Wh… x00721      hybrid         219. <NA>        
##  2 Dendrocygna… Black-bellie… x00775      hybrid         224. <NA>        
##  3 Dendrocygna… Black-bellie… x00875      hybrid         226. <NA>        
##  4 Anser caeru… Snow x Ross'… sxrgoo1     hybrid         243. SRGH        
##  5 Anser anser… Graylag x Sw… x00776      hybrid         251. <NA>        
##  6 Anser indic… Bar-headed x… x00755      hybrid         259. <NA>        
##  7 Anser caeru… Snow x Great… x00627      hybrid         260. <NA>        
##  8 Anser caeru… Snow Goose x… x00685      hybrid         280. <NA>        
##  9 Anser brach… Pink-footed … x00756      hybrid         282. <NA>        
## 10 Anser albif… Greater Whit… x00757      hybrid         283. <NA>        
## # ... with 405 more rows, and 5 more variables: comNameCodes <chr>,
## #   sciNameCodes <chr>, order <chr>, familyComName <chr>,
## #   familySciName <chr>
```

### Check eBird region

Obtain information on any region 


```r
ebirdregioninfo(loc = 'CA-BC-GV')
```

```
## # A tibble: 1 x 5
##   region                                     minX  maxX  minY  maxY
##   <chr>                                     <dbl> <dbl> <dbl> <dbl>
## 1 Metro Vancouver, British Columbia, Canada -123. -122.  49.0  49.6
```
