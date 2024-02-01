# eBird taxonomy to look up species codes
# 
# This creates the internal taxonomy data frame used by rebird, which
# is stored ind 'R/sysdata.rda'. We update the package in CRAN when
# the eBird taxonomy update is completed, but in the event you need
# to update the taxonomy yourself you can do so by running the code below.

library(rebird)

tax <- ebirdtaxonomy()
usethis::use_data(tax, overwrite = TRUE)
