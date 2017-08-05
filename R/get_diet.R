#' NHANES dietary data retrieval.
#'
#' \code{get_diet} returns an abridged National Health and Nutrition Examination Survey (NHANES) dietary data set for a given year.
#'
#' @param year year combination of data set to retrieve ... must be one of the following:
#' \itemize{
#' \item "2005/2006"
#' \item "2007/2008"
#' \item "2009/2010"
#' \item "2011/2012"
#' \item "2013/2014"
#' }
#' @param day identifier for survey day to retrieve ... must be one of the following:
#' \itemize{
#' \item "first" (data for study participants from first day)
#' \item "second" (study participant data from second day)
#' \item "both" (data for study participants present in both days, with values averaged across the two days)
#' }
#' @return Object of class \code{data.frame} containing a modified NHANES dietary data set for a specified year and day. The complete NHANES dietary data set contains several more variables than are necessary for computing HEI scores. The data set returned by this function has been trimmed down to contain (in addition to an NHANES unique sequence identifier for each participant) only the columns of data needed for HEI score calculation, specifically:
#' \itemize{
#' \item TKCAL: Energy (kcal)
#' \item TSFAT: Total saturated fatty acids (gm)
#' \item TMFAT: Total monounsaturated fatty acids (gm)
#' \item TPFAT: Total polyunsaturated fatty acids (gm)
#' \item TSODI: Sodium (mg)
#' \item TALCO: Alcohol (gm)
#' }
#'
#' @references \url{https://www.cdc.gov/nchs/nhanes/nhanes_questionnaires.htm}
#' @export
#' @examples
#' \dontrun{
#' get_diet("2009/2010", "both")
#' get_diet("2009/2010", "first")
#' }

get_diet <- function(year, day) {

    yearchoices <- c("D" = "2005/2006",
                     "E"= "2007/2008",
                     "F"="2009/2010",
                     "G"= "2011/2012",
                     "H" = "2013/2014")

    try(if(!year %in% yearchoices) stop("must use valid year choice"))

    daychoices <- c("DR1"="first", "DR2"="second","both")

    try(if(!day %in% daychoices) stop("must use valid day choice"))

    if(day != "both") {

        dbname <- paste0(names(which(daychoices==day)),
                         "TOT_",
                         names(which(yearchoices==year)))

        dat <- nhanesA::nhanes(dbname)

        names(dat) <- gsub("DR[1-9]", "", names(dat))

        keepers <- c("SEQN",
                     "TKCAL",
                     "TSFAT",
                     "TALCO",
                     "TSODI",
                     "TMFAT",
                     "TPFAT")

        dat <- dat[,names(dat) %in% keepers]

        # have to convert each column to numeric to remove labelling from NHANES
        dat <- data.frame(apply(dat, 2, as.numeric))

    } else {

        dbname1 <- paste0(names(daychoices[1]), "TOT_", names(which(yearchoices==year)))

        dat1 <- nhanesA::nhanes(dbname1)

        names(dat1) <- gsub("DR[1-9]", "", names(dat1))

        keepers <- c("SEQN",
                     "TKCAL",
                     "TSFAT",
                     "TALCO",
                     "TSODI",
                     "TMFAT",
                     "TPFAT")

        dat1 <- dat1[,names(dat1) %in% keepers]

        dbname2 <- paste0(names(daychoices[2]), "TOT_", names(which(yearchoices==year)))

        dat2 <- nhanesA::nhanes(dbname2)

        names(dat2) <- gsub("DR[1-9]", "", names(dat2))

        keepers <- c("SEQN", "TKCAL", "TSFAT", "TALCO", "TSODI", "TMFAT", "TPFAT")

        dat2 <- dat2[,names(dat2) %in% keepers]

        dat <- rbind(dat1,dat2)

        # have to convert each column to numeric to remove labelling from NHANES
        dat <- data.frame(apply(dat, 2, as.numeric))

        dat <- dat[!is.na(dat$TSFAT),]

        dat <- stats::aggregate(. ~ SEQN, data = dat, FUN = "mean")

    }

    dat

}