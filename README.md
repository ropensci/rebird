
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rebird: wrapper to the eBird API

<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/)
[![R-CMD-check](https://github.com/ropensci/rebird/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ropensci/rebird/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/ropensci/rebird/branch/master/graph/badge.svg)](https://app.codecov.io/gh/ropensci/rebird?branch=master)
[![rstudio mirror
downloads](https://cranlogs.r-pkg.org/badges/rebird)](https://github.com/r-hub/cranlogs.app)
[![cran
version](https://www.r-pkg.org/badges/version/rebird)](https://cran.r-project.org/package=rebird/)
[![taxonomy-check](https://github.com/ropensci/rebird/actions/workflows/taxonomy-check.yaml/badge.svg)](https://github.com/ropensci/rebird/actions/workflows/taxonomy-check.yaml)

<!-- badges: end -->

`rebird` is a package to interface with the eBird webservices.

eBird is a real-time, online bird checklist program. For more
information, visit their website: <https://ebird.org/home>

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
requires users to provide an API key, which is linked to your eBird user
account. You can pass it to the ‘key’ argument in `rebird` functions,
but we highly recommend storing it as an environment variable called
EBIRD_KEY in your .Renviron file. If you don’t have a key, you can
obtain one from <https://ebird.org/api/keygen>.

You can keep your .Renviron file in your global R home directory
(`R.home()`), your user’s home directory (`Sys.getenv("HOME")`), or your
current working directory (`getwd()`). Remember that .Renviron is loaded
once when you start R, so if you add your API key to the file you will
have to restart your R session. See `?Startup` for more information on
R’s startup files.

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

## eBird Taxonomy

The eBird taxonomy is internally stored in `rebird` and can be called
using

``` r
rebird::tax
#> # A tibble: 17,064 × 15
#>    sciName     comName speciesCode category taxonOrder bandingCodes comNameCodes
#>    <chr>       <chr>   <chr>       <chr>         <dbl> <chr>        <chr>       
#>  1 Struthio c… Common… ostric2     species           2 <NA>         COOS        
#>  2 Struthio m… Somali… ostric3     species           7 <NA>         SOOS        
#>  3 Struthio c… Common… y00934      slash             8 <NA>         SOOS,COOS   
#>  4 Rhea ameri… Greate… grerhe1     species          10 <NA>         GRRH        
#>  5 Rhea penna… Lesser… lesrhe2     species          16 <NA>         LERH        
#>  6 Rhea penna… Lesser… lesrhe4     issf             17 <NA>         LERH        
#>  7 Rhea penna… Lesser… lesrhe3     issf             20 <NA>         LERH        
#>  8 Nothocercu… Tawny-… tabtin1     species          22 <NA>         TBTI        
#>  9 Nothocercu… Highla… higtin1     species          23 HITI         <NA>        
#> 10 Nothocercu… Highla… higtin2     issf             24 <NA>         HITI        
#> # ℹ 17,054 more rows
#> # ℹ 8 more variables: sciNameCodes <chr>, order <chr>, familyCode <chr>,
#> #   familyComName <chr>, familySciName <chr>, reportAs <chr>, extinct <lgl>,
#> #   extinctYear <int>
```

While the internal taxonomy is kept up to date with each package
release, it could be outdated if a new taxonomy is made available before
the package is updated. You can obtain the latest eBird taxonomy by

``` r
new_tax <- ebirdtaxonomy()
```

## Sightings at location determined by latitude/longitude

Search for bird occurrences by latitude and longitude point

``` r
ebirdgeo(species = species_code('spinus tristis'), lat = 42, lng = -76)
#> American Goldfinch (Spinus tristis): amegfi
#> # A tibble: 31 × 13
#>    speciesCode comName  sciName locId locName obsDt howMany   lat   lng obsValid
#>    <chr>       <chr>    <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl> <lgl>   
#>  1 amegfi      America… Spinus… L144… Heart … 2024…      10  41.8 -75.8 TRUE    
#>  2 amegfi      America… Spinus… L982… Hazel … 2024…       1  42.1 -76.1 TRUE    
#>  3 amegfi      America… Spinus… L243… 71 Wil… 2024…      12  42.2 -75.9 TRUE    
#>  4 amegfi      America… Spinus… L124… Happy … 2024…       7  42.1 -75.9 TRUE    
#>  5 amegfi      America… Spinus… L197… esther… 2024…       4  42.1 -75.9 TRUE    
#>  6 amegfi      America… Spinus… L299… 184 Sw… 2024…       4  42.2 -76.0 TRUE    
#>  7 amegfi      America… Spinus… L300… 194 Sw… 2024…       6  42.2 -75.9 TRUE    
#>  8 amegfi      America… Spinus… L210… 1099 P… 2024…       2  42.1 -76.0 TRUE    
#>  9 amegfi      America… Spinus… L131… Vestal  2024…       1  42.1 -76.1 TRUE    
#> 10 amegfi      America… Spinus… L447… Bingha… 2024…       2  42.1 -76.0 TRUE    
#> # ℹ 21 more rows
#> # ℹ 3 more variables: obsReviewed <lgl>, locationPrivate <lgl>, subId <chr>
```

## Recent observations at a region

Search for bird occurrences by region and species name

``` r
ebirdregion(loc = 'US', species = 'btbwar')
#> # A tibble: 15 × 13
#>    speciesCode comName sciName locId locName obsDt howMany   lat    lng obsValid
#>    <chr>       <chr>   <chr>   <chr> <chr>   <chr>   <int> <dbl>  <dbl> <lgl>   
#>  1 btbwar      Black-… Setoph… L129… Cave C… 2024…       1  31.9 -109.  TRUE    
#>  2 btbwar      Black-… Setoph… L584… Treasu… 2024…       1  27.8  -80.4 TRUE    
#>  3 btbwar      Black-… Setoph… L300… 11300 … 2024…       1  27.8  -80.4 TRUE    
#>  4 btbwar      Black-… Setoph… L127… Lettuc… 2024…       1  28.1  -82.4 TRUE    
#>  5 btbwar      Black-… Setoph… L195… 1 My H… 2024…       1  27.0  -80.1 TRUE    
#>  6 btbwar      Black-… Setoph… L582… Southe… 2024…       1  25.4  -80.6 TRUE    
#>  7 btbwar      Black-… Setoph… L661… Memori… 2024…       1  29.6  -95.6 TRUE    
#>  8 btbwar      Black-… Setoph… L214… Saxapa… 2024…       1  35.9  -79.3 TRUE    
#>  9 btbwar      Black-… Setoph… L149… Jackso… 2024…       1  30.3  -81.5 TRUE    
#> 10 btbwar      Black-… Setoph… L127… Key We… 2024…       2  24.6  -81.7 TRUE    
#> 11 btbwar      Black-… Setoph… L127… Key La… 2024…       1  25.2  -80.4 TRUE    
#> 12 btbwar      Black-… Setoph… L385… My Yard 2024…       1  25.7  -80.3 TRUE    
#> 13 btbwar      Black-… Setoph… L823… J. N. … 2024…       1  26.5  -82.1 TRUE    
#> 14 btbwar      Black-… Setoph… L682… Univer… 2024…       1  25.7  -80.3 TRUE    
#> 15 btbwar      Black-… Setoph… L130… Castle… 2024…       1  29.6  -81.2 TRUE    
#> # ℹ 3 more variables: obsReviewed <lgl>, locationPrivate <lgl>, subId <chr>
```

## Recent observations at hotspots

Search for bird occurrences by a given hotspot

``` r
ebirdregion(loc = 'L99381')
#> # A tibble: 62 × 14
#>    speciesCode comName  sciName locId locName obsDt howMany   lat   lng obsValid
#>    <chr>       <chr>    <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl> <lgl>   
#>  1 gadwal      Gadwall  Mareca… L993… Stewar… 2024…       6  42.5 -76.5 TRUE    
#>  2 amewig      America… Mareca… L993… Stewar… 2024…       2  42.5 -76.5 TRUE    
#>  3 mallar3     Mallard  Anas p… L993… Stewar… 2024…      25  42.5 -76.5 TRUE    
#>  4 ambduc      America… Anas r… L993… Stewar… 2024…       2  42.5 -76.5 TRUE    
#>  5 commer      Common … Mergus… L993… Stewar… 2024…       6  42.5 -76.5 TRUE    
#>  6 killde      Killdeer Charad… L993… Stewar… 2024…       2  42.5 -76.5 TRUE    
#>  7 ribgul      Ring-bi… Larus … L993… Stewar… 2024…      NA  42.5 -76.5 TRUE    
#>  8 gbbgul      Great B… Larus … L993… Stewar… 2024…      NA  42.5 -76.5 TRUE    
#>  9 doccor      Double-… Nannop… L993… Stewar… 2024…       2  42.5 -76.5 TRUE    
#> 10 amecro      America… Corvus… L993… Stewar… 2024…       4  42.5 -76.5 TRUE    
#> # ℹ 52 more rows
#> # ℹ 4 more variables: obsReviewed <lgl>, locationPrivate <lgl>, subId <chr>,
#> #   exoticCategory <chr>
```

## Nearest observations of a species

Search for a species’ occurrences near a given latitude and longitude

``` r
nearestobs(species_code('branta canadensis'), 42, -76)
#> Canada Goose (Branta canadensis): cangoo
#> # A tibble: 67 × 13
#>    speciesCode comName  sciName locId locName obsDt howMany   lat   lng obsValid
#>    <chr>       <chr>    <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl> <lgl>   
#>  1 cangoo      Canada … Branta… L179… "Bingh… 2024…       2  42.1 -75.9 TRUE    
#>  2 cangoo      Canada … Branta… L144… "Heart… 2024…       2  41.8 -75.8 TRUE    
#>  3 cangoo      Canada … Branta… L116… "Lake … 2024…       2  41.8 -75.9 TRUE    
#>  4 cangoo      Canada … Branta… L465… "Bingh… 2024…       8  42.1 -75.9 TRUE    
#>  5 cangoo      Canada … Branta… L300… "Our L… 2024…       2  42.1 -75.9 TRUE    
#>  6 cangoo      Canada … Branta… L145… "Lake … 2024…       2  41.8 -75.8 TRUE    
#>  7 cangoo      Canada … Branta… L204… "McDon… 2024…       4  41.8 -75.9 TRUE    
#>  8 cangoo      Canada … Branta… L936… "Bolan… 2024…       6  42.2 -75.9 TRUE    
#>  9 cangoo      Canada … Branta… L186… "Otsin… 2024…      10  42.1 -75.9 TRUE    
#> 10 cangoo      Canada … Branta… L717… "PA-SQ… 2024…       2  41.9 -75.9 TRUE    
#> # ℹ 57 more rows
#> # ℹ 3 more variables: obsReviewed <lgl>, locationPrivate <lgl>, subId <chr>
```

<!--
## Frequency of observations at hotspots or regions

Obtain historical frequencies of bird occurrences by hotspot or region


```r
# ebirdfreq(loctype = 'hotspots', loc = 'L196159')
```
-->

## Recent notable sightings

Search for notable sightings at a given latitude and longitude

``` r
ebirdnotable(lat = 42, lng = -70)
#> # A tibble: 3,200 × 14
#>    speciesCode comName  sciName locId locName obsDt howMany   lat   lng obsValid
#>    <chr>       <chr>    <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl> <lgl>   
#>  1 osprey      Osprey   Pandio… L300… 100 Gr… 2024…       1  41.7 -72.6 FALSE   
#>  2 fiespa      Field S… Spizel… L514… Pinnac… 2024…       1  43.1 -72.4 FALSE   
#>  3 chispa      Chippin… Spizel… L586… High S… 2024…       2  42.9 -70.8 FALSE   
#>  4 palwar3     Palm Wa… Setoph… L250… Hampto… 2024…       1  42.9 -70.8 FALSE   
#>  5 bkhgul      Black-h… Chroic… L829… Dowses… 2024…       5  41.6 -70.4 FALSE   
#>  6 rosgoo      Ross's … Anser … L279… Hardar… 2024…       1  42.9 -70.8 FALSE   
#>  7 osprey      Osprey   Pandio… L675… Longme… 2024…       2  42.1 -72.6 FALSE   
#>  8 yebsap      Yellow-… Sphyra… L458… Waldob… 2024…       1  44.1 -69.4 FALSE   
#>  9 yebsap      Yellow-… Sphyra… L458… Waldob… 2024…       1  44.1 -69.4 FALSE   
#> 10 baleag      Bald Ea… Haliae… L226… W Basi… 2024…       1  41.4 -70.8 FALSE   
#> # ℹ 3,190 more rows
#> # ℹ 4 more variables: obsReviewed <lgl>, locationPrivate <lgl>, subId <chr>,
#> #   exoticCategory <chr>
```

or a region

``` r
ebirdnotable(locID = 'US-NY-109')
#> # A tibble: 84 × 13
#>    speciesCode comName  sciName locId locName obsDt howMany   lat   lng obsValid
#>    <chr>       <chr>    <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl> <lgl>   
#>  1 veggul1     Herring… Larus … L212… Steven… 2024…       1  42.4 -76.4 FALSE   
#>  2 sancra      Sandhil… Antigo… L212… Steven… 2024…       9  42.4 -76.4 FALSE   
#>  3 sancra      Sandhil… Antigo… L212… Steven… 2024…       9  42.4 -76.4 FALSE   
#>  4 veggul1     Herring… Larus … L212… Steven… 2024…       1  42.4 -76.4 FALSE   
#>  5 veggul1     Herring… Larus … L212… Steven… 2024…       1  42.4 -76.4 FALSE   
#>  6 veggul1     Herring… Larus … L212… Steven… 2024…       1  42.4 -76.4 FALSE   
#>  7 eastow1     Eastern… Pipilo… L117… Ringwo… 2024…       1  42.4 -76.4 FALSE   
#>  8 eastow1     Eastern… Pipilo… L117… Ringwo… 2024…       1  42.4 -76.4 FALSE   
#>  9 eastow1     Eastern… Pipilo… L117… Ringwo… 2024…       1  42.4 -76.4 FALSE   
#> 10 eastow1     Eastern… Pipilo… L117… Ringwo… 2024…       1  42.4 -76.4 FALSE   
#> # ℹ 74 more rows
#> # ℹ 3 more variables: obsReviewed <lgl>, locationPrivate <lgl>, subId <chr>
```

## Historic Observations

Obtain a list of species reported on a specific date in a given region

``` r
ebirdhistorical(loc = 'US-VA-003', date = '2019-02-14',max = 10)
#> # A tibble: 10 × 13
#>    speciesCode comName  sciName locId locName obsDt howMany   lat   lng obsValid
#>    <chr>       <chr>    <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl> <lgl>   
#>  1 cangoo      Canada … Branta… L139… Lickin… 2019…      30  38.1 -78.7 TRUE    
#>  2 mallar3     Mallard  Anas p… L139… Lickin… 2019…       5  38.1 -78.7 TRUE    
#>  3 gnwtea      Green-w… Anas c… L139… Lickin… 2019…       8  38.1 -78.7 TRUE    
#>  4 killde      Killdeer Charad… L139… Lickin… 2019…       1  38.1 -78.7 TRUE    
#>  5 baleag      Bald Ea… Haliae… L139… Lickin… 2019…       1  38.1 -78.7 TRUE    
#>  6 belkin1     Belted … Megace… L139… Lickin… 2019…       1  38.1 -78.7 TRUE    
#>  7 carwre      Carolin… Thryot… L139… Lickin… 2019…       1  38.1 -78.7 TRUE    
#>  8 whtspa      White-t… Zonotr… L139… Lickin… 2019…       2  38.1 -78.7 TRUE    
#>  9 norcar      Norther… Cardin… L139… Lickin… 2019…       1  38.1 -78.7 TRUE    
#> 10 canvas      Canvasb… Aythya… L331… Montic… 2019…      19  38.0 -78.5 TRUE    
#> # ℹ 3 more variables: obsReviewed <lgl>, locationPrivate <lgl>, subId <chr>
```

or a hotspot

``` r
ebirdhistorical(loc = 'L196159', date = '2019-02-14', fieldSet = 'full')
#> # A tibble: 14 × 27
#>    speciesCode comName  sciName locId locName obsDt howMany   lat   lng obsValid
#>    <chr>       <chr>    <chr>   <chr> <chr>   <chr>   <int> <dbl> <dbl> <lgl>   
#>  1 annhum      Anna's … Calypt… L196… Vancou… 2019…       4  49.3 -123. TRUE    
#>  2 ribgul      Ring-bi… Larus … L196… Vancou… 2019…       4  49.3 -123. TRUE    
#>  3 glwgul      Glaucou… Larus … L196… Vancou… 2019…      29  49.3 -123. TRUE    
#>  4 amecro      America… Corvus… L196… Vancou… 2019…     100  49.3 -123. TRUE    
#>  5 bkcchi      Black-c… Poecil… L196… Vancou… 2019…      16  49.3 -123. TRUE    
#>  6 bushti      Bushtit  Psaltr… L196… Vancou… 2019…      20  49.3 -123. TRUE    
#>  7 pacwre1     Pacific… Troglo… L196… Vancou… 2019…       1  49.3 -123. TRUE    
#>  8 houfin      House F… Haemor… L196… Vancou… 2019…       2  49.3 -123. TRUE    
#>  9 purfin      Purple … Haemor… L196… Vancou… 2019…       3  49.3 -123. TRUE    
#> 10 amegfi      America… Spinus… L196… Vancou… 2019…      15  49.3 -123. TRUE    
#> 11 daejun      Dark-ey… Junco … L196… Vancou… 2019…      37  49.3 -123. TRUE    
#> 12 sonspa      Song Sp… Melosp… L196… Vancou… 2019…      12  49.3 -123. TRUE    
#> 13 spotow      Spotted… Pipilo… L196… Vancou… 2019…       1  49.3 -123. TRUE    
#> 14 rewbla      Red-win… Agelai… L196… Vancou… 2019…       6  49.3 -123. TRUE    
#> # ℹ 17 more variables: obsReviewed <lgl>, locationPrivate <lgl>, subId <chr>,
#> #   subnational2Code <chr>, subnational2Name <chr>, subnational1Code <chr>,
#> #   subnational1Name <chr>, countryCode <chr>, countryName <chr>,
#> #   userDisplayName <chr>, obsId <chr>, checklistId <chr>, presenceNoted <lgl>,
#> #   hasComments <lgl>, firstName <chr>, lastName <chr>, hasRichMedia <lgl>
```

## Information on a given region or hotspot

Obtain detailed information on any valid eBird region

``` r
ebirdregioninfo("CA-BC-GV")
#> # A tibble: 1 × 5
#>   region                                     minX  maxX  minY  maxY
#>   <chr>                                     <dbl> <dbl> <dbl> <dbl>
#> 1 Metro Vancouver, British Columbia, Canada -123. -122.  49.0  49.6
```

or hotspot

``` r
ebirdregioninfo("L196159")
#> # A tibble: 1 × 16
#>   locId   name       latitude longitude countryCode countryName subnational1Name
#>   <chr>   <chr>         <dbl>     <dbl> <chr>       <chr>       <chr>           
#> 1 L196159 Vancouver…     49.3     -123. CA          Canada      British Columbia
#> # ℹ 9 more variables: subnational1Code <chr>, subnational2Code <chr>,
#> #   subnational2Name <chr>, isHotspot <lgl>, locName <chr>, lat <dbl>,
#> #   lng <dbl>, hierarchicalName <chr>, locID <chr>
```

Obtain a list of eBird species codes for all species recorded in a
region

``` r
ebirdregionspecies("GB-ENG-LND")
#> # A tibble: 383 × 1
#>    speciesCode
#>    <chr>      
#>  1 wfwduc1    
#>  2 fuwduc     
#>  3 bahgoo     
#>  4 empgoo     
#>  5 snogoo     
#>  6 rosgoo     
#>  7 gragoo     
#>  8 swagoo1    
#>  9 gwfgoo     
#> 10 lwfgoo     
#> # ℹ 373 more rows
```

or a hotspot

``` r
ebirdregionspecies("L5803024")
#> # A tibble: 181 × 1
#>    speciesCode
#>    <chr>      
#>  1 gragoo     
#>  2 gwfgoo     
#>  3 pifgoo     
#>  4 bargoo     
#>  5 cangoo     
#>  6 x00758     
#>  7 mutswa     
#>  8 whoswa     
#>  9 egygoo     
#> 10 comshe     
#> # ℹ 171 more rows
```

Obtain a list of all subregions within an eBird region

``` r
ebirdsubregionlist("subnational1","US")
#> # A tibble: 51 × 2
#>    code  name                
#>    <chr> <chr>               
#>  1 US-AL Alabama             
#>  2 US-AK Alaska              
#>  3 US-AZ Arizona             
#>  4 US-AR Arkansas            
#>  5 US-CA California          
#>  6 US-CO Colorado            
#>  7 US-CT Connecticut         
#>  8 US-DE Delaware            
#>  9 US-DC District of Columbia
#> 10 US-FL Florida             
#> # ℹ 41 more rows
```

## Checklist Feed

Obtain a list of checklists submitted on a given date at a region or
hotspot

``` r
ebirdchecklistfeed(loc = "L207391", date = "2020-03-24", max = 5)
#> # A tibble: 5 × 9
#>   locId   subId  userDisplayName numSpecies obsDt obsTime isoObsDate subID loc  
#>   <chr>   <chr>  <chr>                <int> <chr> <chr>   <chr>      <chr> <chr>
#> 1 L207391 S6617… David Wood              10 24 M… 14:47   2020-03-2… S661… L207…
#> 2 L207391 S6617… Sofia Prado-Ir…         15 24 M… 14:31   2020-03-2… S661… L207…
#> 3 L207391 S6619… Jeffrey Gantz           19 24 M… 13:30   2020-03-2… S661… L207…
#> 4 L207391 S6617… Ann Gurka               21 24 M… 13:00   2020-03-2… S661… L207…
#> 5 L207391 S7098… Barbara Olson           20 24 M… 10:30   2020-03-2… S709… L207…
```

## View Checklist

Obtain all information on a specific checklist

``` r
ebirdchecklist("S139153079")
#> # A tibble: 99 × 24
#>    subId      protocolId locId groupId   durationHrs allObsReported subComments 
#>    <chr>      <chr>      <chr> <chr>           <dbl> <lgl>          <chr>       
#>  1 S139153079 P22        L17   G10310841        11.2 TRUE           "There are …
#>  2 S139153079 P22        L17   G10310841        11.2 TRUE           "There are …
#>  3 S139153079 P22        L17   G10310841        11.2 TRUE           "There are …
#>  4 S139153079 P22        L17   G10310841        11.2 TRUE           "There are …
#>  5 S139153079 P22        L17   G10310841        11.2 TRUE           "There are …
#>  6 S139153079 P22        L17   G10310841        11.2 TRUE           "There are …
#>  7 S139153079 P22        L17   G10310841        11.2 TRUE           "There are …
#>  8 S139153079 P22        L17   G10310841        11.2 TRUE           "There are …
#>  9 S139153079 P22        L17   G10310841        11.2 TRUE           "There are …
#> 10 S139153079 P22        L17   G10310841        11.2 TRUE           "There are …
#> # ℹ 89 more rows
#> # ℹ 17 more variables: creationDt <chr>, lastEditedDt <chr>, obsDt <chr>,
#> #   obsTimeValid <lgl>, checklistId <chr>, numObservers <int>,
#> #   effortDistanceKm <dbl>, effortDistanceEnteredUnit <chr>,
#> #   subnational1Code <chr>, userDisplayName <chr>, numSpecies <int>,
#> #   speciesCode <chr>, obsId <chr>, howManyStr <chr>, obsComments <chr>,
#> #   photoCounts <int>, videoCounts <int>
```

## Hotspots in a region or nearby coordinates

Obtain a list of hotspots within a region

``` r
ebirdhotspotlist("CA-NS-HL")
#> # A tibble: 290 × 9
#>    locId     locName   countryCode subnational1Code subnational2Code   lat   lng
#>    <chr>     <chr>     <chr>       <chr>            <chr>            <dbl> <dbl>
#>  1 L2334369  Abraham … CA          CA-NS            CA-NS-HL          45.2 -62.6
#>  2 L7003818  Admiral … CA          CA-NS            CA-NS-HL          44.7 -63.7
#>  3 L1765807  Admiral … CA          CA-NS            CA-NS-HL          44.8 -63.1
#>  4 L12227034 Armdale-… CA          CA-NS            CA-NS-HL          44.6 -63.6
#>  5 L12690538 Armdale-… CA          CA-NS            CA-NS-HL          44.6 -63.6
#>  6 L2390509  Bald Roc… CA          CA-NS            CA-NS-HL          44.5 -63.6
#>  7 L7598385  Bayers L… CA          CA-NS            CA-NS-HL          44.6 -63.7
#>  8 L11019120 Beaver B… CA          CA-NS            CA-NS-HL          44.8 -63.7
#>  9 L1872934  Bedford … CA          CA-NS            CA-NS-HL          44.7 -63.7
#> 10 L12134597 Bedford-… CA          CA-NS            CA-NS-HL          44.7 -63.7
#> # ℹ 280 more rows
#> # ℹ 2 more variables: latestObsDt <chr>, numSpeciesAllTime <int>
```

or within a radius of up to 50 kilometers, from a given set of
coordinates.

``` r
ebirdhotspotlist(lat = 30, lng = -90, dist = 10)
#> No region code provided, locating hotspots using lat/lng
#> # A tibble: 54 × 9
#>    locId    locName    countryCode subnational1Code subnational2Code   lat   lng
#>    <chr>    <chr>      <chr>       <chr>            <chr>            <dbl> <dbl>
#>  1 L6025517 Algiers P… US          US-LA            US-LA-071         30.0 -90.1
#>  2 L3886471 Armstrong… US          US-LA            US-LA-071         30.0 -90.1
#>  3 L727179  Audubon L… US          US-LA            US-LA-071         30.0 -90.0
#>  4 L6665071 BAEA Nest… US          US-LA            US-LA-087         30.0 -90.0
#>  5 L6666949 BAEA Nest… US          US-LA            US-LA-071         29.9 -90.0
#>  6 L2423926 Bayou Bie… US          US-LA            US-LA-071         30.0 -90.0
#>  7 L725034  Bayou Sau… US          US-LA            US-LA-071         30.1 -89.9
#>  8 L727232  Chalmette… US          US-LA            US-LA-087         29.9 -90.0
#>  9 L453412  City Park… US          US-LA            US-LA-071         30.0 -90.1
#> 10 L5229399 City Park… US          US-LA            US-LA-071         30.0 -90.1
#> # ℹ 44 more rows
#> # ℹ 2 more variables: latestObsDt <chr>, numSpeciesAllTime <int>
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
covered by this package, feel free to submit a pull request!

### data/obs

-   [x] Recent observations in a region: `ebirdregion()`
-   [x] Recent notable observations in a region: `ebirdnotable()`
-   [x] Recent observations of a species in a region: `ebirdregion()`
-   [x] Recent nearby observations: `ebirdgeo()`
-   [x] Recent nearby observations of a species: `ebirdgeo()`
-   [x] Nearest observations of a species: `nearestobs()`
-   [x] Recent nearby notable observations: `ebirdnotable()`
-   [ ] Recent checklists feed
-   [x] Historic observations on a date: `ebirdhistorical()`

### product

-   [ ] Top 100
-   [x] Checklist feed on a date: `ebirdchecklistfeed()`
-   [ ] Regional statistics on a date
-   [x] Species list for a region: `ebirdregionspecies()`
-   [x] View Checklist: `ebirdchecklist()`

### ref/geo

-   [ ] Adjacent Regions

### ref/hotspot

-   [x] Hotspots in a region: `ebirdhotspotlist()`
-   [x] Nearby hotspots: `ebirdhotspotlist()`
-   [x] Hotspot Info: `ebirdregioninfo()`

### ref/taxonomy

-   [x] eBird Taxonomy: `ebirdtaxonomy()`
-   [ ] Taxonomic Forms
-   [ ] Taxonomy Versions
-   [ ] Taxonomic Groups

### ref/region

-   [x] Region Info: `ebirdregioninfo()`
-   [x] Sub Region List `ebirdsubregionlist()`

## Meta

-   Please [report any issues or
    bugs](https://github.com/ropensci/rebird/issues).
-   License: MIT
-   Get citation information for `rebird` in R doing
    `citation(package = 'rebird')`
-   Please note that the ‘rebird’ project is released with a
    [Contributor Code of
    Conduct](https://github.com/ropensci/rebird/blob/master/CODE_OF_CONDUCT.md).
    By contributing to this project, you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org/)
