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

The [eBird API server](https://documenter.getpostman.com/view/664302/S1ENwy59?version=latest) 
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
## # A tibble: 26 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 amegfi      Americ… Spinus… L100… Bare V… 2019…       7  41.8 -75.9
##  2 amegfi      Americ… Spinus… L447… Bingha… 2019…       6  42.1 -76.0
##  3 amegfi      Americ… Spinus… L275… "Home " 2019…       1  42.1 -76.0
##  4 amegfi      Americ… Spinus… L505… Boland… 2019…       1  42.2 -75.9
##  5 amegfi      Americ… Spinus… L351… Anson … 2019…      25  42.1 -76.1
##  6 amegfi      Americ… Spinus… L524… Victor… 2019…       3  42.1 -76.0
##  7 amegfi      Americ… Spinus… L846… 31 Pul… 2019…       2  42.2 -76.2
##  8 amegfi      Americ… Spinus… L217… Vestal  2019…      11  42.1 -76.0
##  9 amegfi      Americ… Spinus… L211… Tri-Ci… 2019…       2  42.1 -76.1
## 10 amegfi      Americ… Spinus… L166… Chugnu… 2019…      NA  42.1 -76.0
## # … with 16 more rows, and 3 more variables: obsValid <lgl>,
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
##  1 cangoo      Canada… Branta… L147… Quaker… 2019…       2  42.0 -75.9
##  2 mallar3     Mallard Anas p… L147… Quaker… 2019…      27  42.0 -75.9
##  3 grbher3     Great … Ardea … L147… Quaker… 2019…       1  42.0 -75.9
##  4 blujay      Blue J… Cyanoc… L147… Quaker… 2019…       1  42.0 -75.9
##  5 eursta      Europe… Sturnu… L147… Quaker… 2019…       4  42.0 -75.9
##  6 daejun      Dark-e… Junco … L147… Quaker… 2019…       1  42.0 -75.9
##  7 turvul      Turkey… Cathar… L447… Bingha… 2019…       8  42.1 -76.0
##  8 norhar2     Northe… Circus… L447… Bingha… 2019…       1  42.1 -76.0
##  9 baleag      Bald E… Haliae… L447… Bingha… 2019…       1  42.1 -76.0
## 10 rethaw      Red-ta… Buteo … L447… Bingha… 2019…       2  42.1 -76.0
## # … with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>
```


### Recent sightings from location IDs

Search for bird occurrences for in a hotspot using its ID


```r
ebirdregion(loc = 'L99381')
```

```
## # A tibble: 68 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 cangoo      Canada… Branta… L993… Stewar… 2019…       8  42.5 -76.5
##  2 mallar3     Mallard Anas p… L993… Stewar… 2019…      25  42.5 -76.5
##  3 ribgul      Ring-b… Larus … L993… Stewar… 2019…      30  42.5 -76.5
##  4 hergul      Herrin… Larus … L993… Stewar… 2019…      35  42.5 -76.5
##  5 gbbgul      Great … Larus … L993… Stewar… 2019…       6  42.5 -76.5
##  6 doccor      Double… Phalac… L993… Stewar… 2019…     250  42.5 -76.5
##  7 rebwoo      Red-be… Melane… L993… Stewar… 2019…       1  42.5 -76.5
##  8 dowwoo      Downy … Dryoba… L993… Stewar… 2019…       3  42.5 -76.5
##  9 norfli      Northe… Colapt… L993… Stewar… 2019…       1  42.5 -76.5
## 10 blujay      Blue J… Cyanoc… L993… Stewar… 2019…       8  42.5 -76.5
## # … with 58 more rows, and 3 more variables: obsValid <lgl>,
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
##   speciesCode comName sciName locId locName obsDt howMany   lat   lng
##   <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
## 1 ribgul      Ring-b… Larus … L993… Stewar… 2019…      30  42.5 -76.5
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
## # A tibble: 36 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 cangoo      Canada… Branta… L147… Quaker… 2019…       2  42.0 -75.9
##  2 cangoo      Canada… Branta… L978… Murphy… 2019…      NA  42.1 -76.0
##  3 cangoo      Canada… Branta… L207… Workwa… 2019…       4  42.1 -75.9
##  4 cangoo      Canada… Branta… L245… Water … 2019…      20  42.1 -75.9
##  5 cangoo      Canada… Branta… L274… River … 2019…      25  42.1 -76.0
##  6 cangoo      Canada… Branta… L255… Wall S… 2019…       1  42.1 -75.9
##  7 cangoo      Canada… Branta… L446… PA-SQ-… 2019…      25  41.8 -75.9
##  8 cangoo      Canada… Branta… L179… Joyce … 2019…       6  41.8 -75.9
##  9 cangoo      Canada… Branta… L246… Martin… 2019…       2  42.1 -75.9
## 10 cangoo      Canada… Branta… L166… Chugnu… 2019…      40  42.1 -76.0
## # … with 26 more rows, and 3 more variables: obsValid <lgl>,
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
## # A tibble: 1,492 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 btbwar      Black-… Setoph… L668… Naples… 2019…       1  26.1 -81.7
##  2 btbwar      Black-… Setoph… L399… Florid… 2019…       1  26.4 -80.1
##  3 btbwar      Black-… Setoph… L900… 1301 S… 2019…       2  26.3 -80.1
##  4 btbwar      Black-… Setoph… L486… Union … 2019…       1  40.7 -74.0
##  5 btbwar      Black-… Setoph… L100… "Parki… 2019…       1  26.1 -80.1
##  6 btbwar      Black-… Setoph… L685… Hillsb… 2019…       2  26.3 -80.2
##  7 btbwar      Black-… Setoph… L616… Lake L… 2019…       3  35.9 -78.7
##  8 btbwar      Black-… Setoph… L871… Eno Ri… 2019…       1  36.1 -79.0
##  9 btbwar      Black-… Setoph… L994… Jupite… 2019…       1  27.0 -80.1
## 10 btbwar      Black-… Setoph… L127… Hugh T… 2019…       1  26.1 -80.1
## # … with 1,482 more rows, and 3 more variables: obsValid <lgl>,
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
##  1 amekes      Americ… Falco … L813… Washbu… 2019…       1  40.7 -83.3
##  2 turvul      Turkey… Cathar… L813… Washbu… 2019…       1  40.7 -83.3
##  3 bkcchi      Black-… Poecil… L805… Rocky … 2019…       4  41.4 -81.9
##  4 tuftit      Tufted… Baeolo… L805… Rocky … 2019…       1  41.4 -81.9
##  5 reshaw      Red-sh… Buteo … L805… Rocky … 2019…       1  41.4 -81.9
##  6 rebwoo      Red-be… Melane… L805… Rocky … 2019…       1  41.4 -81.9
##  7 mallar3     Mallard Anas p… L805… Rocky … 2019…       4  41.4 -81.9
##  8 houfin      House … Haemor… L805… Rocky … 2019…       6  41.4 -81.9
##  9 dowwoo      Downy … Dryoba… L805… Rocky … 2019…       2  41.4 -81.9
## 10 cangoo      Canada… Branta… L805… Rocky … 2019…      14  41.4 -81.9
## # … with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>
```


### Frequency of observations at hotspots or regions

Obtain historical frequencies of bird occurrences at a given hotspot


```r
ebirdfreq(loctype = 'hotspots', loc = 'L196159')
```

```
## # A tibble: 9,408 x 4
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
## # … with 9,398 more rows
```

Same, but in wide format (for making bar charts)


```r
ebirdfreq(loctype = 'hotspots', loc = 'L196159', long = FALSE)
```

```
## # A tibble: 197 x 49
##    comName `January-1` `January-2` `January-3` `January-4` `February-1`
##    <chr>         <dbl>       <dbl>       <dbl>       <dbl>        <dbl>
##  1 Sample…      33         32          43         113           47     
##  2 Snow G…       0          0           0           0            0     
##  3 Greate…       0          0           0           0            0     
##  4 Cackli…       0          0           0           0            0     
##  5 Canada…       0          0.0312      0.0015      0.106        0.191 
##  6 Cackli…       0          0           0           0            0     
##  7 Trumpe…       0          0           0           0            0     
##  8 Wood D…       0.152      0.0312      0           0.0177       0.0426
##  9 Blue-w…       0          0           0           0            0     
## 10 Cinnam…       0          0           0           0            0     
## # … with 187 more rows, and 43 more variables: `February-2` <dbl>,
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
## # A tibble: 36,048 x 4
##    comName                                    monthQt  frequency sampleSize
##    <chr>                                      <chr>        <dbl>      <dbl>
##  1 Fulvous Whistling-Duck                     January… 0              16870
##  2 Emperor Goose                              January… 0              16870
##  3 Snow Goose                                 January… 0.0281         16870
##  4 Ross's Goose                               January… 0              16870
##  5 Snow x Ross's Goose (hybrid)               January… 0              16870
##  6 Snow/Ross's Goose                          January… 0              16870
##  7 Swan Goose (Domestic type)                 January… 0.0000593      16870
##  8 Graylag x Swan Goose (Domestic type) (hyb… January… 0              16870
##  9 Greater White-fronted Goose                January… 0.00765        16870
## 10 Pink-footed Goose                          January… 0              16870
## # … with 36,038 more rows
```

Or county


```r
ebirdfreq(loctype = 'counties', loc = 'CA-BC-GV')
```

```
## # A tibble: 25,536 x 4
##    comName                                    monthQt  frequency sampleSize
##    <chr>                                      <chr>        <dbl>      <dbl>
##  1 Emperor Goose                              January…   0             5411
##  2 Snow Goose                                 January…   0.0641        5411
##  3 Ross's Goose                               January…   0             5411
##  4 Snow/Ross's Goose                          January…   0             5411
##  5 Greater White-fronted Goose                January…   0.00573       5411
##  6 Domestic goose sp. (Domestic type)         January…   0             5411
##  7 Brant                                      January…   0.0307        5411
##  8 Cackling Goose                             January…   0.0163        5411
##  9 Canada Goose                               January…   0.200         5411
## 10 Swan Goose (Domestic type) x Canada Goose… January…   0             5411
## # … with 25,526 more rows
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
## # A tibble: 1,710 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 buhvir      Blue-h… Vireo … L100… 92–98 … 2019…       1  42.4 -72.6
##  2 yebcuc      Yellow… Coccyz… L167… Rachel… 2019…       1  43.4 -70.4
##  3 redhea      Redhead Aythya… L131… Sabatt… 2019…       1  44.1 -70.1
##  4 pinwar      Pine W… Setoph… L345… Home    2019…       1  42.3 -72.4
##  5 comgal1     Common… Gallin… L100… Trusto… 2019…       1  41.4 -71.6
##  6 tufduc      Tufted… Aythya… L100… Trusto… 2019…       1  41.4 -71.6
##  7 grycat      Gray C… Dumete… L271… Dahl W… 2019…       1  44.0 -71.1
##  8 trokin      Tropic… Tyrann… L593… Rock M… 2019…       1  42.4 -71.2
##  9 reevir1     Red-ey… Vireo … L813… P. J. … 2019…       1  41.7 -70.9
## 10 wessan      Wester… Calidr… L830… Plum I… 2019…       1  42.8 -70.8
## # … with 1,700 more rows, and 3 more variables: obsValid <lgl>,
## #   obsReviewed <lgl>, locationPrivate <lgl>
```

or a region


```r
ebirdnotable(locID = 'US-NY-109')
```

```
## # A tibble: 49 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 blkvul      Black … Coragy… L212… Steven… 2019…       2  42.4 -76.4
##  2 blkvul      Black … Coragy… L212… Steven… 2019…       2  42.4 -76.4
##  3 whevir      White-… Vireo … L100… Monroe… 2019…       1  42.4 -76.5
##  4 whevir      White-… Vireo … L542… Norths… 2019…       1  42.4 -76.5
##  5 whevir      White-… Vireo … L100… 101–19… 2019…       1  42.4 -76.5
##  6 andduc1     Andean… Oxyura… L100… Bogota  2019…       2  42.5 -76.5
##  7 whtdov1     White-… Leptot… L100… Bogota  2019…      11  42.5 -76.5
##  8 whtdov      White-… Leptot… L100… Bogota  2019…       3  42.5 -76.5
##  9 wfwduc1     White-… Dendro… L100… Bogota  2019…       1  42.5 -76.5
## 10 musduc      Muscov… Cairin… L100… Bogota  2019…       3  42.5 -76.5
## # … with 39 more rows, and 3 more variables: obsValid <lgl>,
## #   obsReviewed <lgl>, locationPrivate <lgl>
```

### Historic Observations

Obtain a list of species reported on a specific date in a given region 


```r
ebirdhistorical(loc = 'US-VA-003', date = '2019-02-14', max = 10)
```

```
## # A tibble: 10 x 12
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 cangoo      Canada… Branta… L139… Lickin… 2019…      30  38.1 -78.7
##  2 mallar3     Mallard Anas p… L139… Lickin… 2019…       5  38.1 -78.7
##  3 gnwtea      Green-… Anas c… L139… Lickin… 2019…       8  38.1 -78.7
##  4 killde      Killde… Charad… L139… Lickin… 2019…       1  38.1 -78.7
##  5 baleag      Bald E… Haliae… L139… Lickin… 2019…       1  38.1 -78.7
##  6 belkin1     Belted… Megace… L139… Lickin… 2019…       1  38.1 -78.7
##  7 carwre      Caroli… Thryot… L139… Lickin… 2019…       1  38.1 -78.7
##  8 whtspa      White-… Zonotr… L139… Lickin… 2019…       2  38.1 -78.7
##  9 norcar      Northe… Cardin… L139… Lickin… 2019…       1  38.1 -78.7
## 10 canvas      Canvas… Aythya… L331… Montic… 2019…      19  38.0 -78.5
## # … with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>
```

or a hotspot


```r
ebirdhistorical(loc = 'L196159', date = '2019-02-14', fieldSet = 'full')
```

```
## # A tibble: 14 x 27
##    speciesCode comName sciName locId locName obsDt howMany   lat   lng
##    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
##  1 annhum      Anna's… Calypt… L196… Vancou… 2019…       4  49.3 -123.
##  2 ribgul      Ring-b… Larus … L196… Vancou… 2019…       4  49.3 -123.
##  3 glwgul      Glauco… Larus … L196… Vancou… 2019…      29  49.3 -123.
##  4 norcro      Northw… Corvus… L196… Vancou… 2019…     100  49.3 -123.
##  5 bkcchi      Black-… Poecil… L196… Vancou… 2019…      16  49.3 -123.
##  6 bushti      Bushtit Psaltr… L196… Vancou… 2019…      20  49.3 -123.
##  7 pacwre1     Pacifi… Troglo… L196… Vancou… 2019…       1  49.3 -123.
##  8 houfin      House … Haemor… L196… Vancou… 2019…       2  49.3 -123.
##  9 purfin      Purple… Haemor… L196… Vancou… 2019…       3  49.3 -123.
## 10 amegfi      Americ… Spinus… L196… Vancou… 2019…      15  49.3 -123.
## 11 daejun      Dark-e… Junco … L196… Vancou… 2019…      37  49.3 -123.
## 12 sonspa      Song S… Melosp… L196… Vancou… 2019…      12  49.3 -123.
## 13 spotow      Spotte… Pipilo… L196… Vancou… 2019…       1  49.3 -123.
## 14 rewbla      Red-wi… Agelai… L196… Vancou… 2019…       6  49.3 -123.
## # … with 18 more variables: obsValid <lgl>, obsReviewed <lgl>,
## #   locationPrivate <lgl>, subnational2Code <chr>, subnational2Name <chr>,
## #   subnational1Code <chr>, subnational1Name <chr>, countryCode <chr>,
## #   countryName <chr>, userDisplayName <chr>, subId <chr>, obsId <chr>,
## #   checklistId <chr>, presenceNoted <lgl>, hasComments <lgl>,
## #   firstName <chr>, lastName <chr>, hasRichMedia <lgl>
```

### eBird taxonomy

Returns a data.frame of all species in the eBird taxonomy for the given parameter inputs


```r
ebirdtaxonomy()
```

```
## # A tibble: 16,513 x 14
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
## # … with 16,503 more rows, and 8 more variables: comNameCodes <chr>,
## #   sciNameCodes <chr>, order <chr>, familyComName <chr>,
## #   familySciName <chr>, reportAs <chr>, extinct <lgl>, extinctYear <int>
```

Search for hybrid species only


```r
ebirdtaxonomy(cat = "hybrid")
```

```
## # A tibble: 462 x 11
##    sciName comName speciesCode category taxonOrder bandingCodes
##    <chr>   <chr>   <chr>       <chr>         <dbl> <chr>       
##  1 Dendro… Spotte… x00721      hybrid          219 <NA>        
##  2 Dendro… Black-… x00775      hybrid          224 <NA>        
##  3 Dendro… White-… x00938      hybrid          226 <NA>        
##  4 Dendro… Black-… x00875      hybrid          227 <NA>        
##  5 Anser … Snow x… sxrgoo1     hybrid          244 SRGH        
##  6 Anser … Grayla… x00776      hybrid          252 <NA>        
##  7 Anser … Bar-he… x00755      hybrid          260 <NA>        
##  8 Anser … Snow x… x00627      hybrid          261 <NA>        
##  9 Anser … Snow G… x00685      hybrid          281 <NA>        
## 10 Anser … Pink-f… x00756      hybrid          283 <NA>        
## # … with 452 more rows, and 5 more variables: comNameCodes <chr>,
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
## 1 L196… Vanc…     49.3     -123. CA          Canada      British Columbia
## # … with 9 more variables: subnational1Code <chr>, subnational2Code <chr>,
## #   subnational2Name <chr>, isHotspot <lgl>, locName <chr>, lat <dbl>,
## #   lng <dbl>, hierarchicalName <chr>, locID <chr>
```
