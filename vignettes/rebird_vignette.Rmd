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
## # A tibble: 13 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 amegfi      Americ~ Spinus~ L275~ "Home " 2019~       4  42.1 -76.0
##  2 amegfi      Americ~ Spinus~ L978~ Murphy~ 2019~       1  42.1 -76.0
##  3 amegfi      Americ~ Spinus~ L884~ 5126–5~ 2019~       1  42.1 -76.3
##  4 amegfi      Americ~ Spinus~ L465~ US-New~ 2019~       3  42.2 -75.9
##  5 amegfi      Americ~ Spinus~ L620~ Univer~ 2019~       1  42.1 -76.0
##  6 amegfi      Americ~ Spinus~ L320~ Hillcr~ 2019~       2  42.2 -75.9
##  7 amegfi      Americ~ Spinus~ L229~ Imperi~ 2019~       1  42.1 -76.0
##  8 amegfi      Americ~ Spinus~ L197~ esther~ 2019~       4  42.1 -75.9
##  9 amegfi      Americ~ Spinus~ L447~ Bingha~ 2019~       1  42.1 -76.0
## 10 amegfi      Americ~ Spinus~ L207~ Workwa~ 2019~       2  42.1 -75.9
## 11 amegfi      Americ~ Spinus~ L870~ 325 De~ 2019~       1  42.2 -76.0
## 12 amegfi      Americ~ Spinus~ L147~ Quaker~ 2019~       6  42.0 -75.9
## 13 amegfi      Americ~ Spinus~ L866~ Bingha~ 2019~       3  42.1 -75.9
## # ... with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>
```

Same, but with additional parameter settings, returning only 10 records, including provisional records, and hotspot records. 


```r
ebirdgeo(lat = 42, lng = -76, max = 10, includeProvisional = TRUE, hotspot = TRUE)
```

```
## # A tibble: 10 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 cangoo      Canada~ Branta~ L505~ Boland~ 2019~       1  42.2 -75.9
##  2 mallar3     Mallard Anas p~ L505~ Boland~ 2019~       4  42.2 -75.9
##  3 ribgul      Ring-b~ Larus ~ L505~ Boland~ 2019~       3  42.2 -75.9
##  4 baleag      Bald E~ Haliae~ L505~ Boland~ 2019~       2  42.2 -75.9
##  5 rethaw      Red-ta~ Buteo ~ L505~ Boland~ 2019~       1  42.2 -75.9
##  6 blujay      Blue J~ Cyanoc~ L505~ Boland~ 2019~       1  42.2 -75.9
##  7 amecro      Americ~ Corvus~ L505~ Boland~ 2019~       5  42.2 -75.9
##  8 houfin      House ~ Haemor~ L505~ Boland~ 2019~       1  42.2 -75.9
##  9 amtspa      Americ~ Spizel~ L505~ Boland~ 2019~       1  42.2 -75.9
## 10 rewbla      Red-wi~ Agelai~ L505~ Boland~ 2019~       5  42.2 -75.9
## # ... with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>
```


### Recent sightings from location IDs

Search for bird occurrences for in a hotspot using its ID


```r
ebirdregion(loc = 'L99381')
```

```
## # A tibble: 54 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 cangoo      Canada~ Branta~ L993~ Stewar~ 2019~     200  42.5 -76.5
##  2 mallar3     Mallard Anas p~ L993~ Stewar~ 2019~      15  42.5 -76.5
##  3 ambduc      Americ~ Anas r~ L993~ Stewar~ 2019~       2  42.5 -76.5
##  4 redhea      Redhead Aythya~ L993~ Stewar~ 2019~      30  42.5 -76.5
##  5 comgol      Common~ Buceph~ L993~ Stewar~ 2019~       1  42.5 -76.5
##  6 commer      Common~ Mergus~ L993~ Stewar~ 2019~      10  42.5 -76.5
##  7 moudov      Mourni~ Zenaid~ L993~ Stewar~ 2019~       1  42.5 -76.5
##  8 y00475      Americ~ Fulica~ L993~ Stewar~ 2019~       3  42.5 -76.5
##  9 killde      Killde~ Charad~ L993~ Stewar~ 2019~       1  42.5 -76.5
## 10 ribgul      Ring-b~ Larus ~ L993~ Stewar~ 2019~      NA  42.5 -76.5
## # ... with 44 more rows, and 3 more variables: obsValid <lgl>,
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
## # A tibble: 1 x 11
##   speciesCode comName sciName locId locName obsDt   lat   lng obsValid
##   <chr>       <chr>   <chr>   <chr> <chr>   <chr> <dbl> <dbl> <lgl>   
## 1 ribgul      Ring-b~ Larus ~ L993~ Stewar~ 2019~  42.5 -76.5 TRUE    
## # ... with 2 more variables: obsReviewed <lgl>, locationPrivate <lgl>
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
## # A tibble: 46 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 cangoo      Canada~ Branta~ L505~ Boland~ 2019~       1  42.2 -75.9
##  2 cangoo      Canada~ Branta~ L271~ Flemin~ 2019~      92  42.2 -76.2
##  3 cangoo      Canada~ Branta~ L884~ Rowing~ 2019~      55  42.1 -76.2
##  4 cangoo      Canada~ Branta~ L201~ Conflu~ 2019~      16  42.1 -76.3
##  5 cangoo      Canada~ Branta~ L275~ "Home " 2019~     343  42.1 -76.0
##  6 cangoo      Canada~ Branta~ L212~ Chenan~ 2019~      33  42.2 -75.8
##  7 cangoo      Canada~ Branta~ L146~ Harold~ 2019~     625  42.1 -76.0
##  8 cangoo      Canada~ Branta~ L255~ Wall S~ 2019~     150  42.1 -75.9
##  9 cangoo      Canada~ Branta~ L468~ "Bolan~ 2019~    2200  42.2 -75.9
## 10 cangoo      Canada~ Branta~ L978~ Murphy~ 2019~      50  42.1 -76.0
## # ... with 36 more rows, and 3 more variables: obsValid <lgl>,
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
## # A tibble: 32 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 btbwar      Black-~ Setoph~ L871~ Schenl~ 2019~       1  25.7 -80.3
##  2 btbwar      Black-~ Setoph~ L871~ Coral ~ 2019~       1  25.7 -80.3
##  3 btbwar      Black-~ Setoph~ L835~ My yard 2019~       1  39.9 -74.8
##  4 btbwar      Black-~ Setoph~ L844~ Kristi~ 2019~       1  39.9 -74.8
##  5 btbwar      Black-~ Setoph~ L123~ Evergl~ 2019~       1  25.4 -80.6
##  6 btbwar      Black-~ Setoph~ L129~ Lantan~ 2019~       1  26.6 -80.0
##  7 btbwar      Black-~ Setoph~ L200~ A. D. ~ 2019~       1  25.7 -80.3
##  8 btbwar      Black-~ Setoph~ L110~ Enchan~ 2019~       1  25.9 -80.2
##  9 btbwar      Black-~ Setoph~ L707~ Fakaha~ 2019~       1  26.1 -81.4
## 10 btbwar      Black-~ Setoph~ L127~ Greyno~ 2019~       1  25.9 -80.2
## # ... with 22 more rows, and 3 more variables: obsValid <lgl>,
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
##  1 buffle      Buffle~ Buceph~ L216~ Pekin ~ 2019~       2  41.5 -81.2
##  2 rewbla      Red-wi~ Agelai~ L216~ Pekin ~ 2019~       5  41.5 -81.2
##  3 norsho      Northe~ Spatul~ L216~ Pekin ~ 2019~       2  41.5 -81.2
##  4 norcar      Northe~ Cardin~ L216~ Pekin ~ 2019~       1  41.5 -81.2
##  5 mallar3     Mallard Anas p~ L216~ Pekin ~ 2019~       6  41.5 -81.2
##  6 cangoo      Canada~ Branta~ L216~ Pekin ~ 2019~      40  41.5 -81.2
##  7 amecro      Americ~ Corvus~ L846~ Clear ~ 2019~       3  40.7 -82.6
##  8 rinduc      Ring-n~ Aythya~ L846~ Clear ~ 2019~       1  40.7 -82.6
##  9 rebmer      Red-br~ Mergus~ L846~ Clear ~ 2019~       2  40.7 -82.6
## 10 doccor      Double~ Phalac~ L846~ Clear ~ 2019~       1  40.7 -82.6
## # ... with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>
```


### Frequency of observations at hotspots or regions

Obtain historical frequencies of bird occurrences at a given hotspot


```r
ebirdfreq(loctype = 'hotspots', loc = 'L196159')
```

```
## # A tibble: 9,216 x 4
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
## # ... with 9,206 more rows
```

Same, but in wide format (for making bar charts)


```r
ebirdfreq(loctype = 'hotspots', loc = 'L196159', long = FALSE)
```

```
## # A tibble: 193 x 49
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
## # ... with 183 more rows, and 43 more variables: `February-2` <dbl>,
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
##  1 Fulvous Whistling-Duck                     January~ 0              16832
##  2 Emperor Goose                              January~ 0.0015         16832
##  3 Snow Goose                                 January~ 0.0280         16832
##  4 Ross's Goose                               January~ 0              16832
##  5 Snow x Ross's Goose (hybrid)               January~ 0              16832
##  6 Snow/Ross's Goose                          January~ 0              16832
##  7 Swan Goose (Domestic type)                 January~ 0.0000594      16832
##  8 Graylag x Swan Goose (Domestic type) (hyb~ January~ 0              16832
##  9 Greater White-fronted Goose                January~ 0.00760        16832
## 10 Pink-footed Goose                          January~ 0              16832
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
##  1 Emperor Goose                   January-1   0             5396
##  2 Snow Goose                      January-1   0.0639        5396
##  3 Ross's Goose                    January-1   0             5396
##  4 Snow/Ross's Goose               January-1   0             5396
##  5 Greater White-fronted Goose     January-1   0.00556       5396
##  6 Brant                           January-1   0.0308        5396
##  7 Cackling Goose                  January-1   0.0163        5396
##  8 Canada Goose                    January-1   0.199         5396
##  9 Graylag x Canada Goose (hybrid) January-1   0             5396
## 10 Cackling/Canada Goose           January-1   0.00204       5396
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
## # A tibble: 636 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 hoared      Hoary ~ Acanth~ L360~ Canco ~ 2019~       1  43.7 -70.3
##  2 rosgoo      Ross's~ Anser ~ L885~ Eastwo~ 2019~       1  42.3 -72.7
##  3 eurwig      Eurasi~ Mareca~ L827~ Boyd's~ 2019~       2  41.6 -71.2
##  4 evegro      Evenin~ Coccot~ L691~ Home, ~ 2019~      25  42.7 -72.2
##  5 canvas      Canvas~ Aythya~ L527~ Great ~ 2019~       1  43.1 -70.9
##  6 retloo      Red-th~ Gavia ~ L276~ Adams ~ 2019~       1  43.1 -70.9
##  7 pingro      Pine G~ Pinico~ L884~ (43.84~ 2019~       7  43.8 -70.1
##  8 canvas      Canvas~ Aythya~ L885~ Osprey~ 2019~       1  43.1 -70.9
##  9 redhea      Redhead Aythya~ L885~ Osprey~ 2019~       2  43.1 -70.9
## 10 pingro      Pine G~ Pinico~ L811~ Freepo~ 2019~       9  43.8 -70.1
## # ... with 626 more rows, and 3 more variables: obsValid <lgl>,
## #   obsReviewed <lgl>, locationPrivate <lgl>
```

or a region


```r
ebirdnotable(locID = 'US-NY-109')
```

```
## # A tibble: 67 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 gwfgoo2     Greate~ Anser ~ L784~ ** Mon~ 2019~       4  42.5 -76.4
##  2 gwfgoo2     Greate~ Anser ~ L879~ Monkey~ 2019~       4  42.5 -76.4
##  3 yerwar      Yellow~ Setoph~ L113~ Stewar~ 2019~       1  42.5 -76.5
##  4 osprey      Osprey  Pandio~ L205~ NY:TOM~ 2019~       1  42.5 -76.4
##  5 evegro      Evenin~ Coccot~ L123~ Boyer ~ 2019~      75  42.3 -76.3
##  6 thagul      Icelan~ Larus ~ L993~ Stewar~ 2019~       1  42.5 -76.5
##  7 rosgoo      Ross's~ Anser ~ L431~ Cornel~ 2019~       1  42.4 -76.5
##  8 rosgoo      Ross's~ Anser ~ L356~ Cornel~ 2019~       1  42.4 -76.5
##  9 rosgoo      Ross's~ Anser ~ L356~ Cornel~ 2019~       1  42.4 -76.5
## 10 gwfgoo      Greate~ Anser ~ L212~ Caswel~ 2019~       3  42.5 -76.4
## # ... with 57 more rows, and 3 more variables: obsValid <lgl>,
## #   obsReviewed <lgl>, locationPrivate <lgl>
```

### Historic Observations

Search for historic observations on a date at a region 


```r
ebirdhistorical(loc = 'US-VA-003', date='2019-02-14',max=10)
```

```
## # A tibble: 10 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 cangoo      Canada~ Branta~ L139~ Lickin~ 2019~      30  38.1 -78.7
##  2 mallar3     Mallard Anas p~ L139~ Lickin~ 2019~       5  38.1 -78.7
##  3 gnwtea      Green-~ Anas c~ L139~ Lickin~ 2019~       8  38.1 -78.7
##  4 killde      Killde~ Charad~ L139~ Lickin~ 2019~       1  38.1 -78.7
##  5 baleag      Bald E~ Haliae~ L139~ Lickin~ 2019~       1  38.1 -78.7
##  6 belkin1     Belted~ Megace~ L139~ Lickin~ 2019~       1  38.1 -78.7
##  7 carwre      Caroli~ Thryot~ L139~ Lickin~ 2019~       1  38.1 -78.7
##  8 whtspa      White-~ Zonotr~ L139~ Lickin~ 2019~       2  38.1 -78.7
##  9 norcar      Northe~ Cardin~ L139~ Lickin~ 2019~       1  38.1 -78.7
## 10 canvas      Canvas~ Aythya~ L331~ Montic~ 2019~      19  38.0 -78.5
## # ... with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>
```

or set of hotspots


```r
ebirdhistorical(loc = 'L196159', date='2019-02-14', fieldSet='full')
```

```
## # A tibble: 14 x 27
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 annhum      Anna's~ Calypt~ L196~ Vancou~ 2019~       4  49.3 -123.
##  2 ribgul      Ring-b~ Larus ~ L196~ Vancou~ 2019~       4  49.3 -123.
##  3 glwgul      Glauco~ Larus ~ L196~ Vancou~ 2019~      29  49.3 -123.
##  4 norcro      Northw~ Corvus~ L196~ Vancou~ 2019~     100  49.3 -123.
##  5 bkcchi      Black-~ Poecil~ L196~ Vancou~ 2019~      16  49.3 -123.
##  6 bushti      Bushtit Psaltr~ L196~ Vancou~ 2019~      20  49.3 -123.
##  7 pacwre1     Pacifi~ Troglo~ L196~ Vancou~ 2019~       1  49.3 -123.
##  8 houfin      House ~ Haemor~ L196~ Vancou~ 2019~       2  49.3 -123.
##  9 purfin      Purple~ Haemor~ L196~ Vancou~ 2019~       3  49.3 -123.
## 10 amegfi      Americ~ Spinus~ L196~ Vancou~ 2019~      15  49.3 -123.
## 11 daejun      Dark-e~ Junco ~ L196~ Vancou~ 2019~      37  49.3 -123.
## 12 sonspa      Song S~ Melosp~ L196~ Vancou~ 2019~      12  49.3 -123.
## 13 spotow      Spotte~ Pipilo~ L196~ Vancou~ 2019~       1  49.3 -123.
## 14 rewbla      Red-wi~ Agelai~ L196~ Vancou~ 2019~       6  49.3 -123.
## # ... with 18 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>, subnational2Code <chr>, subnational2Name <chr>,
## #   subnational1Code <chr>, subnational1Name <chr>, countryCode <chr>,
## #   countryName <chr>, userDisplayName <chr>, subId <chr>, obsId <chr>,
## #   checklistId <chr>, presenceNoted <lgl>, hasComments <lgl>,
## #   hasRichMedia <lgl>, lastName <chr>, firstName <chr>
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
## # A tibble: 1 x 16
##   locId name  latitude longitude countryCode countryName subnational1Name
##   <chr> <chr>    <dbl>     <dbl> <chr>       <chr>       <chr>           
## 1 L196~ Vanc~     49.3     -123. CA          Canada      British Columbia
## # ... with 9 more variables: subnational1Code <chr>,
## #   subnational2Code <chr>, subnational2Name <chr>, isHotspot <lgl>,
## #   locName <chr>, lat <dbl>, lng <dbl>, hierarchicalName <chr>,
## #   locID <chr>
```
