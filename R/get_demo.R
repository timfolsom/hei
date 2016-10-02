#' retrieve demographic data from NHANES database
#'
#' @param x dataset to retrieve
#' @param strict indicator as to whether or not all variables should be returned
#' @return data frame of NHANES demographic database

get_demo <- function(x, strict = TRUE) {

    keepers <- c("SEQN", "SDDSRVYR")

    dat <- nhanesA::nhanes(x)
    if(strict) {

        dat <- dat[,names(dat) %in% keepers]

        return(dat)

    } else {

        return(dat)

    }
}
