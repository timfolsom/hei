.onAttach <- function(...){

    msg <- paste("# hei successfully loaded\n",
                 "# usage",
                 "browseVignettes(package = 'hei')\n",
                 "# citation",
                 "Folsom, T., & Nagraj, V.P. (2017). hei: Calculate Healthy Eating Index (HEI) Scores. Journal of Open Source Software, 2(18), 10.21105/joss.00417.",
                 sep = "\n")


    packageStartupMessage(msg)

}