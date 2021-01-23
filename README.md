
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rebird: wrapper to the eBird API

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build
Status](https://api.travis-ci.org/ropensci/rebird.png)](https://travis-ci.org/ropensci/rebird)
[![Build
status](https://ci.appveyor.com/api/projects/status/s3dobn991c20t2kg?svg=true)](https://ci.appveyor.com/project/sckott/rebird)
[![cran
checks](https://cranchecks.info/badges/worst/rebird)](https://cranchecks.info/pkgs/rebird)
[![Coverage
Status](https://coveralls.io/repos/ropensci/rebird/badge.svg)](https://coveralls.io/r/ropensci/rebird)
[![rstudio mirror
downloads](http://cranlogs.r-pkg.org/badges/rebird)](https://github.com/metacran/cranlogs.app)
[![cran
version](http://www.r-pkg.org/badges/version/rebird)](https://cran.r-project.org/package=rebird/)

`rebird` is a package to interface with the eBird webservices.

eBird is a real-time, online bird checklist program. For more
information, visit their website: <http://www.ebird.org>

The API for the eBird webservices can be accessed here:
<https://documenter.getpostman.com/view/664302/S1ENwy59?version=latest>

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

Load the package:

``` r
library("rebird")
```

The [eBird API
server](https://documenter.getpostman.com/view/664302/S1ENwy59?version=latest)
has been updated and thus there are a couple major changes in the way
`rebird` works. API requests to eBird now require users to provide an
API key, which is linked to your eBird user account. You can pass it to
the ‘key’ argument in `rebird` functions, but we highly recommend
storing it as an environment variable called EBIRD\_KEY in your
.Renviron file. If you don’t have a key, you can obtain one from
<https://ebird.org/api/keygen>.

You can keep your .Renviron file in your global R home directory
(`R.home()`), your user’s home directory (`Sys.getenv("HOME")`), or your
current working directory (`getwd()`). Remember that .Renviron is loaded
once when you start R, so if you add your API key to the file you will
have to restart your R session. See
<https://csgillespie.github.io/efficientR/r-startup.html> for more
information on R’s startup files.

Furthermore, functions now use species codes, rather than scientific
names, for species-specific requests. We’ve made the switch easy by
providing the `species_code` function, which converts a scientific name
to its species code:

``` r
species_code('sula variegata')
#> Peruvian Booby (Sula variegata): perboo1
#> [1] "perboo1"
```

The `species_code` function can be called within other `rebird`
functions, or the species code can be specified directly.

## Sightings at location determined by latitude/longitude

Search for bird occurrences by latitude and longitude point

``` r
ebirdgeo(species = species_code('spinus tristis'), lat = 42, lng = -76)
#> American Goldfinch (Spinus tristis): amegfi
#> # A tibble: 44 x 13
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 amegfi      Americ… Spinus… L107… 2403 S… 2020…       8  41.9 -75.8
#>  2 amegfi      Americ… Spinus… L116… Bruce … 2020…      12  41.9 -75.8
#>  3 amegfi      Americ… Spinus… L229… Imperi… 2020…       1  42.1 -76.0
#>  4 amegfi      Americ… Spinus… L223… 9 Chri… 2020…       4  42.1 -75.9
#>  5 amegfi      Americ… Spinus… L116… Lamour… 2020…      NA  42.1 -76.0
#>  6 amegfi      Americ… Spinus… L197… esther… 2020…       3  42.1 -75.9
#>  7 amegfi      Americ… Spinus… L275… "Home " 2020…       5  42.1 -76.0
#>  8 amegfi      Americ… Spinus… L611… Hillcr… 2020…       2  42.1 -75.9
#>  9 amegfi      Americ… Spinus… L978… Murphy… 2020…       5  42.1 -76.0
#> 10 amegfi      Americ… Spinus… L110… 913 Ch… 2020…       2  42.1 -76.0
#> # … with 34 more rows, and 4 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>, subId <chr>
```

## Recent observations at a region

Search for bird occurrences by region and species name

``` r
ebirdregion(loc = 'US', species = 'btbwar')
#> # A tibble: 57 x 13
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 btbwar      Black-… Setoph… L127… Mead B… 2020…       1  28.6 -81.4
#>  2 btbwar      Black-… Setoph… L567… "Palme… 2020…       1  28.9 -81.3
#>  3 btbwar      Black-… Setoph… L110… 8220 S… 2020…       1  25.6 -80.3
#>  4 btbwar      Black-… Setoph… L111… Cherry… 2020…       1  35.3 -82.8
#>  5 btbwar      Black-… Setoph… L542… Indian… 2020…       1  26.5 -80.1
#>  6 btbwar      Black-… Setoph… L816… Kissim… 2020…       1  27.6 -81.0
#>  7 btbwar      Black-… Setoph… L722… Sereno… 2020…       2  26.4 -80.1
#>  8 btbwar      Black-… Setoph… L339… Flat T… 2020…       2  35.6 -82.4
#>  9 btbwar      Black-… Setoph… L558… Pine W… 2020…       1  25.6 -80.4
#> 10 btbwar      Black-… Setoph… L336… Wildwo… 2020…       1  27.9 -81.8
#> # … with 47 more rows, and 4 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>, subId <chr>
```

## Recent observations at hotspots

Search for bird occurrences by a given hotspot

``` r
ebirdregion(loc = 'L99381')
#> # A tibble: 74 x 13
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 nrwswa      Northe… Stelgi… L993… Stewar… 2020…       1  42.5 -76.5
#>  2 cangoo      Canada… Branta… L993… Stewar… 2020…      14  42.5 -76.5
#>  3 wooduc      Wood D… Aix sp… L993… Stewar… 2020…       1  42.5 -76.5
#>  4 norsho      Northe… Spatul… L993… Stewar… 2020…       1  42.5 -76.5
#>  5 mallar3     Mallard Anas p… L993… Stewar… 2020…       4  42.5 -76.5
#>  6 rinduc      Ring-n… Aythya… L993… Stewar… 2020…       2  42.5 -76.5
#>  7 lessca      Lesser… Aythya… L993… Stewar… 2020…      12  42.5 -76.5
#>  8 buffle      Buffle… Buceph… L993… Stewar… 2020…      32  42.5 -76.5
#>  9 rudduc      Ruddy … Oxyura… L993… Stewar… 2020…      11  42.5 -76.5
#> 10 rocpig      Rock P… Columb… L993… Stewar… 2020…       1  42.5 -76.5
#> # … with 64 more rows, and 4 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>, subId <chr>
```

## Nearest observations of a species

Search for a species’ occurrences near a given latitude and longitude

``` r
nearestobs(species_code('branta canadensis'), 42, -76)
#> Canada Goose (Branta canadensis): cangoo
#> # A tibble: 59 x 13
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 cangoo      Canada… Branta… L274… River … 2020…       3  42.1 -76.0
#>  2 cangoo      Canada… Branta… L247… Conflu… 2020…       5  42.1 -75.9
#>  3 cangoo      Canada… Branta… L166… Chugnu… 2020…       5  42.1 -76.0
#>  4 cangoo      Canada… Branta… L100… Brick … 2020…       1  42.1 -76.2
#>  5 cangoo      Canada… Branta… L111… 526 Co… 2020…       1  42.0 -76.0
#>  6 cangoo      Canada… Branta… L116… Murphy… 2020…       4  42.1 -76.0
#>  7 cangoo      Canada… Branta… L453… Waterm… 2020…       6  42.1 -76.2
#>  8 cangoo      Canada… Branta… L505… Boland… 2020…      18  42.2 -75.9
#>  9 cangoo      Canada… Branta… L978… Murphy… 2020…      11  42.1 -76.0
#> 10 cangoo      Canada… Branta… L201… Conflu… 2020…      15  42.1 -76.3
#> # … with 49 more rows, and 4 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>, subId <chr>
```

## Frequency of observations at hotspots or regions

Obtain historical frequencies of bird occurrences by hotspot or region

``` r
ebirdfreq(loctype = 'hotspots', loc = 'L196159')
#> # A tibble: 9,600 x 4
#>    comName                     monthQt   frequency sampleSize
#>    <chr>                       <chr>         <dbl>      <dbl>
#>  1 Snow Goose                  January-1     0             36
#>  2 Greater White-fronted Goose January-1     0             36
#>  3 Cackling Goose              January-1     0             36
#>  4 Canada Goose                January-1     0             36
#>  5 Cackling/Canada Goose       January-1     0             36
#>  6 Trumpeter Swan              January-1     0             36
#>  7 Wood Duck                   January-1     0.139         36
#>  8 Blue-winged Teal            January-1     0             36
#>  9 Cinnamon Teal               January-1     0             36
#> 10 Blue-winged/Cinnamon Teal   January-1     0             36
#> # … with 9,590 more rows
```

## Recent notable sightings

Search for notable sightings at a given latitude and longitude

``` r
ebirdnotable(lat = 42, lng = -70)
#> # A tibble: 1,322 x 13
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 norbob      Northe… Colinu… L840… 43 2nd… 2020…       1  41.0 -72.0
#>  2 monpar      Monk P… Myiops… L111… 584 So… 2020…       1  41.6 -72.8
#>  3 buggna      Blue-g… Poliop… L997… 1063 S… 2020…       1  41.5 -72.9
#>  4 merlin      Merlin  Falco … L152… Bates … 2020…       1  44.1 -70.2
#>  5 louwat      Louisi… Parkes… L152… Henwoo… 2020…       1  43.1 -72.5
#>  6 buggna      Blue-g… Poliop… L207… Moose … 2020…       1  42.1 -71.2
#>  7 sancra      Sandhi… Antigo… L452… Bolton… 2020…       1  42.5 -71.6
#>  8 vesspa      Vesper… Pooece… L418… McCart… 2020…       1  42.2 -71.3
#>  9 buggna      Blue-g… Poliop… L418… McCart… 2020…       1  42.2 -71.3
#> 10 amebit      Americ… Botaur… L392… North … 2020…       1  41.3 -70.1
#> # … with 1,312 more rows, and 4 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>, subId <chr>
```

or a region

``` r
ebirdnotable(locID = 'US-NY-109')
#> # A tibble: 51 x 13
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 y00478      Icelan… Larus … L353… Salt P… 2020…       1  42.5 -76.5
#>  2 whcspa      White-… Zonotr… L137… Sapsuc… 2020…       1  42.5 -76.5
#>  3 caster1     Caspia… Hydrop… L996… Myers … 2020…       1  42.5 -76.6
#>  4 caster1     Caspia… Hydrop… L996… Myers … 2020…       1  42.5 -76.6
#>  5 caster1     Caspia… Hydrop… L996… Myers … 2020…       1  42.5 -76.6
#>  6 yelwar      Yellow… Setoph… L441… AviTra… 2020…       1  42.3 -76.4
#>  7 caster1     Caspia… Hydrop… L996… Myers … 2020…       2  42.5 -76.6
#>  8 caster1     Caspia… Hydrop… L353… Salt P… 2020…       1  42.5 -76.5
#>  9 brwhaw      Broad-… Buteo … L441… AviTra… 2020…       2  42.3 -76.4
#> 10 houwre      House … Troglo… L997… Ilion   2020…       1  42.4 -76.5
#> # … with 41 more rows, and 4 more variables: obsValid <lgl>,
#> #   obsReviewed <lgl>, locationPrivate <lgl>, subId <chr>
```

## Historic Observations

Obtain a list of species reported on a specific date in a given region

``` r
ebirdhistorical(loc = 'US-VA-003', date = '2019-02-14',max = 10)
#> # A tibble: 10 x 13
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 cangoo      Canada… Branta… L139… Lickin… 2019…      30  38.1 -78.7
#>  2 mallar3     Mallard Anas p… L139… Lickin… 2019…       5  38.1 -78.7
#>  3 gnwtea      Green-… Anas c… L139… Lickin… 2019…       8  38.1 -78.7
#>  4 killde      Killde… Charad… L139… Lickin… 2019…       1  38.1 -78.7
#>  5 baleag      Bald E… Haliae… L139… Lickin… 2019…       1  38.1 -78.7
#>  6 belkin1     Belted… Megace… L139… Lickin… 2019…       1  38.1 -78.7
#>  7 carwre      Caroli… Thryot… L139… Lickin… 2019…       1  38.1 -78.7
#>  8 whtspa      White-… Zonotr… L139… Lickin… 2019…       2  38.1 -78.7
#>  9 norcar      Northe… Cardin… L139… Lickin… 2019…       1  38.1 -78.7
#> 10 canvas      Canvas… Aythya… L331… Montic… 2019…      19  38.0 -78.5
#> # … with 4 more variables: obsValid <lgl>, obsReviewed <lgl>,
#> #   locationPrivate <lgl>, subId <chr>
```

or a hotspot

``` r
ebirdhistorical(loc = 'L196159', date = '2019-02-14', fieldSet = 'full')
#> # A tibble: 14 x 27
#>    speciesCode comName sciName locId locName obsDt howMany   lat   lng
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl>
#>  1 annhum      Anna's… Calypt… L196… Vancou… 2019…       4  49.3 -123.
#>  2 ribgul      Ring-b… Larus … L196… Vancou… 2019…       4  49.3 -123.
#>  3 glwgul      Glauco… Larus … L196… Vancou… 2019…      29  49.3 -123.
#>  4 norcro      Northw… Corvus… L196… Vancou… 2019…     100  49.3 -123.
#>  5 bkcchi      Black-… Poecil… L196… Vancou… 2019…      16  49.3 -123.
#>  6 bushti      Bushtit Psaltr… L196… Vancou… 2019…      20  49.3 -123.
#>  7 pacwre1     Pacifi… Troglo… L196… Vancou… 2019…       1  49.3 -123.
#>  8 houfin      House … Haemor… L196… Vancou… 2019…       2  49.3 -123.
#>  9 purfin      Purple… Haemor… L196… Vancou… 2019…       3  49.3 -123.
#> 10 amegfi      Americ… Spinus… L196… Vancou… 2019…      15  49.3 -123.
#> 11 daejun      Dark-e… Junco … L196… Vancou… 2019…      37  49.3 -123.
#> 12 sonspa      Song S… Melosp… L196… Vancou… 2019…      12  49.3 -123.
#> 13 spotow      Spotte… Pipilo… L196… Vancou… 2019…       1  49.3 -123.
#> 14 rewbla      Red-wi… Agelai… L196… Vancou… 2019…       6  49.3 -123.
#> # … with 18 more variables: obsValid <lgl>, obsReviewed <lgl>,
#> #   locationPrivate <lgl>, subId <chr>, subnational2Code <chr>,
#> #   subnational2Name <chr>, subnational1Code <chr>,
#> #   subnational1Name <chr>, countryCode <chr>, countryName <chr>,
#> #   userDisplayName <chr>, obsId <chr>, checklistId <chr>,
#> #   presenceNoted <lgl>, hasComments <lgl>, firstName <chr>,
#> #   lastName <chr>, hasRichMedia <lgl>
```

## Information on a given region or hotspot

Obtain detailed information on any valid eBird region

``` r
ebirdregioninfo("CA-BC-GV")
#> # A tibble: 1 x 5
#>   region                                     minX  maxX  minY  maxY
#>   <chr>                                     <dbl> <dbl> <dbl> <dbl>
#> 1 Metro Vancouver, British Columbia, Canada -123. -122.  49.0  49.6
```

or hotspot

``` r
ebirdregioninfo("L196159")
#> # A tibble: 1 x 16
#>   locId name  latitude longitude countryCode countryName subnational1Name
#>   <chr> <chr>    <dbl>     <dbl> <chr>       <chr>       <chr>           
#> 1 L196… Vanc…     49.3     -123. CA          Canada      British Columbia
#> # … with 9 more variables: subnational1Code <chr>, subnational2Code <chr>,
#> #   subnational2Name <chr>, isHotspot <lgl>, locName <chr>, lat <dbl>,
#> #   lng <dbl>, hierarchicalName <chr>, locID <chr>
```

## Checklist Feed

Obtain a list of checklists submitted on a given date at a region or
hotspot

``` r
ebirdchecklistfeed(loc = "L207391", date = "2020-03-24", max = 5)
#> # A tibble: 5 x 8
#>   locId  subId  userDisplayName numSpecies obsDt obsTime subID loc         
#>   <chr>  <chr>  <chr>                <int> <chr> <chr>   <chr> <chr>       
#> 1 L2073… S6617… David Wood              10 24 M… 14:47   S661… L207391,Mt.…
#> 2 L2073… S6617… Sofia Prado-Ir…         15 24 M… 14:31   S661… L207391,Mt.…
#> 3 L2073… S6619… Jeffrey Gantz           19 24 M… 13:30   S661… L207391,Mt.…
#> 4 L2073… S6617… Ann Gurka               21 24 M… 13:00   S661… L207391,Mt.…
#> 5 L2073… S6618… Jason Barcus            24 24 M… 07:30   S661… L207391,Mt.…
```

## `rebird` and other packages

### How to use `rebird`

This package is part of a richer suite called [spocc - Species
Occurrence Data](https://github.com/ropensci/spocc), along with several
other packages, that provide access to occurrence records from multiple
databases. We recommend using `spocc` as the primary R interface to
`rebird` unless your needs are limited to this single source.

### `auk` vs. `rebird`

Those interested in eBird data may also want to consider
[`auk`](https://github.com/CornellLabofOrnithology/auk), an R package
that helps extracting and processing the whole eBird dataset. The
functions in `rebird` are faster but mostly limited to accessing recent
(i.e. within the last 30 days) observations, although `ebirdfreq()` does
provide historical frequency of observation data. In contrast, `auk`
gives access to the full set of \~ 500 million eBird observations. For
most ecological applications, users will require `auk`; however, for
some use cases, e.g. building tools for birders, `rebird` provides a
quicker and easier way to access data. `rebird` and `auk` are both part
of the rOpenSci project.

## API requests covered by `rebird`

The 2.0 APIs have considerably been expanded from the previous version,
and `rebird` only covers some of them. The webservices covered are
listed below; if you’d like to contribute wrappers to APIs not yet
covered by this package, feel free to submit a pull request\!

### data/obs

  - [x] Recent observations in a region: `ebirdregion()`
  - [x] Recent notable observations in a region: `ebirdnotable()`
  - [x] Recent observations of a species in a region: `ebirdregion()`
  - [x] Recent nearby observations: `ebirdgeo()`
  - [x] Recent nearby observations of a species: `ebirdgeo()`
  - [x] Nearest observations of a species: `nearestobs()`
  - [x] Recent nearby notable observations: `ebirdnotable()`
  - [x] Historic observations on a date: `ebirdhistorical()`

### product

  - [ ] Top 100
  - [x] Checklist feed on a date: `ebirdchecklistfeed()`
  - [ ] Recent checklists feed
  - [ ] Regional statistics on a date
  - [ ] View Checklist BETA

### ref/geo

  - [ ] Adjacent Regions

### ref/hotspot

  - [x] Hotspots in a region: `ebirdhotspotlist()`
  - [x] Nearby hotspots: `ebirdhotspotlist()`
  - [ ] Hotspot info

### ref/taxonomy

  - [x] eBird Taxonomy: `ebirdtaxonomy()`
  - [ ] Taxonomic Forms
  - [ ] Taxonomy Versions
  - [ ] Taxonomic Groups

### ref/region

  - [x] Hotspot Info: `ebirdregioninfo()`
  - [x] Region Info: `ebirdregioninfo()`
  - [ ] Sub Region List

## Meta

  - Please [report any issues or
    bugs](https://github.com/ropensci/rebird/issues).
  - License: MIT
  - Get citation information for `rebird` in R doing `citation(package =
    'rebird')`
  - Please note that the ‘rebird’ project is released with a
    [Contributor Code of
    Conduct](https://github.com/ropensci/rebird/blob/master/CODE_OF_CONDUCT.md).
    By contributing to this project, you agree to abide by its terms.

[![ropensci\_footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
