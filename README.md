---
output: github_document
---

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
#> # A tibble: 17 x 12
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 amegfi      Americ~ Spinus~ L184~ 325 De~ 2019~       1  42.2 -76.0
#>  2 amegfi      Americ~ Spinus~ L501~ Willia~ 2019~       5  42.1 -76.0
#>  3 amegfi      Americ~ Spinus~ L154~ Broome~ 2019~       2  42.0 -75.9
#>  4 amegfi      Americ~ Spinus~ L229~ Imperi~ 2019~       3  42.1 -76.0
#>  5 amegfi      Americ~ Spinus~ L351~ Anson ~ 2019~       4  42.1 -76.1
#>  6 amegfi      Americ~ Spinus~ L212~ Chenan~ 2019~       7  42.2 -75.8
#>  7 amegfi      Americ~ Spinus~ L520~ US-PA-~ 2019~      21  41.8 -75.8
#>  8 amegfi      Americ~ Spinus~ L209~ Aquate~ 2019~       1  42.0 -75.9
#>  9 amegfi      Americ~ Spinus~ L465~ US-New~ 2019~       8  42.2 -75.9
#> 10 amegfi      Americ~ Spinus~ L275~ "Home " 2019~       6  42.1 -76.0
#> 11 amegfi      Americ~ Spinus~ L505~ Boland~ 2019~      15  42.2 -75.9
#> 12 amegfi      Americ~ Spinus~ L424~ Aldric~ 2019~       1  42.1 -75.9
#> 13 amegfi      Americ~ Spinus~ L814~ Woodbo~ 2019~       5  41.8 -75.9
#> 14 amegfi      Americ~ Spinus~ L456~ Karen ~ 2019~       1  42.1 -76.3
#> 15 amegfi      Americ~ Spinus~ L197~ esther~ 2019~       6  42.1 -75.9
#> 16 amegfi      Americ~ Spinus~ L524~ Victor~ 2019~       1  42.1 -76.0
#> 17 amegfi      Americ~ Spinus~ L628~ Spring~ 2019~       2  42.1 -76.1
#> # ... with 3 more variables: obsValid <lgl>, obsReviewed <lgl>,
#> #   locationPrivate <lgl>
```

## Recent observations at a region

Search for bird occurrences by region and species name


```r
ebirdregion(loc = 'US', species = 'btbwar')
#> # A tibble: 33 x 12
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 btbwar      Black-~ Setoph~ L842~ 8806 S~ 2019~       1  25.7 -80.4
#>  2 btbwar      Black-~ Setoph~ L425~ Spicew~ 2019~       1  25.7 -80.4
#>  3 btbwar      Black-~ Setoph~ L835~ My yard 2019~       1  39.9 -74.8
#>  4 btbwar      Black-~ Setoph~ L123~ Key La~ 2019~       1  25.1 -80.4
#>  5 btbwar      Black-~ Setoph~ L209~ Hall's~ 2019~       1  42.3 -71.1
#>  6 btbwar      Black-~ Setoph~ L127~ Greyno~ 2019~       1  25.9 -80.2
#>  7 btbwar      Black-~ Setoph~ L127~ Mathes~ 2019~       1  25.7 -80.3
#>  8 btbwar      Black-~ Setoph~ L185~ 117 Oa~ 2019~       1  42.5 -71.1
#>  9 btbwar      Black-~ Setoph~ L429~ Toni R~ 2019~       1  27.7 -80.4
#> 10 btbwar      Black-~ Setoph~ L127~ Key La~ 2019~       1  25.2 -80.4
#> # ... with 23 more rows, and 3 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>
```


## Recent observations at hotspots

Search for bird occurrences by a given hotspot


```r
ebirdregion(loc = 'L99381')
#> # A tibble: 50 x 12
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 glagul      Glauco~ Larus ~ L993~ Stewar~ 2019~       1  42.5 -76.5
#>  2 cangoo      Canada~ Branta~ L993~ Stewar~ 2019~      NA  42.5 -76.5
#>  3 mallar3     Mallard Anas p~ L993~ Stewar~ 2019~      NA  42.5 -76.5
#>  4 redhea      Redhead Aythya~ L993~ Stewar~ 2019~      NA  42.5 -76.5
#>  5 comgol      Common~ Buceph~ L993~ Stewar~ 2019~      NA  42.5 -76.5
#>  6 commer      Common~ Mergus~ L993~ Stewar~ 2019~      NA  42.5 -76.5
#>  7 ribgul      Ring-b~ Larus ~ L993~ Stewar~ 2019~      NA  42.5 -76.5
#>  8 hergul      Herrin~ Larus ~ L993~ Stewar~ 2019~      NA  42.5 -76.5
#>  9 gbbgul      Great ~ Larus ~ L993~ Stewar~ 2019~      NA  42.5 -76.5
#> 10 lbbgul      Lesser~ Larus ~ L993~ Stewar~ 2019~       1  42.5 -76.5
#> # ... with 40 more rows, and 3 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>
```

## Nearest observations of a species

Search for a species' occurrences near a given latitude and longitude


```r
nearestobs(species_code('branta canadensis'), 42, -76)
#> Canada Goose (Branta canadensis): cangoo
#> # A tibble: 27 x 12
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 cangoo      Canada~ Branta~ L109~ Hillcr~ 2019~      20  42.2 -75.9
#>  2 cangoo      Canada~ Branta~ L501~ Willia~ 2019~      27  42.1 -76.0
#>  3 cangoo      Canada~ Branta~ L201~ Conflu~ 2019~     200  42.1 -76.3
#>  4 cangoo      Canada~ Branta~ L154~ Broome~ 2019~       8  42.0 -75.9
#>  5 cangoo      Canada~ Branta~ L346~ Nichol~ 2019~     289  42.1 -76.3
#>  6 cangoo      Canada~ Branta~ L282~ Otsini~ 2019~      45  42.1 -75.9
#>  7 cangoo      Canada~ Branta~ L351~ Anson ~ 2019~      45  42.1 -76.1
#>  8 cangoo      Canada~ Branta~ L212~ Chenan~ 2019~      21  42.2 -75.8
#>  9 cangoo      Canada~ Branta~ L209~ Aquate~ 2019~       3  42.0 -75.9
#> 10 cangoo      Canada~ Branta~ L186~ Cheri ~ 2019~      24  42.1 -75.9
#> # ... with 17 more rows, and 3 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>
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
#> # ... with 9,158 more rows
```

## Recent notable sightings

Search for notable sightings at a given latitude and longitude


```r
ebirdnotable(lat = 42, lng = -70)
#> # A tibble: 2,638 x 12
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 snogoo      Snow G~ Anser ~ L107~ South ~ 2019~       1  42.3 -72.6
#>  2 norpin      Northe~ Anas a~ L402~ Flowed~ 2019~       1  42.4 -71.3
#>  3 chispa      Chippi~ Spizel~ L246~ Tufts ~ 2019~       1  42.4 -71.1
#>  4 doccor      Double~ Phalac~ L198~ Mystic~ 2019~       1  42.4 -71.1
#>  5 gwfgoo1     Greate~ Anser ~ L129~ Whirlw~ 2019~       1  41.4 -72.8
#>  6 bargol      Barrow~ Buceph~ L410~ Cornfi~ 2019~       1  41.3 -72.4
#>  7 lbbgul      Lesser~ Larus ~ L269~ Needha~ 2019~       1  42.3 -71.3
#>  8 orcwar      Orange~ Oreoth~ L827~ Madaket 2019~       1  41.3 -70.2
#>  9 rinduc      Ring-n~ Aythya~ L718~ Presum~ 2019~       3  43.7 -70.4
#> 10 rinduc      Ring-n~ Aythya~ L718~ Presum~ 2019~       3  43.7 -70.4
#> # ... with 2,628 more rows, and 3 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>
```

or a region


```r
ebirdnotable(locID = 'US-NY-109')
#> # A tibble: 89 x 12
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 norsho      Northe~ Spatul~ L842~ 1048 E~ 2019~       2  42.5 -76.5
#>  2 ricgoo1     Cackli~ Branta~ L879~ Monkey~ 2019~       1  42.5 -76.4
#>  3 ruckin      Ruby-c~ Regulu~ L879~ Monkey~ 2019~       1  42.5 -76.4
#>  4 hoared2     Hoary ~ Acanth~ L693~ Mount ~ 2019~       1  42.5 -76.4
#>  5 whcspa      White-~ Zonotr~ L137~ Sapsuc~ 2019~       1  42.5 -76.5
#>  6 grycat      Gray C~ Dumete~ L799~ Cornel~ 2019~       1  42.5 -76.5
#>  7 evegro      Evenin~ Coccot~ L132~ Fall C~ 2019~       1  42.5 -76.5
#>  8 evegro      Evenin~ Coccot~ L842~ 641 Mi~ 2019~       8  42.4 -76.3
#>  9 tufduc      Tufted~ Aythya~ L140~ East S~ 2019~       1  42.5 -76.5
#> 10 tufduc      Tufted~ Aythya~ L140~ East S~ 2019~       1  42.5 -76.5
#> # ... with 79 more rows, and 3 more variables: obsValid <lgl>,
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

## Information on a given hotspot

Obtain detailed information on any valid eBird hotspot


```r
ebirdhotspotinfo("L99381")
#> # A tibble: 1 x 16
#>   locId name  latitude longitude countryCode countryName subnational1Name
#>   <chr> <chr>    <dbl>     <dbl> <chr>       <chr>       <chr>           
#> 1 L993~ Stew~     42.5     -76.5 US          United Sta~ New York        
#> # ... with 9 more variables: subNational1Code <chr>,
#> #   Subnational2Code <chr>, subnational2Name <chr>, isHotspot <lgl>,
#> #   name2 <chr>, latitude2 <dbl>, longitude2 <dbl>,
#> #   hierarchical.name <chr>, locId2 <chr>
ebirdhotspotinfo("L99381")$hierarchical.name
#> [1] "Stewart Park, Tompkins, New York, US"
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
 - [x]     Hotspot Info: `ebirdhotspotinfo()`
 - [x]    Region Info: `ebirdregioninfo()`
 - [ ]     Sub Region List


## Meta

* Please [report any issues or bugs](https://github.com/ropensci/rebird/issues).
* License: MIT
* Get citation information for `rebird` in R doing `citation(package = 'rebird')`


[![ropensci_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)


