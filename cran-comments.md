## Test environments

* local machine running Linux Ubuntu 18.04 LTS, R 4.0.3
* win-builder (release and devel)
* Linux Ubuntu 16.04.6 LTS running R 4.0.2 on travis-ci
* Windows Server 2012 R2 x64 (build 9600) running R 4.0.3 on Appveyor
* R-hub
  * Windows Server 2008 R2 SP1, R-devel, 32/64 bit
  * Ubuntu Linux 20.04.1 LTS, R-release, GCC
  * Fedora Linux, R-devel, clang, gfortran
  
## R CMD check results

There were no ERRORs, WARNINGs, or NOTEs. 

## Downstream dependencies

I have also run R CMD check on downstream dependencies of rebird.
All packages passed.

