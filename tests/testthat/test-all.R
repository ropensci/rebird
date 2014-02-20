
context("Tests for ebird") 

test_that("Ebird geo works correctly", {
	 egeo <- ebirdgeo(42,-76,'spinus tristis')
	 expect_is(egeo, "data.frame")
})