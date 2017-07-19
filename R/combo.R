#' combine datasets to be used in HEI scoring
#'
#' @param fped food pattern equivalent database data
#' @param diet dietary data from NHANES database
#' @param demograph demographic data from NHANES database
#' @param agethresh numeric threshold for age of survey participants to be included
#' @export
#' @return data frame of combined fped, dietary and demographic data

combo <- function(fped, diet, demograph, agethresh = 2) {

    dat <- merge(fped, diet, all.x = TRUE, by = "SEQN")
    dat <- merge(dat, demograph, all.x = TRUE, by = "SEQN")
    dat <- subset(dat, dat$RIDAGEYR >= agethresh)
    dat <- subset(dat, dat$DRSTZ == 1)
    # dat <- subset(dat, RIDAGEYR >=agethresh & DRSTZ == 1)

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