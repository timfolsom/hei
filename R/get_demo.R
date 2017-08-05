#' NHANES demographic data retrieval.
#'
#' \code{get_demo} returns an abridged National Health and Nutrition Examination Survey (NHANES) demographic data set for a given year.
#'
#' @param year year combination of data set to retrieve ... must be one of the following:
#' \itemize{
#' \item "2005/2006"
#' \item "2007/2008"
#' \item "2009/2010"
#' \item "2011/2012"
#' \item "2013/2014"
#' }
#' @return Object of class \code{data.frame} containing a modified NHANES demographic data set for a specified year. The complete NHANES demographic data set contains several more variables than are necessary for computing HEI scores. In fact, the only variable contained in the returned data set (in addition to an NHANES unique sequence identifier for each participant) is not, strictly speaking, even required itself, but becomes relevant if data sets from multiple separate NHANES iterations are concatenated, specifically:
#' \itemize{
#' \item SDDSRVYR: This variable represents the two-year data release cycle number (e.g. a value of “6” denotes NHANES 2009–2010).
#' }
#' @references \url{https://www.cdc.gov/nchs/nhanes/nhanes_questionnaires.htm}
#' @export
#' @examples
#' \dontrun{
#' get_demo("2009/2010")
#' }

get_demo <- function(year) {

    yearchoices <- c("D" = "2005/2006",
                     "E" = "2007/2008",
                     "F" = "2009/2010",
                     "G" = "2011/2012",
                     "H" = "2013/2014")

    try(if(!year %in% yearchoices) stop("must use valid year choice"))

    dbname <- paste0("DEMO_", names(which(yearchoices==year)))

    dat <- nhanesA::nhanes(dbname)

    keepers <- c("SEQN", "SDDSRVYR")
    dat <- dat[,names(dat) %in% keepers]

    # have to convert each column to numeric to remove labelling from NHANES
    dat <- data.frame(apply(dat, 2, as.numeric))

    dat

}