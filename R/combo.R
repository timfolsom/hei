#' combine datasets to be used in HEI scoring
#'
#' @param fped food pattern equivalent database data
#' @param diet dietary data from NHANES database
#' @param demograph demographic data from NHANES database
#' @param agethresh numeric threshold for age of survey participants to be included
#' @export
#' @importFrom (magrittr,"%>%")
#' @return data frame of combined fped, dietary and demographic data

combo <- function(fped, diet, demograph, agethresh = 2) {

    require(magrittr, quietly = TRUE)

    fped %>%
        dplyr::left_join(diet, by = "SEQN") %>%
        dplyr::left_join(demograph, by = "SEQN") %>%
        # need to be at least 2 years old and there should be recall
        dplyr::filter_(~RIDAGEYR >= agethresh) %>%
        dplyr::filter_(~DRSTZ == 1) %>%
        # # create combo variables
        dplyr::mutate(
            WHOLEFRT = ~T_F_CITMLB + T_F_OTHER,
            MONOPOLY = ~TMFAT + TPFAT,
            ALLMEAT = ~T_PF_MPS_TOTAL + T_PF_EGGS + T_PF_NUTSDS + T_PF_SOY,
            SEAPLANT = ~T_PF_SEAFD_HI + T_PF_SEAFD_LOW + T_PF_NUTSDS + T_PF_SOY,
            ADDSUGC = 16*~T_ADD_SUGARS,
            SOLFATC = 9*~T_SOLID_FATS,
            MAXALCGR = 13 *(~TKCAL/1000),
            EXALCCAL = ifelse(~TALCO <= ~MAXALCGR, 0, 7*(~TALCO-~MAXALCGR)),
            EMPTYCAL10 = ~ADDSUGC + SOLFATC + EXALCCAL
        )
}