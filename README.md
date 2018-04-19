
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rebird: wrapper to the eBird API

[![Build
Status](https://api.travis-ci.org/ropensci/rebird.png)](https://travis-ci.org/ropensci/rebird)
[![Build
status](https://ci.appveyor.com/api/projects/status/s3dobn991c20t2kg?svg=true)](https://ci.appveyor.com/project/sckott/rebird)
[![Coverage
Status](https://coveralls.io/repos/ropensci/rebird/badge.svg)](https://coveralls.io/r/ropensci/rebird)
[![rstudio mirror
downloads](http://cranlogs.r-pkg.org/badges/rebird)](https://github.com/metacran/cranlogs.app)
[![cran
version](http://www.r-pkg.org/badges/version/rebird)](https://cran.r-project.org/package=rebird/)

`reBird` is a package to interface with the eBird webservices.

eBird is a real-time, online bird checklist program. For more
information, visit their website: <http://www.ebird.org>

The API for the eBird webservices can be accessed here:
<https://confluence.cornell.edu/display/CLOISAPI/eBird+API+1.1>

## Install

You can install the stable version from CRAN

``` r
install.packages("rebird")
```

Or the development version from Github

``` r
install.packages("devtools")
devtools::install_github("ropensci/rebird")
```

# Direct use of `rebird`

Load the package

``` r
library("rebird")
```

## Sightings at location determined by latitude/longitude

Search for bird occurrences by latitude and longitude point

``` r
ebirdgeo(species = 'spinus tristis', lat = 42, lng = -76)
#> Warning in ebird_GET(url, args, ...): Unknown species: spinus%20tristis
#> [1] NA
```

## Recent observations at a region

Search for bird occurrences by region and species name

``` r
ebirdregion(region = 'US', species = 'Setophaga caerulescens')
#> Warning in ebird_GET(url, args, ...): Unknown species: Setophaga
#> %20caerulescens
#> [1] NA
```

## Recent observations at hotspots

Search for bird occurrences by region

``` r
ebirdhotspot(locID = c('L99381','L99382'))
#> # A tibble: 125 x 12
#>      lng locName   sciName    obsValid locationPrivate obsDt   obsReviewed
#>    <dbl> <chr>     <chr>      <lgl>    <lgl>           <chr>   <lgl>      
#>  1 -76.5 Stewart ~ Branta ca~ TRUE     FALSE           2018-0~ FALSE      
#>  2 -76.5 Stewart ~ Spatula d~ TRUE     FALSE           2018-0~ FALSE      
#>  3 -76.5 Stewart ~ Spatula c~ TRUE     FALSE           2018-0~ FALSE      
#>  4 -76.5 Stewart ~ Anas plat~ TRUE     FALSE           2018-0~ FALSE      
#>  5 -76.5 Stewart ~ Aythya co~ TRUE     FALSE           2018-0~ FALSE      
#>  6 -76.5 Stewart ~ Aythya af~ TRUE     FALSE           2018-0~ FALSE      
#>  7 -76.5 Stewart ~ Bucephala~ TRUE     FALSE           2018-0~ FALSE      
#>  8 -76.5 Stewart ~ Lophodyte~ TRUE     FALSE           2018-0~ FALSE      
#>  9 -76.5 Stewart ~ Mergus me~ TRUE     FALSE           2018-0~ FALSE      
#> 10 -76.5 Stewart ~ Oxyura ja~ TRUE     FALSE           2018-0~ FALSE      
#> # ... with 115 more rows, and 5 more variables: comName <chr>, lat <dbl>,
#> #   locID <chr>, locId <chr>, howMany <int>
```

## Frequency of observations at hotspots or regions

Obtain historical frequencies of bird occurrences by hotspot or region

``` r
ebirdfreq(loctype = 'hotspots', loc = 'L196159')
#> # A tibble: 8,976 x 4
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
#>  9 Blue-winged/Cinnamon Teal   January-1     0.           27.
#> 10 Northern Shoveler           January-1     0.704        27.
#> # ... with 8,966 more rows
```

# `rebird` and other packages

## How to use `rebird`

This package is part of a richer suite called [spocc - Species
Occurrence Data](https://github.com/ropensci/spocc), along with several
other packages, that provide access to occurrence records from multiple
databases. We recommend using `spocc` as the primary R interface to
`rebird` unless your needs are limited to this single source.

## `auk` vs. `rebird`

Those interested in eBird data may also want to consider
[`auk`](https://github.com/CornellLabofOrnithology/auk), an R package
that helps extracting and processing the whole eBird dataset. The
functions in `rebird` are faster but mostly limited to accessing recent
(i.e. within the last 30 days) observations, although `ebirdfreq()` does
provide historical frequency of observation data. In contrast, `auk`
gives access to the full set of ~ 500 million eBird observations. For
most ecological applications, users will require `auk`; however, for
some use cases, e.g. building tools for birders, `rebird` provides a
quicker and easier way to access data. `rebird` and `auk` are both part
of the rOpenSci project.

## Meta

  - Please [report any issues or
    bugs](https://github.com/ropensci/rebird/issues).
  - License: MIT
  - Get citation information for `rebird` in R doing `citation(package =
    'rebird')`

[![ropensci\_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
