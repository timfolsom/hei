#' Individual HEI scores calculation.
#'
#' \code{hei} takes a data set with columns of formatted dietary data (per \code{hei::combo}) and returns a data set with calculated total HEI scores for each individual along with scores for HEI constituent scoring categories.
#'
#' @param dat data to be scored
#' @return Object of class \code{data.frame} containing all columns of input data set as well as 33 columns of calculated data related to HEI scoring and, significantly, a 70th column containing the total HEI score for each participant.
#' @export
#' @examples
#' hei(combo(get_fped("2009/2010", "both"), get_diet("2009/2010", "both"), get_demo("2009/2010")))
#' hei(combo(get_fped("2009/2010", "first"), get_diet("2009/2010", "first"), get_demo("2009/2010")))
#' hei(combo(get_fped("2009/2010", "first"), get_diet("2009/2010", "first"), get_demo("2009/2010"), 80))

hei <- function(dat) {

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

    dat$heitotal = dat$heiveg + dat$heibngrn + dat$heitotfrt + dat$heiwholefrt + dat$heiwholegrain + dat$heidairy + dat$heitotpro + dat$heiseaplantpro + dat$heifattyacid + dat$heirefgrain + dat$heisofaas + dat$heisodi

    dat

}