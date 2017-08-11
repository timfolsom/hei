context("HEI calculation")

test_that("HEI score is same as original validation data", {

    diet <- get_diet("2009/2010", "both")
    fped <- get_fped("2009/2010", "both")
    demog <- get_demo("2009/2010")

    heires <- hei(fped,diet,demog)

    expect_equal_to_reference(heires$HEI, file = "rds/valid.rds")

})

test_that("HEI verbose argument returns all columns", {

    diet <- get_diet("2009/2010", "both")
    fped <- get_fped("2009/2010", "both")
    demog <- get_demo("2009/2010")

    heires <- hei(fped,diet, demog, verbose = TRUE)

    expect_equal(ncol(heires), 70)

})