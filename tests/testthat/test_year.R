context("years")

test_that("year choice is enforced", {

    expect_error(get_diet(year = "1999"))
    expect_error(get_demo(year = "1999"))
    expect_error(get_fped(year = "1999"))

})