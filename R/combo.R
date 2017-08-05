#' Data set combination and manipulation for use in HEI scoring.
#'
#' \code{combo} returns a single data set combining the FPED and NHANES dietary and demographic data sets. Additionally, it allows for specification of an age threshold such that records with age values below this number will be excluded from the output. Furthermore, any rows for which dietary recall was deemed unreliable (DRSTZ != 1) are automatically dropped. Finally, additional necessary HEI inputs are generated from the existing columns, see "Value" section below.
#'
#' @param fped food pattern equivalent database data
#' @param diet dietary data from NHANES database
#' @param demograph demographic data from NHANES database
#' @param agethresh numeric threshold for age of survey participants to be included
#' @return Object of class \code{data.frame} representing a data set fully prepped for HEI score calculation. All columns from the three input data sets are preserved while a handful of additional derivative columns are included, specifically:
#' \itemize{
#' \item WHOLEFRT: T_F_CITMLB (citrus, melons, and berries) + T_F_OTHER (fruits excluding citrus, melons, and berries)
#' \item MONOPOLY: TMFAT (total monounsaturated fatty acids) + TPFAT (total polyunsaturated fatty acids)
#' \item ALLMEAT: T_PF_MPS_TOTAL (meat, poultry, seafood, organ meat, and cured meat) + T_PF_EGGS (eggs and egg substitutes) + T_PF_NUTSDS (peanuts, tree nuts, and seeds) + T_PF_SOY (soy products)
#' \item SEAPLANT: T_PF_SEAFD_HI (Seafood high in n-3 fatty acids) + T_PF_SEAFD_LOW (Seafood low in n-3 fatty acids) + T_PF_NUTSDS (peanuts, tree nuts, and seeds) + T_PF_SOY + (soy products)
#' \item ADDSUGC: T_ADD_SUGARS (added sugars) * 16
#' \item SOLFATC: T_SOLID_FATS (fats naturally present in meat, etc.) * 9
#' \item MAXALCGR: TKCAL (total calories) / 1000 * 13
#' \item EXALCCAL (amount of alcohol above acceptable threshold): (TALCO (total alcohol) - MAXALCGR) * 7
#' \item EMPTYCAL10: ADDSUGC + SOLFATC + EXALCCAL
#' }

combo <- function(fped, diet, demograph, agethresh = 2) {

    dat <- merge(fped, diet, all.x = TRUE, by = "SEQN")
    dat <- merge(dat, demograph, all.x = TRUE, by = "SEQN")
    dat <- subset(dat, dat$RIDAGEYR >= agethresh)
    dat <- subset(dat, dat$DRSTZ == 1)

    dat$WHOLEFRT <- dat$T_F_CITMLB + dat$T_F_OTHER
    dat$MONOPOLY <- dat$TMFAT + dat$TPFAT
    dat$ALLMEAT <- dat$T_PF_MPS_TOTAL + dat$T_PF_EGGS + dat$T_PF_NUTSDS + dat$T_PF_SOY
    dat$SEAPLANT <- dat$T_PF_SEAFD_HI + dat$T_PF_SEAFD_LOW + dat$T_PF_NUTSDS + dat$T_PF_SOY
    dat$ADDSUGC <- 16*dat$T_ADD_SUGARS
    dat$SOLFATC <- 9*dat$T_SOLID_FATS
    dat$MAXALCGR = 13 *(dat$TKCAL/1000)
    dat$EXALCCAL <- ifelse(dat$TALCO <= dat$MAXALCGR, 0, 7*(dat$TALCO-dat$MAXALCGR))
    dat$EMPTYCAL10 <- dat$ADDSUGC + dat$SOLFATC + dat$EXALCCAL

    dat

}