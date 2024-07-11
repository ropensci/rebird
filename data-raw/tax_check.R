#!/usr/bin/env Rscript
compare_dataframes <- function(df1, df2) {
  df1_sorted <- df1[do.call(order, df1),]
  df2_sorted <- df2[do.call(order, df2),]
  identical(df1_sorted, df2_sorted)
}

print("Loading current taxonomy...")
temp_env <- new.env()
data("tax", envir = temp_env)
old_tax <- temp_env$tax
paste("Current rebird taxonomy has", ncol(old_tax), "columns and", nrow(old_tax), "rows")

print("Retrieving taxonomy from eBird...")
new_tax <- rebird::ebirdtaxonomy()
paste("The latest taxonomy from eBird has", ncol(new_tax), "columns and", nrow(new_tax), "rows")

needs_update <- !(compare_dataframes(old_tax, new_tax))
print(paste("Needs update?:", needs_update))
if (needs_update) print("The next job to create an issue should run.")
cat(paste0("result=", needs_update), file = Sys.getenv("GITHUB_OUTPUT"), append = TRUE)
