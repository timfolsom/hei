context("fped")

test_that("get_fped returns a data frame", {

    fped <- get_fped("2005/2006", day = "both")

    expect_is(fped, "data.frame")

})