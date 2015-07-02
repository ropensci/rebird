## Test environments
* local Linux Ubuntu install, R 3.2.1
* win-builder (devel and release)


## R CMD check results
There were no ERRORs or WARNINGs. 

There were 3 NOTEs:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Sebastian Pardo <sebpardo@gmail.com>'

License components with restrictions and base license permitting such:
  MIT + file LICENSE
File 'LICENSE':
  YEAR: 2015
  COPYRIGHT HOLDER: Rafael Maia

Possibly mis-spelled words in DESCRIPTION:
  eBird (4:25, 5:44, 7:17)
  hotspots (7:23)

  Not mis-spellings.


* checking package dependencies ... NOTE
  No repository set, so cyclic dependency check skipped

  Setting repository is machine-dependent.


* checking R code for possible problems ... NOTE
ebird_GET : <anonymous> : <anonymous>: no visible global function
  definition for 'is'
  ebirdfreq: no visible global function definition for 'read.delim'
  ebirdfreq: no visible global function definition for 'reshape'
  Undefined global functions or variables:
    is read.delim reshape

  functions `is`, `read.delim`, and `reshape` are included in the `utils` 
  and `stats` packages in base R.


## Downstream dependencies
I have also run R CMD check on downstream dependencies of rebird.
All packages that I could install passed.
