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
## # A tibble: 17 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 amegfi      Americ~ Spinus~ L184~ 325 De~ 2019~       1  42.2 -76.0
##  2 amegfi      Americ~ Spinus~ L501~ Willia~ 2019~       5  42.1 -76.0
##  3 amegfi      Americ~ Spinus~ L154~ Broome~ 2019~       2  42.0 -75.9
##  4 amegfi      Americ~ Spinus~ L229~ Imperi~ 2019~       3  42.1 -76.0
##  5 amegfi      Americ~ Spinus~ L351~ Anson ~ 2019~       4  42.1 -76.1
##  6 amegfi      Americ~ Spinus~ L212~ Chenan~ 2019~       7  42.2 -75.8
##  7 amegfi      Americ~ Spinus~ L520~ US-PA-~ 2019~      21  41.8 -75.8
##  8 amegfi      Americ~ Spinus~ L209~ Aquate~ 2019~       1  42.0 -75.9
##  9 amegfi      Americ~ Spinus~ L465~ US-New~ 2019~       8  42.2 -75.9
## 10 amegfi      Americ~ Spinus~ L275~ "Home " 2019~       6  42.1 -76.0
## 11 amegfi      Americ~ Spinus~ L505~ Boland~ 2019~      15  42.2 -75.9
## 12 amegfi      Americ~ Spinus~ L424~ Aldric~ 2019~       1  42.1 -75.9
## 13 amegfi      Americ~ Spinus~ L814~ Woodbo~ 2019~       5  41.8 -75.9
## 14 amegfi      Americ~ Spinus~ L456~ Karen ~ 2019~       1  42.1 -76.3
## 15 amegfi      Americ~ Spinus~ L197~ esther~ 2019~       6  42.1 -75.9
## 16 amegfi      Americ~ Spinus~ L524~ Victor~ 2019~       1  42.1 -76.0
## 17 amegfi      Americ~ Spinus~ L628~ Spring~ 2019~       2  42.1 -76.1
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
##  1 cangoo      Canada~ Branta~ L109~ Hillcr~ 2019~      20  42.2 -75.9
##  2 gadwal      Gadwall Mareca~ L109~ Hillcr~ 2019~       1  42.2 -75.9
##  3 mallar3     Mallard Anas p~ L109~ Hillcr~ 2019~      90  42.2 -75.9
##  4 ambduc      Americ~ Anas r~ L109~ Hillcr~ 2019~      10  42.2 -75.9
##  5 hoomer      Hooded~ Lophod~ L109~ Hillcr~ 2019~      80  42.2 -75.9
##  6 commer      Common~ Mergus~ L109~ Hillcr~ 2019~     120  42.2 -75.9
##  7 grbher3     Great ~ Ardea ~ L109~ Hillcr~ 2019~       1  42.2 -75.9
##  8 baleag      Bald E~ Haliae~ L109~ Hillcr~ 2019~       1  42.2 -75.9
##  9 rocpig      Rock P~ Columb~ L501~ Willia~ 2019~      40  42.1 -76.0
## 10 moudov      Mourni~ Zenaid~ L501~ Willia~ 2019~       5  42.1 -76.0
## # ... with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>
```


### Recent sightings from location IDs

Search for bird occurrences for in a hotspot using its ID


```r
ebirdregion(loc = 'L99381')
```

```
## # A tibble: 50 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 glagul      Glauco~ Larus ~ L993~ Stewar~ 2019~       1  42.5 -76.5
##  2 cangoo      Canada~ Branta~ L993~ Stewar~ 2019~      NA  42.5 -76.5
##  3 mallar3     Mallard Anas p~ L993~ Stewar~ 2019~      NA  42.5 -76.5
##  4 redhea      Redhead Aythya~ L993~ Stewar~ 2019~      NA  42.5 -76.5
##  5 comgol      Common~ Buceph~ L993~ Stewar~ 2019~      NA  42.5 -76.5
##  6 commer      Common~ Mergus~ L993~ Stewar~ 2019~      NA  42.5 -76.5
##  7 ribgul      Ring-b~ Larus ~ L993~ Stewar~ 2019~      NA  42.5 -76.5
##  8 hergul      Herrin~ Larus ~ L993~ Stewar~ 2019~      NA  42.5 -76.5
##  9 gbbgul      Great ~ Larus ~ L993~ Stewar~ 2019~      NA  42.5 -76.5
## 10 lbbgul      Lesser~ Larus ~ L993~ Stewar~ 2019~       1  42.5 -76.5
## # ... with 40 more rows, and 3 more variables: obsValid <lgl>,
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
## # A tibble: 27 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 cangoo      Canada~ Branta~ L109~ Hillcr~ 2019~      20  42.2 -75.9
##  2 cangoo      Canada~ Branta~ L501~ Willia~ 2019~      27  42.1 -76.0
##  3 cangoo      Canada~ Branta~ L201~ Conflu~ 2019~     200  42.1 -76.3
##  4 cangoo      Canada~ Branta~ L154~ Broome~ 2019~       8  42.0 -75.9
##  5 cangoo      Canada~ Branta~ L346~ Nichol~ 2019~     289  42.1 -76.3
##  6 cangoo      Canada~ Branta~ L282~ Otsini~ 2019~      45  42.1 -75.9
##  7 cangoo      Canada~ Branta~ L351~ Anson ~ 2019~      45  42.1 -76.1
##  8 cangoo      Canada~ Branta~ L212~ Chenan~ 2019~      21  42.2 -75.8
##  9 cangoo      Canada~ Branta~ L209~ Aquate~ 2019~       3  42.0 -75.9
## 10 cangoo      Canada~ Branta~ L186~ Cheri ~ 2019~      24  42.1 -75.9
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
## # A tibble: 33 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 btbwar      Black-~ Setoph~ L842~ 8806 S~ 2019~       1  25.7 -80.4
##  2 btbwar      Black-~ Setoph~ L425~ Spicew~ 2019~       1  25.7 -80.4
##  3 btbwar      Black-~ Setoph~ L835~ My yard 2019~       1  39.9 -74.8
##  4 btbwar      Black-~ Setoph~ L123~ Key La~ 2019~       1  25.1 -80.4
##  5 btbwar      Black-~ Setoph~ L209~ Hall's~ 2019~       1  42.3 -71.1
##  6 btbwar      Black-~ Setoph~ L127~ Greyno~ 2019~       1  25.9 -80.2
##  7 btbwar      Black-~ Setoph~ L127~ Mathes~ 2019~       1  25.7 -80.3
##  8 btbwar      Black-~ Setoph~ L185~ 117 Oa~ 2019~       1  42.5 -71.1
##  9 btbwar      Black-~ Setoph~ L429~ Toni R~ 2019~       1  27.7 -80.4
## 10 btbwar      Black-~ Setoph~ L127~ Key La~ 2019~       1  25.2 -80.4
## # ... with 23 more rows, and 3 more variables: obsValid <lgl>,
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
##  1 ambduc      Americ~ Anas r~ L285~ New Lo~ 2019~       8  41.1 -82.4
##  2 cangoo      Canada~ Branta~ L285~ New Lo~ 2019~      91  41.1 -82.4
##  3 amewig      Americ~ Mareca~ L412~ Hoover~ 2019~       6  40.1 -82.9
##  4 mallar3     Mallard Anas p~ L412~ Hoover~ 2019~      60  40.1 -82.9
##  5 houspa      House ~ Passer~ L412~ Hoover~ 2019~       1  40.1 -82.9
##  6 herthr      Hermit~ Cathar~ L412~ Hoover~ 2019~       1  40.1 -82.9
##  7 grbher3     Great ~ Ardea ~ L412~ Hoover~ 2019~       1  40.1 -82.9
##  8 gadwal      Gadwall Mareca~ L412~ Hoover~ 2019~      10  40.1 -82.9
##  9 buffle      Buffle~ Buceph~ L412~ Hoover~ 2019~       2  40.1 -82.9
## 10 amtspa      Americ~ Spizel~ L412~ Hoover~ 2019~       4  40.1 -82.9
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
##  1 Sample~      33         32          39         102           41     
##  2 Snow G~       0          0           0           0            0     
##  3 Greate~       0          0           0           0            0     
##  4 Cackli~       0          0           0           0            0     
##  5 Canada~       0          0.0312      0.0015      0.0980       0.220 
##  6 Cackli~       0          0           0           0            0     
##  7 Trumpe~       0          0           0           0            0     
##  8 Wood D~       0.152      0.0312      0           0.0196       0.0488
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
## # A tibble: 35,856 x 4
##    comName                                    monthQt  frequency sampleSize
##    <chr>                                      <chr>        <dbl>      <dbl>
##  1 Fulvous Whistling-Duck                     January~ 0              16737
##  2 Emperor Goose                              January~ 0.0015         16737
##  3 Snow Goose                                 January~ 0.0279         16737
##  4 Ross's Goose                               January~ 0              16737
##  5 Snow x Ross's Goose (hybrid)               January~ 0              16737
##  6 Snow/Ross's Goose                          January~ 0              16737
##  7 Swan Goose (Domestic type)                 January~ 0.0000597      16737
##  8 Graylag x Swan Goose (Domestic type) (hyb~ January~ 0              16737
##  9 Greater White-fronted Goose                January~ 0.00759        16737
## 10 Pink-footed Goose                          January~ 0              16737
## # ... with 35,846 more rows
```

Or county


```r
ebirdfreq(loctype = 'counties', loc = 'CA-BC-GV')
```

```
## # A tibble: 24,960 x 4
##    comName                         monthQt   frequency sampleSize
##    <chr>                           <chr>         <dbl>      <dbl>
##  1 Emperor Goose                   January-1   0             5374
##  2 Snow Goose                      January-1   0.0640        5374
##  3 Ross's Goose                    January-1   0             5374
##  4 Snow/Ross's Goose               January-1   0             5374
##  5 Greater White-fronted Goose     January-1   0.00540       5374
##  6 Brant                           January-1   0.0309        5374
##  7 Cackling Goose                  January-1   0.0162        5374
##  8 Canada Goose                    January-1   0.199         5374
##  9 Graylag x Canada Goose (hybrid) January-1   0             5374
## 10 Cackling/Canada Goose           January-1   0.00205       5374
## # ... with 24,950 more rows
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
## # A tibble: 2,638 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 snogoo      Snow G~ Anser ~ L107~ South ~ 2019~       1  42.3 -72.6
##  2 norpin      Northe~ Anas a~ L402~ Flowed~ 2019~       1  42.4 -71.3
##  3 chispa      Chippi~ Spizel~ L246~ Tufts ~ 2019~       1  42.4 -71.1
##  4 doccor      Double~ Phalac~ L198~ Mystic~ 2019~       1  42.4 -71.1
##  5 gwfgoo1     Greate~ Anser ~ L129~ Whirlw~ 2019~       1  41.4 -72.8
##  6 bargol      Barrow~ Buceph~ L410~ Cornfi~ 2019~       1  41.3 -72.4
##  7 lbbgul      Lesser~ Larus ~ L269~ Needha~ 2019~       1  42.3 -71.3
##  8 orcwar      Orange~ Oreoth~ L827~ Madaket 2019~       1  41.3 -70.2
##  9 rinduc      Ring-n~ Aythya~ L718~ Presum~ 2019~       3  43.7 -70.4
## 10 rinduc      Ring-n~ Aythya~ L718~ Presum~ 2019~       3  43.7 -70.4
## # ... with 2,628 more rows, and 3 more variables: obsValid <lgl>,
## #   obsReviewed <lgl>, locationPrivate <lgl>
```

or a region


```r
ebirdnotable(locID = 'US-NY-109')
```

```
## # A tibble: 89 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 norsho      Northe~ Spatul~ L842~ 1048 E~ 2019~       2  42.5 -76.5
##  2 ricgoo1     Cackli~ Branta~ L879~ Monkey~ 2019~       1  42.5 -76.4
##  3 ruckin      Ruby-c~ Regulu~ L879~ Monkey~ 2019~       1  42.5 -76.4
##  4 hoared2     Hoary ~ Acanth~ L693~ Mount ~ 2019~       1  42.5 -76.4
##  5 whcspa      White-~ Zonotr~ L137~ Sapsuc~ 2019~       1  42.5 -76.5
##  6 grycat      Gray C~ Dumete~ L799~ Cornel~ 2019~       1  42.5 -76.5
##  7 evegro      Evenin~ Coccot~ L132~ Fall C~ 2019~       1  42.5 -76.5
##  8 evegro      Evenin~ Coccot~ L842~ 641 Mi~ 2019~       8  42.4 -76.3
##  9 tufduc      Tufted~ Aythya~ L140~ East S~ 2019~       1  42.5 -76.5
## 10 tufduc      Tufted~ Aythya~ L140~ East S~ 2019~       1  42.5 -76.5
## # ... with 79 more rows, and 3 more variables: obsValid <lgl>,
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

### Information on a given hotspot

Obtain detailed information on any valid eBird hotspot


```r
ebirdhotspotinfo("L99381")
```

```
## # A tibble: 1 x 16
##   locId name  latitude longitude countryCode countryName subnational1Name
##   <chr> <chr>    <dbl>     <dbl> <chr>       <chr>       <chr>           
## 1 L993~ Stew~     42.5     -76.5 US          United Sta~ New York        
## # ... with 9 more variables: subNational1Code <chr>,
## #   Subnational2Code <chr>, subnational2Name <chr>, isHotspot <lgl>,
## #   name2 <chr>, latitude2 <dbl>, longitude2 <dbl>,
## #   hierarchical.name <chr>, locId2 <chr>
```

```r
ebirdhotspotinfo("L99381")$hierarchical.name
```

```
## [1] "Stewart Park, Tompkins, New York, US"
```
