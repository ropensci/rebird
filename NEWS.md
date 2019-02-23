rebird 1.1.0
===================

* Updated `ebirdregioninfo()` to also provide information of hotspots (thanks @gbabineau, #72).

rebird 1.0.0
===================

This version switches all functions over the the [new eBird API](https://documenter.getpostman.com/view/664302/ebird-api-20/2HTbHW), given that the one previously used by `rebird` will be retired on October 1st. As such, many of the functions in `rebird` have changed, and the previous versions of the package will not work correctly.

### Breaking changes

* The biggest change in the new API is that most queries (with the exception of `ebirdtaxonomy()`) require users to provide an API key, which is linked to your eBird user account. See the README.md or the package vignette for more info on how to set up a key. Alternatively, the key can be provided as an argument in all functions.
* The new API requests, and thus `rebird` functions, now use species codes rather than scientific names for species-specific requests.

### Major changes

* New `species_code()` function that converts from scientific name to species code and can be called within other functions.
* New  `ebirdregioninfo()` function that provides detailed information on a given eBird region .

### Minor changes

* `ebirdregion()` now uses `loc` as its first argument instead of `region` as it allows for both regions and hotspots to be specified.

### Deprecated functions

* Given the changes to the eBird API, the functions `ebirdloc()`, `ebirdhotspot()`, and `ebirdregioncheck()` have been deprecated and will be removed in future releases. These functions still work in the updated API, but might cease to do so in the near future. `ebirdregion()` has the same functionality as the first two functions, while `ebirdregioninfo()` provides a more informative interface than `ebirdregioncheck()`.

rebird 0.5.0
===================

### MINOR IMPROVEMENTS AND BUG FIXES

* Now all API queries use https, which is needed to avoid double encoding urls (see #62).
* Added information about [`auk`](https://github.com/CornellLabofOrnithology/auk), an R package that helps extracting and processing the whole eBird dataset (#60).
* Updated package documentation (#61).

rebird 0.4.0
===================

### MINOR IMPROVEMENTS AND BUG FIXES

* Fix for `ebirdfreq` which stopped working due to changes on the eBird website (#52).
* Replaced deprecated `dplyr::rbind_all` function with `dplyr::bind_rows` (#43).

rebird 0.3.0
===================

### MINOR IMPROVEMENTS AND BUG FIXES

* Fix for `httr::content` after changes in httr v1.0.0 (#38).

rebird 0.2
===================

### NEW FEATURES

* Added two new functions `ebirdfreq` and `ebirdregioncheck`, which provide historical frequency of observation data and check whether a region is valid under eBird, respectively.

### MINOR IMPROVEMENTS

* Passed along curl options to httr functions
* Replaced RJSONIO with jsonlite
* Replaced plyr with dplyr

