all: vignettes move rmd2md

vignettes:
		cd inst/vign;\
		Rscript --vanilla -e 'library(knitr); knit("rebird_vignette.Rmd")'

move:
		cp inst/vign/rebird_vignette.md vignettes;\
		cp inst/vign/figure/* vignettes/figure

pandoc:
		cd vignettes;\
		pandoc -H margins.sty rebird_vignette.md -o rebird_vignette.pdf --highlight-style=tango;\
		pandoc -H margins.sty rebird_vignette.md -o rebird_vignette.html --highlight-style=tango

rmd2md:
		cd vignettes;\
		mv rebird_vignette.md rebird_vignette.Rmd
