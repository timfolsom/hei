#' allocate legumes for HEI scoring
#'
#' @param dat data to be processed
#' @return data frame of dietary values with legumes allocated appropriately

leg_all <- function(dat) {

    dat$mbmax <- 2.5*(dat$TKCAL/1000)

    dat$meatleg <- ifelse(dat$ALLMEAT < dat$mbmax,
                          dat$T_V_LEGUMES*4,
                          0)

    dat$needmeat <- ifelse(dat$ALLMEAT < dat$mbmax,
                           dat$mbmax - dat$ALLMEAT,
                           0)

    dat$lallmeat <- ifelse(dat$meatleg <= dat$needmeat,
                           dat$ALLMEAT + dat$meatleg,
                           0)

    dat$lseaplant <- ifelse(dat$meatleg <= dat$needmeat,
                            dat$SEAPLANT + dat$meatleg,
                            0)

    dat$lvtotal <- ifelse(dat$meatleg <= dat$needmeat,
                          dat$T_V_TOTAL,
                          0)

    dat$lbeangrn <- ifelse(dat$meatleg <= dat$needmeat,
                           dat$T_V_DRKGR,
                           0)

    dat$extrameat <- ifelse(dat$meatleg > dat$needmeat,
                            dat$meatleg - dat$needmeat,
                            0)

    dat$extraleg <- ifelse(dat$meatleg > dat$needmeat,
                           dat$extrameat/4,
                           0)

    dat$lallmeat <- ifelse(dat$meatleg > dat$needmeat,
                           dat$ALLMEAT + dat$needmeat,
                           dat$lallmeat)

    dat$lseaplant <- ifelse(dat$meatleg > dat$needmeat,
                            dat$SEAPLANT + dat$needmeat,
                            dat$lseaplant)

    dat$lvtotal <- ifelse(dat$meatleg > dat$needmeat,
                          dat$T_V_TOTAL + dat$extraleg,
                          dat$lvtotal)

    dat$lbeangrn <- ifelse(dat$meatleg > dat$needmeat,
                           dat$T_V_DRKGR + dat$extraleg,
                           dat$lbeangrn)

    dat$lallmeat <- ifelse(dat$ALLMEAT >= dat$mbmax,
                           dat$ALLMEAT,
                           dat$lallmeat)

    dat$lseaplant <- ifelse(dat$ALLMEAT >= dat$mbmax,
                            dat$SEAPLANT,
                            dat$lseaplant)

    dat$lvtotal <- ifelse(dat$ALLMEAT >= dat$mbmax,
                          dat$T_V_TOTAL + dat$T_V_LEGUMES,
                          dat$lvtotal)

    dat$lbeangrn <- ifelse(dat$ALLMEAT >= dat$mbmax,
                           dat$T_V_DRKGR + dat$T_V_LEGUMES,
                           dat$lbeangrn)

    dat

}