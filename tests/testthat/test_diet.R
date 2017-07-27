context("diet")

test_that("get_diet returns data frames", {

    diet1 <- get_diet("2009/2010", day = "first")
    diet2 <- get_diet("2009/2010", day = "second")

    expect_is(diet1, "data.frame")
    expect_is(diet2, "data.frame")

})