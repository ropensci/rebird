---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



# rebird: wrapper to the eBird API

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://api.travis-ci.org/ropensci/rebird.png)](https://travis-ci.org/ropensci/rebird)
[![Build status](https://ci.appveyor.com/api/projects/status/s3dobn991c20t2kg?svg=true)](https://ci.appveyor.com/project/sckott/rebird)
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
#> # A tibble: 45 x 12
#>    speciesCode comName  sciName  locId locName   obsDt howMany   lat   lng
#>    <chr>       <chr>    <chr>    <chr> <chr>     <chr>   <int> <dbl> <dbl>
#>  1 amegfi      America… Spinus … L495… Binghamt… 2018…       1  42.1 -76.0
#>  2 amegfi      America… Spinus … L527… R Tee Go… 2018…       1  42.2 -75.9
#>  3 amegfi      America… Spinus … L795… US-New Y… 2018…       7  42.1 -76.0
#>  4 amegfi      America… Spinus … L978… Murphys … 2018…       5  42.1 -76.0
#>  5 amegfi      America… Spinus … L209… Aquaterr… 2018…       9  42.0 -75.9
#>  6 amegfi      America… Spinus … L320… Hillcres… 2018…       1  42.2 -75.9
#>  7 amegfi      America… Spinus … L285… Camp Sus… 2018…       1  42.0 -75.9
#>  8 amegfi      America… Spinus … L207… Workwalk  2018…       1  42.1 -75.9
#>  9 amegfi      America… Spinus … L519… IBM Glen… 2018…       3  42.1 -76.0
#> 10 amegfi      America… Spinus … L501… William … 2018…       2  42.1 -76.0
#> # ... with 35 more rows, and 3 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>
```

## Recent observations at a region

Search for bird occurrences by region and species name


```r
ebirdregion(loc = 'US', species = 'btbwar')
#> # A tibble: 1,043 x 12
#>    speciesCode comName  sciName  locId  locName  obsDt howMany   lat   lng
#>    <chr>       <chr>    <chr>    <chr>  <chr>    <chr>   <int> <dbl> <dbl>
#>  1 btbwar      Black-t… Setopha… L1334… Ox Bow … 2018…       1  41.6 -85.9
#>  2 btbwar      Black-t… Setopha… L2785… Blue Sp… 2018…       1  28.9 -81.3
#>  3 btbwar      Black-t… Setopha… L2139… CMCH     2018…       2  39.1 -74.8
#>  4 btbwar      Black-t… Setopha… L1301… Ashland… 2018…       1  39.8 -75.7
#>  5 btbwar      Black-t… Setopha… L1298… Lake On… 2018…       1  40.5 -75.9
#>  6 btbwar      Black-t… Setopha… L5044… John He… 2018…       4  39.9 -75.3
#>  7 btbwar      Black-t… Setopha… L5974… Cape Is… 2018…       1  38.9 -75.0
#>  8 btbwar      Black-t… Setopha… L6960… Dunham … 2018…       1  40.7 -74.6
#>  9 btbwar      Black-t… Setopha… L1657… Black R… 2018…       1  40.2 -75.5
#> 10 btbwar      Black-t… Setopha… L8654… Acadia … 2018…       1  44.3 -68.1
#> # ... with 1,033 more rows, and 3 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>
```


## Recent observations at hotspots

Search for bird occurrences by a given hotspot


```r
ebirdregion(loc = 'L99381')
#> # A tibble: 63 x 12
#>    speciesCode comName   sciName   locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>     <chr>     <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 cangoo      Canada G… Branta c… L993… Stewar… 2018…      25  42.5 -76.5
#>  2 mallar3     Mallard   Anas pla… L993… Stewar… 2018…      40  42.5 -76.5
#>  3 commer      Common M… Mergus m… L993… Stewar… 2018…      16  42.5 -76.5
#>  4 rocpig      Rock Pig… Columba … L993… Stewar… 2018…       8  42.5 -76.5
#>  5 ribgul      Ring-bil… Larus de… L993… Stewar… 2018…      80  42.5 -76.5
#>  6 hergul      Herring … Larus ar… L993… Stewar… 2018…      25  42.5 -76.5
#>  7 lbbgul      Lesser B… Larus fu… L993… Stewar… 2018…       1  42.5 -76.5
#>  8 gbbgul      Great Bl… Larus ma… L993… Stewar… 2018…       8  42.5 -76.5
#>  9 doccor      Double-c… Phalacro… L993… Stewar… 2018…     600  42.5 -76.5
#> 10 grbher3     Great Bl… Ardea he… L993… Stewar… 2018…       2  42.5 -76.5
#> # ... with 53 more rows, and 3 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>
```


## Frequency of observations at hotspots or regions

Obtain historical frequencies of bird occurrences by hotspot or region


```r
ebirdfreq(loctype = 'hotspots', loc = 'L196159')
#> # A tibble: 9,072 x 4
#>    comName                     monthQt   frequency sampleSize
#>    <chr>                       <chr>         <dbl>      <dbl>
#>  1 Snow Goose                  January-1     0.           27.
#>  2 Greater White-fronted Goose January-1     0.           27.
#>  3 Cackling Goose              January-1     0.           27.
#>  4 Canada Goose                January-1     0.           27.
#>  5 Cackling/Canada Goose       January-1     0.           27.
#>  6 Trumpeter Swan              January-1     0.           27.
#>  7 Wood Duck                   January-1     0.185        27.
#>  8 Blue-winged Teal            January-1     0.           27.
#>  9 Cinnamon Teal               January-1     0.           27.
#> 10 Blue-winged/Cinnamon Teal   January-1     0.           27.
#> # ... with 9,062 more rows
```

### Recent notable sightings

Search for notable sightings at a given latitude and longitude


```r
ebirdnotable(lat = 42, lng = -70)
#> # A tibble: 773 x 12
#>    speciesCode comName  sciName  locId locName   obsDt howMany   lat   lng
#>    <chr>       <chr>    <chr>    <chr> <chr>     <chr>   <int> <dbl> <dbl>
#>  1 horlar      Horned … Eremoph… L278… Rye Harb… 2018…       1  43.0 -70.7
#>  2 redcro      Red Cro… Loxia c… L207… Moose Hi… 2018…       8  42.1 -71.2
#>  3 ycnher      Yellow-… Nyctana… L382… Lake War… 2018…       1  42.4 -72.6
#>  4 sancra      Sandhil… Antigon… L463… Highland… 2018…       1  43.9 -70.0
#>  5 libher      Little … Egretta… L613… Colt SP   2018…       1  41.7 -71.3
#>  6 eawpew      Eastern… Contopu… L724… 514 Racc… 2018…       1  43.4 -71.8
#>  7 conwar      Connect… Opororn… L464… Westboro… 2018…       1  42.3 -71.6
#>  8 ameoys      America… Haemato… L353… Scarboro… 2018…       2  43.5 -70.3
#>  9 canwar      Canada … Cardell… L594… Marblehe… 2018…       1  42.5 -70.8
#> 10 ycnher      Yellow-… Nyctana… L382… Lake War… 2018…       1  42.4 -72.6
#> # ... with 763 more rows, and 3 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>
```

or a region


```r
ebirdnotable(locID = 'US-NY-109')
#> # A tibble: 67 x 12
#>    speciesCode comName  sciName  locId  locName  obsDt howMany   lat   lng
#>    <chr>       <chr>    <chr>    <chr>  <chr>    <chr>   <int> <dbl> <dbl>
#>  1 buggna      Blue-gr… Poliopt… L5156… Sapsuck… 2018…       1  42.5 -76.5
#>  2 blkvul      Black V… Coragyp… L3982… 14## Ha… 2018…       1  42.5 -76.5
#>  3 blkvul      Black V… Coragyp… L2866… Sapsuck… 2018…       1  42.5 -76.5
#>  4 blkvul      Black V… Coragyp… L2123… Stevens… 2018…       1  42.4 -76.4
#>  5 sora        Sora     Porzana… L5947… Ridgewa… 2018…       1  42.3 -76.4
#>  6 conwar      Connect… Opororn… L4463… Durland… 2018…       1  42.4 -76.4
#>  7 canwar      Canada … Cardell… L2817… Cornell… 2018…       1  42.5 -76.5
#>  8 blkvul      Black V… Coragyp… L1498… Sapsuck… 2018…       1  42.5 -76.5
#>  9 blkvul      Black V… Coragyp… L8779… Bluegra… 2018…       1  42.5 -76.5
#> 10 comloo      Common … Gavia i… L3530… Salt Po… 2018…       1  42.5 -76.5
#> # ... with 57 more rows, and 3 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>
```

## Information on a given region

Obtain detailed information on any valid eBird region


```r
ebirdregioninfo("CA-BC-GV")
#> # A tibble: 1 x 5
#>   region                                     minX  maxX  minY  maxY
#>   <chr>                                     <dbl> <dbl> <dbl> <dbl>
#> 1 Metro Vancouver, British Columbia, Canada -123. -122.  49.0  49.6
```

# `rebird` and other packages

## How to use `rebird`

This package is part of a richer suite called [spocc - Species Occurrence Data](https://github.com/ropensci/spocc), along with several other packages, that provide access to occurrence records from multiple databases. We recommend using `spocc` as the primary R interface to `rebird` unless your needs are limited to this single source.

## `auk` vs. `rebird`

Those interested in eBird data may also want to consider [`auk`](https://github.com/CornellLabofOrnithology/auk), an R package that helps extracting and processing the whole eBird dataset. The functions in `rebird` are faster but mostly limited to accessing recent (i.e. within the last 30 days) observations, although `ebirdfreq()` does provide historical frequency of observation data. In contrast, `auk` gives access to the full set of ~ 500 million eBird observations. For most ecological applications, users will require `auk`; however, for some use cases, e.g. building tools for birders, `rebird` provides a quicker and easier way to access data. `rebird` and `auk` are both part of the rOpenSci project.


## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rebird/issues).
* License: MIT
* Get citation information for `rebird` in R doing `citation(package = 'rebird')`


[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)


