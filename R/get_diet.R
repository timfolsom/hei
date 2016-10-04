#' retrieve dietary data from NHANES database
#'
#' @param year year combination of dataset to retrieve must be one of "2005/2006", "2007/2008", "2009/2010" or "2011/2012"
#' @param day identifier for survey day to retrive ... must be one of "first", "second" or "both" (default is set to "both")
#' @return data frame of NHANES dietary database
#' @export

get_diet <- function(year, day = "both") {

    yearchoices <- c("D" = "2005/2006", "E"= "2007/2008","F"="2009/2010","G"= "2011/2012")

    try(if(!year %in% yearchoices) stop("must use valid year choice"))

    daychoices <- c("DR1"="first", "DR2"="second","both")

    try(if(!day %in% daychoices) stop("must use valid day choice"))

    if(day != "both") {

        dbname <- paste0(names(which(daychoices==day)), "TOT_", names(which(yearchoices==year)))
        dat <- nhanesA::nhanes(dbname)
        names(dat) <- gsub("DR[1-9]", "", names(dat))
        keepers <- c("SEQN", "TKCAL", "TSFAT", "TALCO", "TSODI", "TMFAT", "TPFAT")
        dat <- dat[,names(dat) %in% keepers]

    } else {

        dbname1 <- paste0(names(daychoices[1]), "TOT_", names(which(yearchoices==year)))
        dat1 <- nhanesA::nhanes(dbname1)
        names(dat1) <- gsub("DR[1-9]", "", names(dat1))
        # dat1$day <- "first"
        keepers <- c("SEQN", "TKCAL", "TSFAT", "TALCO", "TSODI", "TMFAT", "TPFAT")
        dat1 <- dat1[,names(dat1) %in% keepers]

        dbname2 <- paste0(names(daychoices[2]), "TOT_", names(which(yearchoices==year)))
        dat2 <- nhanesA::nhanes(dbname2)
        names(dat2) <- gsub("DR[1-9]", "", names(dat2))
        # dat2$day <- "second"
        keepers <- c("SEQN", "TKCAL", "TSFAT", "TALCO", "TSODI", "TMFAT", "TPFAT")
        dat2 <- dat2[,names(dat2) %in% keepers]

        require(magrittr, quietly = TRUE)

        dat <- rbind(dat1,dat2)

        # dat <-
        #     dat %>%
        #     dplyr::filter_(!is.na(TSFAT)) %>%
        #     dplyr::group_by_(SEQN) %>%
        #     dplyr::summarise_each_(funs(mean), -day, -SEQN)

        dat <- dat[!is.na(dat$TSFAT),]

        dat <- aggregate(. ~ SEQN, data = dat, FUN = "mean")

    }

}