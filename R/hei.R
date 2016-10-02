#' calculates individual HEI scores
#'
#' @param dat data to be scored
#' @return data frame of HEI data

hei <- function(dat) {

    dat %>%
        # heiveg
        # total veggies
        dplyr::mutate(
            vegden = lvtotal / (TKCAL/1000),
            heiveg = 5*(vegden/1.1),
            heiveg = ifelse(heiveg > 5, 5, heiveg)
        ) %>%
        # heibngrn
        # beans and greens
        dplyr::mutate(
            bngrden = lbeangrn / (TKCAL/1000),
            heibngrn = 5*(bngrden/0.2),
            heibngrn  = ifelse(heibngrn  > 5, 5, heibngrn)
        ) %>%
        # heitotfr
        # total fruit
        dplyr::mutate(
            frtden = T_F_TOTAL/(TKCAL/1000),
            heitotfrt = 5*(frtden/0.8),
            heitotfrt = ifelse(heitotfrt > 5, 5, heitotfrt)
        ) %>%
        # heiwholefrt
        # whole fruit
        dplyr::mutate(
            wholefrtden = WHOLEFRT/(TKCAL/1000),
            heiwholefrt = 5*(wholefrtden/0.4),
            heiwholefrt = ifelse(heiwholefrt > 5, 5, heiwholefrt)
        ) %>%
        # heiwholegrain
        # whole grain
        dplyr::mutate(
            wholegrainden = T_G_WHOLE/(TKCAL/1000),
            heiwholegrain = 10*(wholegrainden/1.5),
            heiwholegrain = ifelse(heiwholegrain > 10, 10, heiwholegrain)
        ) %>%
        # heidairy
        # dairy
        dplyr::mutate(
            dairyden = T_D_TOTAL/(TKCAL/1000),
            heidairy = 10*(dairyden/1.3),
            heidairy = ifelse(heidairy > 10, 10, heidairy)
        ) %>%
        # heitotpro
        # total protein
        dplyr::mutate(
            totproden = lallmeat/(TKCAL/1000),
            heitotpro = 5*(totproden/2.5),
            heitotpro = ifelse(heitotpro > 5, 5, heitotpro)
        ) %>%
        # heiseaplantpro
        # seaplant protein
        dplyr::mutate(
            seaplantden = lseaplant/(TKCAL/1000),
            heiseaplantpro = 5*(seaplantden/0.8),
            heiseaplantpro = ifelse(heiseaplantpro > 5, 5, heiseaplantpro)
        ) %>%
        # heifattyacid
        # fatty acid
        dplyr::mutate(
            faratio = ifelse(TSFAT > 0, MONOPOLY / TSFAT, 0),
            heifattyacid = ifelse(TSFAT == 0 & MONOPOLY == 0, 10, NA),
            heifattyacid = ifelse(TSFAT == 0 & MONOPOLY > 0, 10, heifattyacid),
            heifattyacid = ifelse(faratio >= 2.5, 10, heifattyacid),
            heifattyacid = ifelse(faratio <= 1.2, 0, heifattyacid),
            heifattyacid = ifelse(is.na(heifattyacid), 10*((faratio-1.2)/(2.5-1.2)), heifattyacid)
        ) %>%
        # heisodi
        # sodium
        dplyr::mutate(
            sodden = TSODI / TKCAL,
            heisodi = ifelse(sodden <= 1.1, 10, NA),
            heisodi = ifelse(sodden >= 2.0, 0, heisodi),
            heisodi = ifelse(is.na(heisodi), 10 - (10*(sodden - 1.1)/(2.0-1.1)), heisodi)
        ) %>%
        # heirefgrain
        # refined grain
        dplyr::mutate(
            refgrainnden = T_G_WHOLE / (TKCAL/1000),
            heirefgrain = ifelse(refgrainnden <= 1.8, 10, NA),
            heirefgrain = ifelse(refgrainnden >= 4.3, 0, heirefgrain),
            heirefgrain = ifelse(is.na(heirefgrain), 10 - (10*(refgrainnden - 1.8)/(4.3-1.8)), heirefgrain)
        ) %>%
        # heirefgrain
        # refined grain
        dplyr::mutate(
            refgrainnden = T_G_REFINED / (TKCAL/1000),
            heirefgrain = ifelse(refgrainnden <= 1.8, 10, NA),
            heirefgrain = ifelse(refgrainnden >= 4.3, 0, heirefgrain),
            heirefgrain = ifelse(is.na(heirefgrain), 10 - (10*(refgrainnden - 1.8)/(4.3-1.8)), heirefgrain)
        ) %>%
        # heisofaas
        # ????
        dplyr::mutate(
            sofa_perc = 100* (EMPTYCAL10/TKCAL),
            heisofaas = ifelse(sofa_perc >= 50, 0, NA),
            heisofaas = ifelse(sofa_perc <= 19, 20, heisofaas),
            heisofaas = ifelse(is.na(heisofaas), 20 - (20*(sofa_perc-19)/(50-19)), heisofaas)
        ) %>%
        dplyr::mutate(heitotal = heiveg + heibngrn + heitotfrt + heiwholefrt + heiwholegrain + heidairy + heitotpro + heiseaplantpro + heifattyacid + heirefgrain + heisofaas + heisodi)

}