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
## # A tibble: 21 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 amegfi      Americ~ Spinus~ L425~ Melody~ 2019~       3  42.1 -75.8
##  2 amegfi      Americ~ Spinus~ L845~ 6106 P~ 2019~       8  41.9 -75.7
##  3 amegfi      Americ~ Spinus~ L861~ Maine,~ 2019~      18  42.2 -76.1
##  4 amegfi      Americ~ Spinus~ L282~ Otsini~ 2019~       3  42.1 -75.9
##  5 amegfi      Americ~ Spinus~ L338~ East N~ 2019~      13  42.0 -76.3
##  6 amegfi      Americ~ Spinus~ L184~ 325 De~ 2019~       1  42.2 -76.0
##  7 amegfi      Americ~ Spinus~ L505~ Boland~ 2019~       2  42.2 -75.9
##  8 amegfi      Americ~ Spinus~ L545~ 3393 V~ 2019~       1  41.9 -76.0
##  9 amegfi      Americ~ Spinus~ L193~ yard    2019~       1  42.1 -76.0
## 10 amegfi      Americ~ Spinus~ L465~ US-New~ 2019~       3  42.2 -75.9
## # ... with 11 more rows, and 3 more variables: obsValid <lgl>,
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
##  1 cangoo      Canada~ Branta~ L186~ Cheri ~ 2019~       5  42.1 -75.9
##  2 mallar3     Mallard Anas p~ L186~ Cheri ~ 2019~       6  42.1 -75.9
##  3 buffle      Buffle~ Buceph~ L186~ Cheri ~ 2019~       2  42.1 -75.9
##  4 comgol      Common~ Buceph~ L186~ Cheri ~ 2019~       7  42.1 -75.9
##  5 hoomer      Hooded~ Lophod~ L186~ Cheri ~ 2019~       4  42.1 -75.9
##  6 commer      Common~ Mergus~ L186~ Cheri ~ 2019~       6  42.1 -75.9
##  7 rocpig      Rock P~ Columb~ L186~ Cheri ~ 2019~     100  42.1 -75.9
##  8 ribgul      Ring-b~ Larus ~ L186~ Cheri ~ 2019~       2  42.1 -75.9
##  9 hergul      Herrin~ Larus ~ L186~ Cheri ~ 2019~       2  42.1 -75.9
## 10 coohaw      Cooper~ Accipi~ L186~ Cheri ~ 2019~       1  42.1 -75.9
## # ... with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>
```


### Recent sightings from location IDs

Search for bird occurrences for in a hotspot using its ID


```r
ebirdregion(loc = 'L99381')
```

```
## # A tibble: 20 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 cangoo      Canada~ Branta~ L993~ Stewar~ 2019~     145  42.5 -76.5
##  2 mallar3     Mallard Anas p~ L993~ Stewar~ 2019~       4  42.5 -76.5
##  3 commer      Common~ Mergus~ L993~ Stewar~ 2019~      22  42.5 -76.5
##  4 ribgul      Ring-b~ Larus ~ L993~ Stewar~ 2019~      15  42.5 -76.5
##  5 hergul      Herrin~ Larus ~ L993~ Stewar~ 2019~     200  42.5 -76.5
##  6 gbbgul      Great ~ Larus ~ L993~ Stewar~ 2019~      55  42.5 -76.5
##  7 amecro      Americ~ Corvus~ L993~ Stewar~ 2019~       3  42.5 -76.5
##  8 gresca      Greate~ Aythya~ L993~ Stewar~ 2019~       2  42.5 -76.5
##  9 aythya1     Aythya~ Aythya~ L993~ Stewar~ 2019~      30  42.5 -76.5
## 10 comgol      Common~ Buceph~ L993~ Stewar~ 2019~      10  42.5 -76.5
## 11 rocpig      Rock P~ Columb~ L993~ Stewar~ 2019~       2  42.5 -76.5
## 12 lbbgul      Lesser~ Larus ~ L993~ Stewar~ 2019~       2  42.5 -76.5
## 13 eursta      Europe~ Sturnu~ L993~ Stewar~ 2019~      10  42.5 -76.5
## 14 larus       gull s~ Larina~ L993~ Stewar~ 2019~     100  42.5 -76.5
## 15 norcar      Northe~ Cardin~ L993~ Stewar~ 2019~       2  42.5 -76.5
## 16 glagul      Glauco~ Larus ~ L993~ Stewar~ 2019~       1  42.5 -76.5
## 17 whbnut      White-~ Sitta ~ L993~ Stewar~ 2019~       1  42.5 -76.5
## 18 houfin      House ~ Haemor~ L993~ Stewar~ 2019~       2  42.5 -76.5
## 19 merlin      Merlin  Falco ~ L993~ Stewar~ 2019~       1  42.5 -76.5
## 20 redhea      Redhead Aythya~ L993~ Stewar~ 2019~      NA  42.5 -76.5
## # ... with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
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
## 1 ribgul      Ring-b~ Larus ~ L993~ Stewar~ 2019~      15  42.5 -76.5
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
## # A tibble: 26 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 cangoo      Canada~ Branta~ L186~ Cheri ~ 2019~       5  42.1 -75.9
##  2 cangoo      Canada~ Branta~ L854~ route ~ 2019~       3  42.1 -76.0
##  3 cangoo      Canada~ Branta~ L282~ Otsini~ 2019~      19  42.1 -75.9
##  4 cangoo      Canada~ Branta~ L505~ Boland~ 2019~       5  42.2 -75.9
##  5 cangoo      Canada~ Branta~ L625~ 4701 V~ 2019~      25  42.1 -76.0
##  6 cangoo      Canada~ Branta~ L166~ Chugnu~ 2019~       6  42.1 -76.0
##  7 cangoo      Canada~ Branta~ L339~ Chenan~ 2019~       4  42.1 -75.9
##  8 cangoo      Canada~ Branta~ L288~ Kmart ~ 2019~       4  42.1 -75.9
##  9 cangoo      Canada~ Branta~ L212~ Chenan~ 2019~      14  42.2 -75.8
## 10 cangoo      Canada~ Branta~ L809~ Port D~ 2019~      24  42.1 -75.9
## # ... with 16 more rows, and 3 more variables: obsValid <lgl>,
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
##  1 btbwar      Black-~ Setoph~ L246~ Green ~ 2019~       1  26.5 -80.2
##  2 btbwar      Black-~ Setoph~ L200~ A. D. ~ 2019~       1  25.7 -80.3
##  3 btbwar      Black-~ Setoph~ L127~ Castel~ 2019~       1  25.6 -80.5
##  4 btbwar      Black-~ Setoph~ L127~ Greyno~ 2019~       1  25.9 -80.2
##  5 btbwar      Black-~ Setoph~ L454~ Gulfst~ 2019~       1  25.2 -80.4
##  6 btbwar      Black-~ Setoph~ L844~ Kristi~ 2019~       1  39.9 -74.8
##  7 btbwar      Black-~ Setoph~ L209~ Arch C~ 2019~       1  25.9 -80.2
##  8 btbwar      Black-~ Setoph~ L330~ Orchid~ 2019~       1  26.2 -80.3
##  9 btbwar      Black-~ Setoph~ L835~ My yard 2019~       1  39.9 -74.8
## 10 btbwar      Black-~ Setoph~ L110~ Enchan~ 2019~       1  25.9 -80.2
## # ... with 13 more rows, and 3 more variables: obsValid <lgl>,
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
##  1 eucdov      Eurasi~ Strept~ L308~ Celina~ 2019~       2  40.5 -84.6
##  2 houspa      House ~ Passer~ L308~ Celina~ 2019~      50  40.5 -84.6
##  3 amewig      Americ~ Mareca~ L247~ Castal~ 2019~      14  41.4 -82.8
##  4 mallar3     Mallard Anas p~ L247~ Castal~ 2019~      30  41.4 -82.8
##  5 lessca      Lesser~ Aythya~ L247~ Castal~ 2019~       5  41.4 -82.8
##  6 gadwal      Gadwall Mareca~ L247~ Castal~ 2019~      24  41.4 -82.8
##  7 canvas      Canvas~ Aythya~ L247~ Castal~ 2019~       1  41.4 -82.8
##  8 cangoo      Canada~ Branta~ L247~ Castal~ 2019~      50  41.4 -82.8
##  9 buffle      Buffle~ Buceph~ L247~ Castal~ 2019~       2  41.4 -82.8
## 10 belkin1     Belted~ Megace~ L247~ Castal~ 2019~       1  41.4 -82.8
## # ... with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
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
## # ... with 9,158 more rows
```

Same, but in wide format (for making bar charts)


```r
ebirdfreq(loctype = 'hotspots', loc = 'L196159', long = FALSE)
```

```
## # A tibble: 192 x 49
##    comName `January-1` `January-2` `January-3` `January-4` `February-1`
##    <chr>         <dbl>       <dbl>       <dbl>       <dbl>        <dbl>
##  1 Sample~      33         32          43         113           47     
##  2 Snow G~       0          0           0           0            0     
##  3 Greate~       0          0           0           0            0     
##  4 Cackli~       0          0           0           0            0     
##  5 Canada~       0          0.0312      0.0015      0.106        0.191 
##  6 Cackli~       0          0           0           0            0     
##  7 Trumpe~       0          0           0           0            0     
##  8 Wood D~       0.152      0.0312      0           0.0177       0.0426
##  9 Blue-w~       0          0           0           0            0     
## 10 Cinnam~       0          0           0           0            0     
## # ... with 182 more rows, and 43 more variables: `February-2` <dbl>,
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
##  1 Fulvous Whistling-Duck                     January~ 0              16822
##  2 Emperor Goose                              January~ 0.0015         16822
##  3 Snow Goose                                 January~ 0.0281         16822
##  4 Ross's Goose                               January~ 0              16822
##  5 Snow x Ross's Goose (hybrid)               January~ 0              16822
##  6 Snow/Ross's Goose                          January~ 0              16822
##  7 Swan Goose (Domestic type)                 January~ 0.0000594      16822
##  8 Graylag x Swan Goose (Domestic type) (hyb~ January~ 0              16822
##  9 Greater White-fronted Goose                January~ 0.00761        16822
## 10 Pink-footed Goose                          January~ 0              16822
## # ... with 35,894 more rows
```

Or county


```r
ebirdfreq(loctype = 'counties', loc = 'CA-BC-GV')
```

```
## # A tibble: 25,008 x 4
##    comName                         monthQt   frequency sampleSize
##    <chr>                           <chr>         <dbl>      <dbl>
##  1 Emperor Goose                   January-1   0             5389
##  2 Snow Goose                      January-1   0.0640        5389
##  3 Ross's Goose                    January-1   0             5389
##  4 Snow/Ross's Goose               January-1   0             5389
##  5 Greater White-fronted Goose     January-1   0.00557       5389
##  6 Brant                           January-1   0.0308        5389
##  7 Cackling Goose                  January-1   0.0163        5389
##  8 Canada Goose                    January-1   0.199         5389
##  9 Graylag x Canada Goose (hybrid) January-1   0             5389
## 10 Cackling/Canada Goose           January-1   0.00204       5389
## # ... with 24,998 more rows
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
## # ... with 3,782 more rows
```


### Recent notable sightings

Search for notable sightings at a given latitude and longitude


```r
ebirdnotable(lat = 42, lng = -70)
```

```
## # A tibble: 1,093 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 fiespa      Field ~ Spizel~ L862~ 372–47~ 2019~       1  42.4 -72.5
##  2 gwfgoo      Greate~ Anser ~ L109~ Northw~ 2019~       1  41.9 -72.7
##  3 whcspa      White-~ Zonotr~ L611~ Blair ~ 2019~       1  42.4 -71.2
##  4 thbmur      Thick-~ Uria l~ L468~ Seal R~ 2019~       1  43.0 -70.7
##  5 blkvul      Black ~ Coragy~ L862~ Blacks~ 2019~       2  42.0 -71.5
##  6 redkno      Red Kn~ Calidr~ L862~ Hammon~ 2019~       1  41.3 -72.5
##  7 redkno      Red Kn~ Calidr~ L862~ Hammon~ 2019~       1  41.3 -72.5
##  8 eurwig      Eurasi~ Mareca~ L249~ River ~ 2019~       1  43.4 -70.5
##  9 eurwig      Eurasi~ Mareca~ L249~ River ~ 2019~       1  43.4 -70.5
## 10 tunswa      Tundra~ Cygnus~ L115~ Wether~ 2019~       3  41.7 -72.6
## # ... with 1,083 more rows, and 3 more variables: obsValid <lgl>,
## #   obsReviewed <lgl>, locationPrivate <lgl>
```

or a region


```r
ebirdnotable(locID = 'US-NY-109')
```

```
## # A tibble: 20 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 whcspa      White-~ Zonotr~ L650~ 190 Ha~ 2019~       1  42.5 -76.6
##  2 ruckin      Ruby-c~ Regulu~ L353~ Salt P~ 2019~       1  42.5 -76.5
##  3 evegro      Evenin~ Coccot~ L598~ Midlin~ 2019~       9  42.4 -76.3
##  4 thagul      Icelan~ Larus ~ L140~ East S~ 2019~       1  42.5 -76.5
##  5 thagul      Icelan~ Larus ~ L140~ East S~ 2019~       1  42.5 -76.5
##  6 wooduc      Wood D~ Aix sp~ L213~ Ithaca~ 2019~       2  42.4 -76.5
##  7 evegro      Evenin~ Coccot~ L598~ Midlin~ 2019~      12  42.4 -76.3
##  8 yebsap      Yellow~ Sphyra~ L101~ Sapsuc~ 2019~       1  42.5 -76.5
##  9 evegro      Evenin~ Coccot~ L280~ 651 Ha~ 2019~      15  42.4 -76.3
## 10 whcspa      White-~ Zonotr~ L276~ Simsbu~ 2019~       1  42.5 -76.5
## 11 evegro      Evenin~ Coccot~ L598~ Midlin~ 2019~      11  42.4 -76.3
## 12 evegro      Evenin~ Coccot~ L598~ Midlin~ 2019~      25  42.4 -76.3
## 13 myrwar      Yellow~ Setoph~ L136~ Ithaca~ 2019~       1  42.4 -76.5
## 14 myrwar      Yellow~ Setoph~ L136~ Ithaca~ 2019~       1  42.4 -76.5
## 15 myrwar      Yellow~ Setoph~ L136~ Ithaca~ 2019~       1  42.4 -76.5
## 16 cacgoo1     Cackli~ Branta~ L856~ 1034 H~ 2019~       1  42.5 -76.5
## 17 evegro      Evenin~ Coccot~ L137~ Sapsuc~ 2019~       1  42.5 -76.5
## 18 whcspa      White-~ Zonotr~ L398~ 14## H~ 2019~       1  42.5 -76.5
## 19 ruckin      Ruby-c~ Regulu~ L996~ Myers ~ 2019~       1  42.5 -76.6
## 20 evegro      Evenin~ Coccot~ L305~ Roy H.~ 2019~       2  42.4 -76.3
## # ... with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>
```

### Historic Observations

Search for historic observations on a date at a region 


```r
ebirdhistoricobs(loc = 'US-VA-003', date='2019-02-14',max=10)
```

```
## Error in ebirdhistoricobs(loc = "US-VA-003", date = "2019-02-14", max = 10): could not find function "ebirdhistoricobs"
```

or set of hotspots


```r
ebirdhistoricobs(loc = 'L196159', date='2019-02-14', fieldSet='full')
```

```
## Error in ebirdhistoricobs(loc = "L196159", date = "2019-02-14", fieldSet = "full"): could not find function "ebirdhistoricobs"
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
##  1 Struth~ Common~ ostric2     species           1 <NA>        
##  2 Struth~ Somali~ ostric3     species           6 <NA>        
##  3 Struth~ Common~ y00934      slash             7 <NA>        
##  4 Rhea a~ Greate~ grerhe1     species           8 <NA>        
##  5 Rhea p~ Lesser~ lesrhe2     species          14 <NA>        
##  6 Rhea p~ Lesser~ lesrhe4     issf             15 <NA>        
##  7 Rhea p~ Lesser~ lesrhe3     issf             18 <NA>        
##  8 Nothoc~ Tawny-~ tabtin1     species          19 <NA>        
##  9 Nothoc~ Highla~ higtin1     species          20 HITI        
## 10 Nothoc~ Highla~ higtin2     issf             21 <NA>        
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
##    sciName comName speciesCode category taxonOrder bandingCodes
##    <chr>   <chr>   <chr>       <chr>         <dbl> <chr>       
##  1 Dendro~ Spotte~ x00721      hybrid          219 <NA>        
##  2 Dendro~ Black-~ x00775      hybrid          224 <NA>        
##  3 Dendro~ Black-~ x00875      hybrid          226 <NA>        
##  4 Anser ~ Snow x~ sxrgoo1     hybrid          243 SRGH        
##  5 Anser ~ Grayla~ x00776      hybrid          251 <NA>        
##  6 Anser ~ Bar-he~ x00755      hybrid          259 <NA>        
##  7 Anser ~ Snow x~ x00627      hybrid          260 <NA>        
##  8 Anser ~ Snow G~ x00685      hybrid          280 <NA>        
##  9 Anser ~ Pink-f~ x00756      hybrid          282 <NA>        
## 10 Anser ~ Greate~ x00757      hybrid          283 <NA>        
## # ... with 405 more rows, and 5 more variables: comNameCodes <chr>,
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
