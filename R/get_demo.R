#' retrieve demographic data from NHANES database
#'
#' @param year year combination of dataset to retrieve must be one of "2005/2006", "2007/2008", "2009/2010", "2011/2012" or "2013/2014"
#' @return data frame of NHANES demographic database
#' @export

get_demo <- function(year) {

    yearchoices <- c("D" = "2005/2006",
                     "E"= "2007/2008",
                     "F"="2009/2010",
                     "G"= "2011/2012",
                     "H" = "2013/2014")

    try(if(!year %in% yearchoices) stop("must use valid year choice"))

    dbname <- paste0("DEMO_", names(which(yearchoices==year)))

    dat <- nhanesA::nhanes(dbname)

    keepers <- c("SEQN", "SDDSRVYR")
    dat <- dat[,names(dat) %in% keepers]

    # have to convert each column to numeric to remove labelling from NHANES
    dat <- data.frame(apply(dat, 2, as.numeric))

}