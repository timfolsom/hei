#' Individual HEI scores calculation.
#'
#' \code{hei} calculates a Health Eating Index (HEI) score for individuals in the National Health and Nutrition Examination Survey (NHANES) studies based on input dietary, demographic and Food Pattern Equivalent Database (FPED) data.
#'
#' @param fped Food Pattern Equivalent Database data; see \link{get_fped}
#' @param diet dietary data from NHANES database; see \link{get_diet}
#' @param demograph demographic data from NHANES database; see \link{get_demo}
#' @param agethresh numeric threshold for age in years of survey participants to be included; any individual less than the value specified will be excluded; defaults to 2
#' @param verbose boolean indicating whether or not all columns from processed data should be output; default is \code{FALSE} designating only the following are included in the returned \code{data.frame}:
#' \itemize{
#' \item SEQN: Respondent sequence number
#' \item RIDAGEYR: Best age in years of the sample person at time of HH screening. Individuals 85 and over are topcoded at 85 years of age
#' \item HEI: Overall Health Eating Index score for the given participant
#' }
#' @return Object of class \code{data.frame}; defaults to only include columns for respondent identifier, age, and overall HEI score of each individual; this can be overidden with the \code{verbose} parameter to output all columns of the input data sets as well as 33 columns of calculated data related to HEI scoring and, significantly, a 70th column containing the total HEI score for each participant.
#' @export
#'
#' @references \url{https://www.cnpp.usda.gov/healthyeatingindex}
#'
#' @examples
#' \dontrun{
#' fped0910 <- get_fped("2009/2010", "both")
#' diet0910 <- get_diet("2009/2010", "both")
#' demo0910 <- get_demo("2009/2010")
#' hei(fped0910,diet0910,demo0910)
#'
#' fped0506 <- get_fped("2005/2006", "first")
#' diet0506 <- get_diet("2005/2006", "first")
#' demo0506 <- get_demo("2005/2006")
#' hei(fped0506,diet0506,demo0506, agethresh = 18)
#' }

hei <- function(fped, diet, demograph, agethresh = 2, verbose = FALSE) {

    dat <- combo(fped, diet, demograph, agethresh)

    dat <- leg_all(dat)

    # heiveg
    # total veggies
    dat$vegden <- dat$lvtotal / (dat$TKCAL/1000)
    dat$heiveg <- 5*(dat$vegden/1.1)
    dat$heiveg <- ifelse(dat$heiveg > 5, 5, dat$heiveg)

    # heibngrn
    # beans and greens
    dat$bngrden <- dat$lbeangrn / (dat$TKCAL/1000)
    dat$heibngrn <- 5*(dat$bngrden/0.2)
    dat$heibngrn  <- ifelse(dat$heibngrn  > 5, 5, dat$heibngrn)

    # heitotfr
    # total fruit
    dat$frtden <- dat$T_F_TOTAL/(dat$TKCAL/1000)
    dat$heitotfrt <- 5*(dat$frtden/0.8)
    dat$heitotfrt <- ifelse(dat$heitotfrt > 5, 5, dat$heitotfrt)

    # heiwholefrt
    # whole fruit
    dat$wholefrtden <- dat$WHOLEFRT/(dat$TKCAL/1000)
    dat$heiwholefrt <- 5*(dat$wholefrtden/0.4)
    dat$heiwholefrt <- ifelse(dat$heiwholefrt > 5, 5, dat$heiwholefrt)

    # heiwholegrain
    # whole grain
    dat$wholegrainden <- dat$T_G_WHOLE/(dat$TKCAL/1000)
    dat$heiwholegrain <- 10*(dat$wholegrainden/1.5)
    dat$heiwholegrain <- ifelse(dat$heiwholegrain > 10, 10, dat$heiwholegrain)

    # heidairy
    # dairy
    dat$dairyden <- dat$T_D_TOTAL/(dat$TKCAL/1000)
    dat$heidairy <- 10*(dat$dairyden/1.3)
    dat$heidairy <- ifelse(dat$heidairy > 10, 10, dat$heidairy)

    # heitotpro
    # total protein
    dat$totproden <- dat$lallmeat/(dat$TKCAL/1000)
    dat$heitotpro <- 5*(dat$totproden/2.5)
    dat$heitotpro <- ifelse(dat$heitotpro > 5, 5, dat$heitotpro)

    # heiseaplantpro
    # seaplant protein
    dat$seaplantden <- dat$lseaplant/(dat$TKCAL/1000)
    dat$heiseaplantpro <- 5*(dat$seaplantden/0.8)
    dat$heiseaplantpro <- ifelse(dat$heiseaplantpro > 5, 5, dat$heiseaplantpro)

    # heifattyacid
    # fatty acid
    dat$faratio <- ifelse(dat$TSFAT > 0,
                          dat$MONOPOLY / dat$TSFAT,
                          0)

    dat$heifattyacid <- ifelse(dat$TSFAT == 0 & dat$MONOPOLY == 0,
                               10,
                               NA)

    dat$heifattyacid <- ifelse(dat$TSFAT == 0 & dat$MONOPOLY > 0,
                               10,
                               dat$heifattyacid)

    dat$heifattyacid <- ifelse(dat$faratio >= 2.5,
                               10,
                               dat$heifattyacid)

    dat$heifattyacid <- ifelse(dat$faratio <= 1.2,
                               0,
                               dat$heifattyacid)

    dat$heifattyacid <- ifelse(is.na(dat$heifattyacid),
                               10*((dat$faratio-1.2)/(2.5-1.2)),
                               dat$heifattyacid)
    # heisodi
    # sodium
    dat$sodden <- dat$TSODI / dat$TKCAL

    dat$heisodi <- ifelse(dat$sodden <= 1.1,
                          10,
                          NA)
    dat$heisodi <- ifelse(dat$sodden >= 2.0,
                          0,
                          dat$heisodi)
    dat$heisodi <- ifelse(is.na(dat$heisodi),
                          10 - (10*(dat$sodden - 1.1)/(2.0-1.1)),
                          dat$heisodi)

    # heirefgrain
    # refined grain
    dat$refgrainnden <- dat$T_G_REFINED / (dat$TKCAL/1000)

    dat$heirefgrain <- ifelse(dat$refgrainnden <= 1.8,
                              10,
                              NA)
    dat$heirefgrain <- ifelse(dat$refgrainnden >= 4.3,
                              0,
                              dat$heirefgrain)

    dat$heirefgrain <- ifelse(is.na(dat$heirefgrain),
                              10 - (10*(dat$refgrainnden - 1.8)/(4.3-1.8)),
                              dat$heirefgrain)

    # heisofaas
    dat$sofa_perc <- 100* (dat$EMPTYCAL10/dat$TKCAL)

    dat$heisofaas <- ifelse(dat$sofa_perc >= 50,
                            0,
                            NA)

    dat$heisofaas <- ifelse(dat$sofa_perc <= 19,
                            20,
                            dat$heisofaas)

    dat$heisofaas = ifelse(is.na(dat$heisofaas),
                           20 - (20*(dat$sofa_perc-19)/(50-19)),
                           dat$heisofaas)

    dat$HEI = dat$heiveg + dat$heibngrn + dat$heitotfrt + dat$heiwholefrt + dat$heiwholegrain + dat$heidairy + dat$heitotpro + dat$heiseaplantpro + dat$heifattyacid + dat$heirefgrain + dat$heisofaas + dat$heisodi

    if (verbose) {

        dat

    }
    else {

        dat[,c("SEQN","RIDAGEYR","HEI")]

    }

}