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
## # A tibble: 23 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 amegfi      Americ… Spinus… L465… US-New… 2019…       3  42.2 -75.9
##  2 amegfi      Americ… Spinus… L328… PA-SQ-… 2019…       7  41.8 -75.9
##  3 amegfi      Americ… Spinus… L495… Bingha… 2019…       1  42.1 -76.0
##  4 amegfi      Americ… Spinus… L505… Boland… 2019…       3  42.2 -75.9
##  5 amegfi      Americ… Spinus… L351… Anson … 2019…      11  42.1 -76.1
##  6 amegfi      Americ… Spinus… L184… 325 De… 2019…       3  42.2 -76.0
##  7 amegfi      Americ… Spinus… L524… Victor… 2019…       4  42.1 -76.0
##  8 amegfi      Americ… Spinus… L106… IBM CC… 2019…       9  42.1 -76.0
##  9 amegfi      Americ… Spinus… L572… Scott … 2019…       2  42.1 -76.0
## 10 amegfi      Americ… Spinus… L520… US-PA-… 2019…      25  41.8 -75.8
## # … with 13 more rows, and 3 more variables: obsValid <lgl>,
## #   obsReviewed <lgl>, locationPrivate <lgl>
```

Same, but with additional parameter settings, returning only 10 records, including provisional records, and hotspot records. 


```r
ebirdgeo(lat = 42, lng = -76, max = 10, includeProvisional = TRUE, hotspot = TRUE)
```

```
## # A tibble: 10 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 amecro      Americ… Corvus… L495… Bingha… 2019…       1  42.1 -76.0
##  2 cangoo      Canada… Branta… L146… Harold… 2019…       2  42.1 -76.0
##  3 commer      Common… Mergus… L146… Harold… 2019…       3  42.1 -76.0
##  4 baleag      Bald E… Haliae… L146… Harold… 2019…       1  42.1 -76.0
##  5 eursta      Europe… Sturnu… L146… Harold… 2019…      NA  42.1 -76.0
##  6 gadwal      Gadwall Mareca… L505… Boland… 2019…       1  42.2 -75.9
##  7 mallar3     Mallard Anas p… L505… Boland… 2019…      56  42.2 -75.9
##  8 ambduc      Americ… Anas r… L505… Boland… 2019…      10  42.2 -75.9
##  9 redhea      Redhead Aythya… L505… Boland… 2019…       3  42.2 -75.9
## 10 grbher3     Great … Ardea … L505… Boland… 2019…       1  42.2 -75.9
## # … with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>
```


### Recent sightings from location IDs

Search for bird occurrences for in a hotspot using its ID


```r
ebirdregion(loc = 'L99381')
```

```
## # A tibble: 19 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 cangoo      Canada… Branta… L993… Stewar… 2019…      29  42.5 -76.5
##  2 mallar3     Mallard Anas p… L993… Stewar… 2019…       2  42.5 -76.5
##  3 commer      Common… Mergus… L993… Stewar… 2019…      18  42.5 -76.5
##  4 rocpig      Rock P… Columb… L993… Stewar… 2019…       2  42.5 -76.5
##  5 ribgul      Ring-b… Larus … L993… Stewar… 2019…     100  42.5 -76.5
##  6 hergul      Herrin… Larus … L993… Stewar… 2019…     150  42.5 -76.5
##  7 gbbgul      Great … Larus … L993… Stewar… 2019…      50  42.5 -76.5
##  8 merlin      Merlin  Falco … L993… Stewar… 2019…       1  42.5 -76.5
##  9 amecro      Americ… Corvus… L993… Stewar… 2019…       6  42.5 -76.5
## 10 redhea      Redhead Aythya… L993… Stewar… 2019…      NA  42.5 -76.5
## 11 glagul      Glauco… Larus … L993… Stewar… 2019…       1  42.5 -76.5
## 12 eursta      Europe… Sturnu… L993… Stewar… 2019…      NA  42.5 -76.5
## 13 duck1       duck s… Anatin… L993… Stewar… 2019…     100  42.5 -76.5
## 14 larus1      Larus … Larus … L993… Stewar… 2019…     800  42.5 -76.5
## 15 whbnut      White-… Sitta … L993… Stewar… 2019…       2  42.5 -76.5
## 16 brncre      Brown … Certhi… L993… Stewar… 2019…       1  42.5 -76.5
## 17 blujay      Blue J… Cyanoc… L993… Stewar… 2019…       1  42.5 -76.5
## 18 bkcchi      Black-… Poecil… L993… Stewar… 2019…       1  42.5 -76.5
## 19 houspa      House … Passer… L993… Stewar… 2019…       1  42.5 -76.5
## # … with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>
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
##   speciesCode comName sciName locId locName obsDt howMany   lat   lng
##   <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
## 1 ribgul      Ring-b… Larus … L993… Stewar… 2019…     100  42.5 -76.5
## # … with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
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
## # A tibble: 26 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 cangoo      Canada… Branta… L207… Workwa… 2019…       2  42.1 -75.9
##  2 cangoo      Canada… Branta… L439… Port D… 2019…      43  42.1 -75.9
##  3 cangoo      Canada… Branta… L146… Harold… 2019…       2  42.1 -76.0
##  4 cangoo      Canada… Branta… L505… Boland… 2019…       2  42.2 -75.9
##  5 cangoo      Canada… Branta… L189… Hill P… 2019…      26  42.1 -76.0
##  6 cangoo      Canada… Branta… L696… 5127–5… 2019…     100  42.1 -76.3
##  7 cangoo      Canada… Branta… L809… Port D… 2019…      10  42.1 -75.9
##  8 cangoo      Canada… Branta… L186… Cheri … 2019…       2  42.1 -75.9
##  9 cangoo      Canada… Branta… L212… Chenan… 2019…       2  42.2 -75.8
## 10 cangoo      Canada… Branta… L854… route … 2019…      25  42.1 -76.0
## # … with 16 more rows, and 3 more variables: obsValid <lgl>,
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
## # A tibble: 23 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 btbwar      Black-… Setoph… L816… Miccos… 2019…       2  25.7 -80.4
##  2 btbwar      Black-… Setoph… L200… A. D. … 2019…       1  25.7 -80.3
##  3 btbwar      Black-… Setoph… L857… Southe… 2019…       1  25.9 -80.2
##  4 btbwar      Black-… Setoph… L246… Green … 2019…       1  26.5 -80.2
##  5 btbwar      Black-… Setoph… L110… Enchan… 2019…       1  25.9 -80.2
##  6 btbwar      Black-… Setoph… L127… Greyno… 2019…       1  25.9 -80.2
##  7 btbwar      Black-… Setoph… L835… My yard 2019…       1  39.9 -74.8
##  8 btbwar      Black-… Setoph… L823… 433 Fi… 2019…       1  28.2 -80.6
##  9 btbwar      Black-… Setoph… L130… Tall C… 2019…       1  26.3 -80.2
## 10 btbwar      Black-… Setoph… L130… 4115 C… 2019…       1  26.2 -80.1
## # … with 13 more rows, and 3 more variables: obsValid <lgl>,
## #   obsReviewed <lgl>, locationPrivate <lgl>
```

Search by location ID and species name, as well as some additional parameter settings. Note that we use `US-OH` to represent Ohio within the US.


```r
ebirdregion(loc = 'US-OH', max = 10, provisional = TRUE, hotspot = TRUE)
```

```
## # A tibble: 10 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 amecro      Americ… Corvus… L799… Nimisi… 2019…       1  41.0 -81.5
##  2 cangoo      Canada… Branta… L799… Nimisi… 2019…       3  41.0 -81.5
##  3 blujay      Blue J… Cyanoc… L799… Nimisi… 2019…       3  41.0 -81.5
##  4 baleag      Bald E… Haliae… L799… Nimisi… 2019…       2  41.0 -81.5
##  5 amerob      Americ… Turdus… L150… Buckey… 2019…       2  41.1 -81.9
##  6 tuftit      Tufted… Baeolo… L150… Buckey… 2019…       2  41.1 -81.9
##  7 norcar      Northe… Cardin… L150… Buckey… 2019…       4  41.1 -81.9
##  8 dowwoo      Downy … Dryoba… L150… Buckey… 2019…       2  41.1 -81.9
##  9 carwre      Caroli… Thryot… L150… Buckey… 2019…       1  41.1 -81.9
## 10 bkcchi      Black-… Poecil… L150… Buckey… 2019…       3  41.1 -81.9
## # … with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>
```


### Frequency of observations at hotspots or regions

Obtain historical frequencies of bird occurrences at a given hotspot


```r
ebirdfreq(loctype = 'hotspots', loc = 'L196159')
```

```
## # A tibble: 9,168 x 4
##    comName                     monthQt   frequency sampleSize
##    <chr>                       <chr>         <dbl>      <dbl>
##  1 Snow Goose                  January-1     0             33
##  2 Greater White-fronted Goose January-1     0             33
##  3 Cackling Goose              January-1     0             33
##  4 Canada Goose                January-1     0             33
##  5 Cackling/Canada Goose       January-1     0             33
##  6 Trumpeter Swan              January-1     0             33
##  7 Wood Duck                   January-1     0.152         33
##  8 Blue-winged Teal            January-1     0             33
##  9 Cinnamon Teal               January-1     0             33
## 10 Blue-winged/Cinnamon Teal   January-1     0             33
## # … with 9,158 more rows
```

Same, but in wide format (for making bar charts)


```r
ebirdfreq(loctype = 'hotspots', loc = 'L196159', long = FALSE)
```

```
## # A tibble: 192 x 49
##    comName `January-1` `January-2` `January-3` `January-4` `February-1`
##    <chr>         <dbl>       <dbl>       <dbl>       <dbl>        <dbl>
##  1 Sample…      33         32          43         112           47     
##  2 Snow G…       0          0           0           0            0     
##  3 Greate…       0          0           0           0            0     
##  4 Cackli…       0          0           0           0            0     
##  5 Canada…       0          0.0312      0.0015      0.107        0.191 
##  6 Cackli…       0          0           0           0            0     
##  7 Trumpe…       0          0           0           0            0     
##  8 Wood D…       0.152      0.0312      0           0.0179       0.0426
##  9 Blue-w…       0          0           0           0            0     
## 10 Cinnam…       0          0           0           0            0     
## # … with 182 more rows, and 43 more variables: `February-2` <dbl>,
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
## # A tibble: 35,904 x 4
##    comName                                    monthQt  frequency sampleSize
##    <chr>                                      <chr>        <dbl>      <dbl>
##  1 Fulvous Whistling-Duck                     January… 0              16806
##  2 Emperor Goose                              January… 0.0015         16806
##  3 Snow Goose                                 January… 0.0280         16806
##  4 Ross's Goose                               January… 0              16806
##  5 Snow x Ross's Goose (hybrid)               January… 0              16806
##  6 Snow/Ross's Goose                          January… 0              16806
##  7 Swan Goose (Domestic type)                 January… 0.0000595      16806
##  8 Graylag x Swan Goose (Domestic type) (hyb… January… 0              16806
##  9 Greater White-fronted Goose                January… 0.00762        16806
## 10 Pink-footed Goose                          January… 0              16806
## # … with 35,894 more rows
```

Or county


```r
ebirdfreq(loctype = 'counties', loc = 'CA-BC-GV')
```

```
## # A tibble: 25,008 x 4
##    comName                         monthQt   frequency sampleSize
##    <chr>                           <chr>         <dbl>      <dbl>
##  1 Emperor Goose                   January-1   0             5387
##  2 Snow Goose                      January-1   0.0639        5387
##  3 Ross's Goose                    January-1   0             5387
##  4 Snow/Ross's Goose               January-1   0             5387
##  5 Greater White-fronted Goose     January-1   0.00557       5387
##  6 Brant                           January-1   0.0308        5387
##  7 Cackling Goose                  January-1   0.0161        5387
##  8 Canada Goose                    January-1   0.199         5387
##  9 Graylag x Canada Goose (hybrid) January-1   0             5387
## 10 Cackling/Canada Goose           January-1   0.00204       5387
## # … with 24,998 more rows
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
##  1 Canada Goose                        January-1       0           10
##  2 Wood Duck                           January-1       0.4         10
##  3 Northern Shoveler                   January-1       0.8         10
##  4 Gadwall                             January-1       0           10
##  5 Eurasian Wigeon                     January-1       0.4         10
##  6 American Wigeon                     January-1       1           10
##  7 Eurasian x American Wigeon (hybrid) January-1       0           10
##  8 Mallard                             January-1       1           10
##  9 Northern Pintail                    January-1       0           10
## 10 Green-winged Teal                   January-1       0           10
## # … with 3,782 more rows
```


### Recent notable sightings

Search for notable sightings at a given latitude and longitude


```r
ebirdnotable(lat = 42, lng = -70)
```

```
## # A tibble: 1,365 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 norsho      Northe… Spatul… L279… Shawme… 2019…       1  41.8 -70.5
##  2 snogoo      Snow G… Anser … L857… 2–12 B… 2019…       2  41.3 -70.1
##  3 norsho      Northe… Spatul… L279… Shawme… 2019…       1  41.8 -70.5
##  4 evegro      Evenin… Coccot… L597… Gull P… 2019…       1  42.0 -70.0
##  5 evegro      Evenin… Coccot… L357… Dunbac… 2019…      11  42.4 -71.2
##  6 truswa      Trumpe… Cygnus… L716… Milfor… 2019…       1  42.2 -71.5
##  7 pinwar      Pine W… Setoph… L109… Brunsw… 2019…       1  43.9 -70.0
##  8 kineid      King E… Somate… L318… Ocean … 2019…       1  41.3 -72.1
##  9 haiwoo2     Hairy … Dryoba… L811… Freepo… 2019…       1  43.8 -70.1
## 10 lbbgul      Lesser… Larus … L919… Agawam… 2019…       1  40.9 -72.4
## # … with 1,355 more rows, and 3 more variables: obsValid <lgl>,
## #   obsReviewed <lgl>, locationPrivate <lgl>
```

or a region


```r
ebirdnotable(locID = 'US-NY-109')
```

```
## # A tibble: 25 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 cacgoo1     Cackli… Branta… L856… 1034 H… 2019…       1  42.5 -76.5
##  2 evegro      Evenin… Coccot… L137… Sapsuc… 2019…       1  42.5 -76.5
##  3 whcspa      White-… Zonotr… L398… 14## H… 2019…       1  42.5 -76.5
##  4 ruckin      Ruby-c… Regulu… L996… Myers … 2019…       1  42.5 -76.6
##  5 evegro      Evenin… Coccot… L305… Roy H.… 2019…       2  42.4 -76.3
##  6 ruckin      Ruby-c… Regulu… L353… Salt P… 2019…       1  42.5 -76.5
##  7 ruckin      Ruby-c… Regulu… L353… Salt P… 2019…       1  42.5 -76.5
##  8 myrwar      Yellow… Setoph… L136… Ithaca… 2019…       1  42.4 -76.5
##  9 evegro      Evenin… Coccot… L598… Midlin… 2019…      22  42.4 -76.3
## 10 evegro      Evenin… Coccot… L280… 651 Ha… 2019…       4  42.4 -76.3
## # … with 15 more rows, and 3 more variables: obsValid <lgl>,
## #   obsReviewed <lgl>, locationPrivate <lgl>
```


### eBird taxonomy

Returns a data.frame of all species in the eBird taxonomy for the given parameter inputs


```r
ebirdtaxonomy()
```

```
## # A tibble: 16,248 x 14
##    sciName comName speciesCode category taxonOrder bandingCodes
##    <chr>   <chr>   <chr>       <chr>         <dbl> <chr>       
##  1 Struth… Common… ostric2     species           1 <NA>        
##  2 Struth… Somali… ostric3     species           6 <NA>        
##  3 Struth… Common… y00934      slash             7 <NA>        
##  4 Rhea a… Greate… grerhe1     species           8 <NA>        
##  5 Rhea p… Lesser… lesrhe2     species          14 <NA>        
##  6 Rhea p… Lesser… lesrhe4     issf             15 <NA>        
##  7 Rhea p… Lesser… lesrhe3     issf             18 <NA>        
##  8 Nothoc… Tawny-… tabtin1     species          19 <NA>        
##  9 Nothoc… Highla… higtin1     species          20 HITI        
## 10 Nothoc… Highla… higtin2     issf             21 <NA>        
## # … with 16,238 more rows, and 8 more variables: comNameCodes <chr>,
## #   sciNameCodes <chr>, order <chr>, familyComName <chr>,
## #   familySciName <chr>, reportAs <chr>, extinct <lgl>, extinctYear <int>
```

Search for hybrid species only


```r
ebirdtaxonomy(cat = "hybrid")
```

```
## # A tibble: 415 x 11
##    sciName comName speciesCode category taxonOrder bandingCodes
##    <chr>   <chr>   <chr>       <chr>         <dbl> <chr>       
##  1 Dendro… Spotte… x00721      hybrid          219 <NA>        
##  2 Dendro… Black-… x00775      hybrid          224 <NA>        
##  3 Dendro… Black-… x00875      hybrid          226 <NA>        
##  4 Anser … Snow x… sxrgoo1     hybrid          243 SRGH        
##  5 Anser … Grayla… x00776      hybrid          251 <NA>        
##  6 Anser … Bar-he… x00755      hybrid          259 <NA>        
##  7 Anser … Snow x… x00627      hybrid          260 <NA>        
##  8 Anser … Snow G… x00685      hybrid          280 <NA>        
##  9 Anser … Pink-f… x00756      hybrid          282 <NA>        
## 10 Anser … Greate… x00757      hybrid          283 <NA>        
## # … with 405 more rows, and 5 more variables: comNameCodes <chr>,
## #   sciNameCodes <chr>, order <chr>, familyComName <chr>,
## #   familySciName <chr>
```

## Information on a given region or hotspot

Obtain detailed information on any valid eBird region


```r
ebirdregioninfo("CA-BC-GV")
```

```
## # A tibble: 1 x 5
##   region                                     minX  maxX  minY  maxY
##   <chr>                                     <dbl> <dbl> <dbl> <dbl>
## 1 Metro Vancouver, British Columbia, Canada -123. -122.  49.0  49.6
```

or hotspot


```r
ebirdregioninfo("L196159")
```

```
## # A tibble: 1 x 5
##   region                                    minX  maxX  minY  maxY
##   <chr>                                    <dbl> <dbl> <dbl> <dbl>
## 1 Vancouver--Trout Lake (John Hendry Park) -123. -123.  49.2  49.3
```
