#' FPED data retrieval.
#'
#' \code{get_fped} returns an abridged Food Patterns Equivalents Database (FPED) data set for a given year.
#'
#' @param year year combination of data set to retrieve ... must be one of the following:
#' \itemize{
#' \item "2005/2006"
#' \item "2007/2008"
#' \item "2009/2010"
#' \item "2011/2012"
#' \item "2013/2014"
#' }
#' @param day identifier for survey day to retrieve ... must be one of the following:
#' \itemize{
#' \item "first" (data for study participants from first day)
#' \item "second" (study participant data from second day)
#' \item "both" (data for study participants present in both days, with values averaged across the two days)
#' }
#' @return Object of class \code{data.frame} containing a modified FPED data set for specified year and day. FPED proper contains several more variables than are necessary for computing HEI scores. The data set returned by this function has been trimmed down to contain (in addition to an NHANES unique sequence identifier for each participant, age, and dietary recall status) only the columns of data needed for HEI score calculation, specifically:
#' \itemize{
#' \item T_F_CITMLB: Intact fruits (whole or cut) of citrus, melons, and berries (cup eq.)
#' \item T_PF_EGGS: Eggs (chicken, duck, goose, quail) and egg substitutes (oz. eq.)
#' \item T_F_OTHER: Intact fruits (whole or cut); excluding citrus, melons, and berries (cup eq.)
#' \item T_PF_MPS_TOTAL: Total of meat, poultry, seafood, organ meat, and cured meat (oz. eq.)
#' \item T_PF_SOY: Soy products, excluding calcium fortified soy milk (soymilk) and mature soybeans (oz. eq.)
#' \item T_PF_SEAFD_HI: Seafood (finfish, shellfish, and other seafood) high in n-3 fatty acids (oz. eq.)
#' \item T_PF_SEAFD_LOW: Seafood (finfish, shellfish, and other seafood) low in n-3 fatty acids (oz. eq.)
#' \item T_PF_NUTSDS: Peanuts, tree nuts, and seeds; excludes coconut (oz. eq.)
#' \item T_SOLID_FATS: Fats naturally present in meat, poultry, eggs, and dairy (lard, tallow, and butter); hydrogenated or partially hydrogenated oils; shortening; palm, palm kernel and coconut oils; fat naturally present in coconut meat and cocoa butter; and 50\% of fat present in stick and tub margarines and margarine spreads (grams)
#' \item T_ADD_SUGARS: Foods defined as added sugars (tsp. eq.)
#' \item T_V_TOTAL: Total dark green, red and orange, starchy, and other vegetables; excludes legumes (cup eq.)
#' \item T_V_LEGUMES: Total dark green, red and orange, starchy, and other vegetables; excludes legumes (cup eq.)
#' \item T_V_DRKGR: Dark green vegetables (cup eq.)
#' \item T_F_TOTAL: Total intact fruits (whole or cut) and fruit juices (cup eq.)
#' \item T_G_WHOLE: Grains defined as whole grains and contain the entire grain kernel - the bran, germ, and endosperm (oz. eq.)
#' \item T_D_TOTAL: Total milk, yogurt, cheese, and whey. For some foods, the total dairy values could be higher than the sum of D_MILK, D_YOGURT, and D_CHEESE because miscellaneous dairy component composed of whey is not included in FPED as a separate variable. (cup eq.)
#' \item T_G_REFINED: Refined grains that do not contain all of the components of the entire grain kernel (oz. eq.)
#' }
#' @references \url{https://www.ars.usda.gov/northeast-area/beltsville-md/beltsville-human-nutrition-research-center/food-surveys-research-group/docs/fped-overview/}
#' @export
#' @examples
#' get_fped("2009/2010", "both")
#' get_fped("2005/2006", "first")

get_fped <- function(year, day) {

    yearchoices <- c("fped0506" = "2005/2006",
                     "fped0708"= "2007/2008",
                     "fped0910"="2009/2010",
                     "fped1112"= "2011/2012",
                     "fped1314" = "2013/2014")

    daychoices <- c("both" = "both",
                    "day1" = "first",
                    "day2" = "second")

    try(if(!year %in% yearchoices) stop("must use valid year choice"))

    try(if(!day %in% daychoices) stop("must use valid day choice"))

    fped <- paste0(names(which(yearchoices==year)),
                   "_",
                   names(which(daychoices==day))
    )

    eval(parse(text = fped))

}