# eBird taxonomy to look up species codes
library(dplyr)

tax <- rebird::ebirdtaxonomy(cat = c("domestic", "form", "hybrid", 
                              "intergrade", "issf", "slash", "species", "spuh")) %>%
  tbl_df()

devtools::use_data(tax, overwrite = TRUE, internal = TRUE)
