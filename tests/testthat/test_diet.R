context("diet")

diet1 <- get_diet("2009/2010", day = "first")
diet2 <- get_diet("2009/2010", day = "second")
diet3 <- get_diet("2009/2010", day = "both")

test_that("get_diet returns data frames", {

    expect_is(diet1, "data.frame")
    expect_is(diet2, "data.frame")
    expect_is(diet3, "data.frame")

})