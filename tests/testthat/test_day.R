context("days")

test_that("day choice is enforced", {

    expect_error(get_diet(day = "1999th"))
    expect_error(get_fped(day = "1999th"))

})