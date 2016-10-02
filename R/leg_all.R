#' allocate legumes for HEI scoring
#'
#' @param dat data to be processed
#' @return data frame of dietary values with legumes allocated appropriately

leg_all <- function(dat) {

    require(magrittr, quietly = TRUE)
    dat %>%
        dplyr::mutate(
            mbmax = 2.5*(TKCAL/1000),
            meatleg = ifelse(ALLMEAT < mbmax, T_V_LEGUMES*4, 0),
            needmeat = ifelse(ALLMEAT < mbmax, mbmax - ALLMEAT, 0),
            lallmeat = ifelse(meatleg <= needmeat, ALLMEAT + meatleg, 0),
            lseaplant = ifelse(meatleg <= needmeat, SEAPLANT + meatleg, 0),
            lvtotal = ifelse(meatleg <= needmeat, T_V_TOTAL, 0),
            lbeangrn = ifelse(meatleg <= needmeat, T_V_DRKGR, 0)
        ) %>%
        dplyr::mutate(
            extrameat = ifelse(meatleg > needmeat, meatleg - needmeat, 0),
            extraleg = ifelse(meatleg > needmeat, extrameat/4, 0),
            lallmeat = ifelse(meatleg > needmeat, ALLMEAT + needmeat, lallmeat),
            lseaplant = ifelse(meatleg > needmeat, SEAPLANT + needmeat, lseaplant),
            lvtotal = ifelse(meatleg > needmeat, T_V_TOTAL + extraleg, lvtotal),
            lbeangrn = ifelse(meatleg > needmeat, T_V_DRKGR + extraleg, lbeangrn)
        ) %>%
        dplyr::mutate(
            lallmeat = ifelse(ALLMEAT >= mbmax, ALLMEAT, lallmeat),
            lseaplant = ifelse(ALLMEAT >= mbmax, SEAPLANT, lseaplant),
            lvtotal = ifelse(ALLMEAT >= mbmax, T_V_TOTAL + T_V_LEGUMES, lvtotal),
            lbeangrn = ifelse(ALLMEAT >= mbmax, T_V_DRKGR + T_V_LEGUMES, lbeangrn)
        )

}