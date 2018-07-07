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

