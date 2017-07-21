#' retrieve FPED data
#'
#' @param year year combination of dataset to retrieve must be one of "2005/2006", "2007/2008", "2009/2010", "2011/2012" or "2013/2014"
#' @param day identifier for FPED data to retrieve ... must be one of "first", "second" or "both" (default is set to "both")
#' @return object of class \code{data.frame} containing FPED data for specificed year and day
#' @export

get_fped <- function(year, day = "both") {

    yearchoices <- c("fped0506" = "2005/2006",
                     "fped0708"= "2007/2008",
                     "fped0910"="2009/2010",
                     "fped1112"= "2011/2012",
                     "fped1314" = "2013/2014")

    daychoices <- c("both" = "both",
                    "first" = "day1",
                    "second" = "day2")

    try(if(!year %in% yearchoices) stop("must use valid year choice"))

    try(if(!day %in% daychoices) stop("must use valid day choice"))

    fped <- paste0(names(which(yearchoices==year)),
                   "_",
                   names(which(daychoices==day))
    )

    eval(parse(text = fped))

}