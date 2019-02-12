<!-- README.md is generated from README.Rmd. Please edit that file -->



# rebird: wrapper to the eBird API

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://api.travis-ci.org/ropensci/rebird.png)](https://travis-ci.org/ropensci/rebird)
[![Build status](https://ci.appveyor.com/api/projects/status/s3dobn991c20t2kg?svg=true)](https://ci.appveyor.com/project/sckott/rebird)
[![cran checks](https://cranchecks.info/badges/worst/rebird)](https://cranchecks.info/pkgs/rebird)
[![Coverage Status](https://coveralls.io/repos/ropensci/rebird/badge.svg)](https://coveralls.io/r/ropensci/rebird)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/rebird)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/rebird)](https://cran.r-project.org/package=rebird/)

`rebird` is a package to interface with the eBird webservices.

eBird is a real-time, online bird checklist program. For more information, visit their website: http://www.ebird.org

The API for the eBird webservices can be accessed here: https://documenter.getpostman.com/view/664302/ebird-api-20/2HTbHW

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


# Direct use of `rebird`

Load the package:


```r
library("rebird")
```

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
#> Peruvian Booby (Sula variegata): perboo1
#> [1] "perboo1"
```

The `species_code` function can be called within other `rebird` functions, or the species code 
can be specified directly.


## Sightings at location determined by latitude/longitude

Search for bird occurrences by latitude and longitude point


```r
ebirdgeo(species = species_code('spinus tristis'), lat = 42, lng = -76)
#> American Goldfinch (Spinus tristis): amegfi
#> # A tibble: 22 x 12
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 amegfi      Americ… Spinus… L814… Woodbo… 2019…      12  41.8 -75.9
#>  2 amegfi      Americ… Spinus… L846… 31 Pul… 2019…       6  42.2 -76.2
#>  3 amegfi      Americ… Spinus… L520… US-PA-… 2019…       7  41.8 -75.8
#>  4 amegfi      Americ… Spinus… L845… 6106 P… 2019…       3  41.9 -75.7
#>  5 amegfi      Americ… Spinus… L197… esther… 2019…       1  42.1 -75.9
#>  6 amegfi      Americ… Spinus… L465… US-New… 2019…       4  42.2 -75.9
#>  7 amegfi      Americ… Spinus… L852… 5051–5… 2019…       4  42.1 -76.3
#>  8 amegfi      Americ… Spinus… L179… Joyce … 2019…       3  41.8 -75.9
#>  9 amegfi      Americ… Spinus… L184… 325 De… 2019…       2  42.2 -76.0
#> 10 amegfi      Americ… Spinus… L692… 7 Rive… 2019…       6  42.1 -76.3
#> # … with 12 more rows, and 3 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>
```

## Recent observations at a region

Search for bird occurrences by region and species name


```r
ebirdregion(loc = 'US', species = 'btbwar')
#> # A tibble: 24 x 12
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 btbwar      Black-… Setoph… L835… My yard 2019…       1  39.9 -74.8
#>  2 btbwar      Black-… Setoph… L127… Fort Z… 2019…       1  24.5 -81.8
#>  3 btbwar      Black-… Setoph… L128… Zoo Mi… 2019…       1  25.6 -80.4
#>  4 btbwar      Black-… Setoph… L132… FSPSP-… 2019…       1  26.0 -81.5
#>  5 btbwar      Black-… Setoph… L630… Dania … 2019…       1  26.1 -80.2
#>  6 btbwar      Black-… Setoph… L580… No Nam… 2019…       1  24.7 -81.3
#>  7 btbwar      Black-… Setoph… L127… Mathes… 2019…       1  25.7 -80.3
#>  8 btbwar      Black-… Setoph… L850… Martin… 2019…       1  25.8 -80.2
#>  9 btbwar      Black-… Setoph… L707… Fakaha… 2019…       1  26.1 -81.4
#> 10 btbwar      Black-… Setoph… L191… Villag… 2019…       1  25.5 -80.5
#> # … with 14 more rows, and 3 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>
```


## Recent observations at hotspots

Search for bird occurrences by a given hotspot


```r
ebirdregion(loc = 'L99381')
#> # A tibble: 19 x 12
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 commer      Common… Mergus… L993… Stewar… 2019…      50  42.5 -76.5
#>  2 duck1       duck s… Anatin… L993… Stewar… 2019…     100  42.5 -76.5
#>  3 rocpig      Rock P… Columb… L993… Stewar… 2019…      25  42.5 -76.5
#>  4 larus1      Larus … Larus … L993… Stewar… 2019…     800  42.5 -76.5
#>  5 whbnut      White-… Sitta … L993… Stewar… 2019…       2  42.5 -76.5
#>  6 brncre      Brown … Certhi… L993… Stewar… 2019…       1  42.5 -76.5
#>  7 blujay      Blue J… Cyanoc… L993… Stewar… 2019…       1  42.5 -76.5
#>  8 bkcchi      Black-… Poecil… L993… Stewar… 2019…       1  42.5 -76.5
#>  9 eursta      Europe… Sturnu… L993… Stewar… 2019…       1  42.5 -76.5
#> 10 houspa      House … Passer… L993… Stewar… 2019…       1  42.5 -76.5
#> 11 cangoo      Canada… Branta… L993… Stewar… 2019…    1000  42.5 -76.5
#> 12 redhea      Redhead Aythya… L993… Stewar… 2019…    1000  42.5 -76.5
#> 13 ribgul      Ring-b… Larus … L993… Stewar… 2019…       1  42.5 -76.5
#> 14 gbbgul      Great … Larus … L993… Stewar… 2019…       2  42.5 -76.5
#> 15 baleag      Bald E… Haliae… L993… Stewar… 2019…       1  42.5 -76.5
#> 16 rethaw      Red-ta… Buteo … L993… Stewar… 2019…       1  42.5 -76.5
#> 17 amecro      Americ… Corvus… L993… Stewar… 2019…       2  42.5 -76.5
#> 18 mallar3     Mallard Anas p… L993… Stewar… 2019…       1  42.5 -76.5
#> 19 hergul      Herrin… Larus … L993… Stewar… 2019…       2  42.5 -76.5
#> # … with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
#> #   locationPrivate <lgl>
```

## Nearest observations of a species

Search for a species' occurrences near a given latitude and longitude


```r
nearestobs(species_code('branta canadensis'), 42, -76)
#> Canada Goose (Branta canadensis): cangoo
#> # A tibble: 20 x 12
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 cangoo      Canada… Branta… L789… Bingha… 2019…      13  42.1 -76.0
#>  2 cangoo      Canada… Branta… L852… 5051–5… 2019…      80  42.1 -76.3
#>  3 cangoo      Canada… Branta… L464… Port D… 2019…      47  42.1 -75.9
#>  4 cangoo      Canada… Branta… L186… Cheri … 2019…       1  42.1 -75.9
#>  5 cangoo      Canada… Branta… L505… Boland… 2019…      11  42.2 -75.9
#>  6 cangoo      Canada… Branta… L468… "Bolan… 2019…      16  42.2 -75.9
#>  7 cangoo      Canada… Branta… L191… Colema… 2019…       8  42.0 -76.0
#>  8 cangoo      Canada… Branta… L201… Conflu… 2019…      10  42.1 -76.3
#>  9 cangoo      Canada… Branta… L282… Otsini… 2019…      25  42.1 -75.9
#> 10 cangoo      Canada… Branta… L501… Willia… 2019…      30  42.1 -76.0
#> 11 cangoo      Canada… Branta… L242… Port D… 2019…      38  42.1 -75.9
#> 12 cangoo      Canada… Branta… L296… "Hillc… 2019…       1  42.2 -75.9
#> 13 cangoo      Canada… Branta… L212… Chenan… 2019…       3  42.2 -75.8
#> 14 cangoo      Canada… Branta… L255… Wall S… 2019…      30  42.1 -75.9
#> 15 cangoo      Canada… Branta… L625… 4701 V… 2019…      25  42.1 -76.0
#> 16 cangoo      Canada… Branta… L109… Hillcr… 2019…      10  42.2 -75.9
#> 17 cangoo      Canada… Branta… L350… Day Fa… 2019…      30  42.1 -76.3
#> 18 cangoo      Canada… Branta… L207… Workwa… 2019…      29  42.1 -75.9
#> 19 cangoo      Canada… Branta… L146… Harold… 2019…       8  42.1 -76.0
#> 20 cangoo      Canada… Branta… L674… 5790–5… 2019…     200  42.1 -76.3
#> # … with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
#> #   locationPrivate <lgl>
```


## Frequency of observations at hotspots or regions

Obtain historical frequencies of bird occurrences by hotspot or region


```r
ebirdfreq(loctype = 'hotspots', loc = 'L196159')
#> # A tibble: 9,168 x 4
#>    comName                     monthQt   frequency sampleSize
#>    <chr>                       <chr>         <dbl>      <dbl>
#>  1 Snow Goose                  January-1     0             33
#>  2 Greater White-fronted Goose January-1     0             33
#>  3 Cackling Goose              January-1     0             33
#>  4 Canada Goose                January-1     0             33
#>  5 Cackling/Canada Goose       January-1     0             33
#>  6 Trumpeter Swan              January-1     0             33
#>  7 Wood Duck                   January-1     0.152         33
#>  8 Blue-winged Teal            January-1     0             33
#>  9 Cinnamon Teal               January-1     0             33
#> 10 Blue-winged/Cinnamon Teal   January-1     0             33
#> # … with 9,158 more rows
```

## Recent notable sightings

Search for notable sightings at a given latitude and longitude


```r
ebirdnotable(lat = 42, lng = -70)
#> # A tibble: 1,423 x 12
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 buffle      Buffle… Buceph… L849… Bondsv… 2019…       2  42.2 -72.3
#>  2 bohwax      Bohemi… Bombyc… L853… 157 So… 2019…       1  41.9 -70.7
#>  3 bohwax      Bohemi… Bombyc… L853… 157 So… 2019…       1  41.9 -70.7
#>  4 kineid      King E… Somate… L466… Scusse… 2019…       1  41.8 -70.5
#>  5 kineid      King E… Somate… L466… Scusse… 2019…       1  41.8 -70.5
#>  6 y00478      Icelan… Larus … L667… 1777 M… 2019…       2  42.6 -71.2
#>  7 kineid      King E… Somate… L193… Sandwi… 2019…       1  41.8 -70.5
#>  8 rinduc      Ring-n… Aythya… L853… 3 Pond… 2019…       3  44.1 -69.5
#>  9 grycat      Gray C… Dumete… L251… Horn P… 2019…       1  42.5 -71.2
#> 10 ruckin      Ruby-c… Regulu… L853… 17 N W… 2019…       1  41.4 -71.7
#> # … with 1,413 more rows, and 3 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>
```

or a region


```r
ebirdnotable(locID = 'US-NY-109')
#> # A tibble: 28 x 12
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 blkvul      Black … Coragy… L179… Taugha… 2019…       3  42.5 -76.6
#>  2 whwcro      White-… Loxia … L852… 538 El… 2019…       3  42.4 -76.4
#>  3 ruckin      Ruby-c… Regulu… L353… Salt P… 2019…       1  42.5 -76.5
#>  4 evegro      Evenin… Coccot… L598… Midlin… 2019…      16  42.4 -76.3
#>  5 evegro1     Evenin… Coccot… L280… 651 Ha… 2019…      35  42.4 -76.3
#>  6 osprey      Osprey  Pandio… L850… 147 My… 2019…       1  42.5 -76.5
#>  7 chispa      Chippi… Spizel… L783… 9 Muri… 2019…       1  42.5 -76.5
#>  8 evegro3     Evenin… Coccot… L653… 600-63… 2019…       3  42.4 -76.3
#>  9 evegro3     Evenin… Coccot… L653… 600-63… 2019…       3  42.4 -76.3
#> 10 evegro      Evenin… Coccot… L598… Midlin… 2019…       3  42.4 -76.3
#> # … with 18 more rows, and 3 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>
```

## Information on a given region or hotspot

Obtain detailed information on any valid eBird region


```r
ebirdregioninfo("CA-BC-GV")
#> # A tibble: 1 x 5
#>   region                                     minX  maxX  minY  maxY
#>   <chr>                                     <dbl> <dbl> <dbl> <dbl>
#> 1 Metro Vancouver, British Columbia, Canada -123. -122.  49.0  49.6
```

or hotspot


```r
ebirdregioninfo("L196159")
#> # A tibble: 1 x 5
#>   region                                    minX  maxX  minY  maxY
#>   <chr>                                    <dbl> <dbl> <dbl> <dbl>
#> 1 Vancouver--Trout Lake (John Hendry Park) -123. -123.  49.2  49.3
```

## `rebird` and other packages

### How to use `rebird`

This package is part of a richer suite called [spocc - Species Occurrence Data](https://github.com/ropensci/spocc), along with several other packages, that provide access to occurrence records from multiple databases. We recommend using `spocc` as the primary R interface to `rebird` unless your needs are limited to this single source.

### `auk` vs. `rebird`

Those interested in eBird data may also want to consider [`auk`](https://github.com/CornellLabofOrnithology/auk), an R package that helps extracting and processing the whole eBird dataset. The functions in `rebird` are faster but mostly limited to accessing recent (i.e. within the last 30 days) observations, although `ebirdfreq()` does provide historical frequency of observation data. In contrast, `auk` gives access to the full set of ~ 500 million eBird observations. For most ecological applications, users will require `auk`; however, for some use cases, e.g. building tools for birders, `rebird` provides a quicker and easier way to access data. `rebird` and `auk` are both part of the rOpenSci project.

## API requests covered by `rebird`

The 2.0 APIs have considerably been expanded from the previous version, and `rebird` only covers some of them.  The webservices covered are listed below; if you'd like to contribute wrappers to APIs not yet covered by this package, feel free to submit a pull request!

### data/obs
- [x] Recent observations in a region: `ebirdregion()`
- [x] Recent notable observations in a region: `ebirdnotable()`
- [x] Recent observations of a species in a region: `ebirdregion()`
- [x] Recent nearby observations: `ebirdgeo()` 
- [x] Recent nearby observations of a species: `ebirdgeo()`
- [x] Nearest observations of a species: `nearestobs()`
- [x] Recent nearby notable observations: `ebirdnotable()`
- [ ] Historic observations on a date

### product
- [ ]   Top 100
- [ ]     Checklist feed on a date
- [ ]     Recent checklists feed
- [ ]  Regional statistics on a date
- [ ]     View Checklist BETA

### ref/geo
 - [ ]    Adjacent Regions

### ref/hotspot
 - [ ]     Hotspots in a region
 - [ ]     Nearby hotspots

### ref/taxonomy
 - [x]     eBird Taxonomy: `ebirdtaxonomy()`
 - [ ]     Taxonomic Forms
 - [ ]     Taxonomy Versions
 - [ ]     Taxonomic Groups

### ref/region
 - [x]     Hotspot Info: `ebirdregioninfo()`
 - [x]    Region Info: `ebirdregioninfo()`
 - [ ]     Sub Region List


## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rebird/issues).
* License: MIT
* Get citation information for `rebird` in R doing `citation(package = 'rebird')`


[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)


