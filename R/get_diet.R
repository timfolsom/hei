#' retrieve dietary data from NHANES database
#'
#' @param x dataset to retrieve
#' @param strict indicator as to whether or not all variables should be returned
#' @return data frame of NHANES dietary database
#'
get_diet <- function(x, strict = TRUE) {

    keepers <- c("SEQN", "TKCAL", "TSFAT", "TALCO", "TSODI", "TMFAT", "TPFAT")
    dat <- nhanesA::nhanes(x)
    names(dat) <- gsub("DR1", "", names(dat))

    if(strict) {

        dat <- dat[,names(dat) %in% keepers]

        return(dat)

    } else {

        return(dat)

    }

}