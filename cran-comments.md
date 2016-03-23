## Test environments
* local machine running Linux Ubuntu 14.04.4, R 3.2.4
* win-builder (devel and release)
* Windows Server 2012 R2 x64, R 3.2.4 on Appveyor
* Ubuntu 12.04.5 LTS, R 3.2.4 or Travis-CI

## R CMD check results
There were no ERRORs or WARNINGs. 

There was 1 NOTE:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Sebastian Pardo <sebpardo@gmail.com>'

License components with restrictions and base license permitting such:
  MIT + file LICENSE
File 'LICENSE':
  YEAR: 2016
  COPYRIGHT HOLDER: Rafael Maia

Possibly mis-spelled words in DESCRIPTION:
  eBird (4:25, 5:44, 7:17)
  hotspots (7:23)

  Not mis-spellings.

Found the following (possibly) invalid URLs:
  URL: https://cran.rstudio.com/package=rebird/
    From: README.md
    Status: 200
    Message: OK
    CRAN URL not in canonical form

  This NOTE only comes up in the r-devel version test. Probably false positive as URL is in canonical form. I also ran the test without the slash (/) at the end of the URL and the NOTE still comes up.

## Downstream dependencies
I have also run R CMD check on downstream dependencies of rebird.
All packages that I could install passed.
