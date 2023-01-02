#' produce a tibble with CDC vaccine data
#' @import lubridate
#' @import tibble
#' @param csvpath character(1) path to CSV as distributed at 
#' `https://data.cdc.gov/Vaccinations/COVID-19-Vaccinations-in-the-United-States-Jurisdi/unsk-b7fc`
#' @examples
#' path_12_29 = system.file("cdc/COVID-19_Vaccinations_in_the_United_States_Jurisdiction.csv",
#'   package="teachCovidData")
#' build_vax_tibble(path_12_29)  # retrieved 12/29, data to 12/22
#' @export
build_vax_tibble = function(csvpath) {
 x = read.csv(csvpath)
 dat = x$Date
 ss = strsplit(dat, "/")
 yy = sapply(ss,"[", 3)
 mm = sapply(ss, "[", 1)
 dd = sapply(ss, "[", 2)
 nd = paste(yy,mm,dd,sep="-")
 names(x)[1] = "date_given"
 cdc_vax = cbind(date=lubridate::as_date(nd), x)
 tibble::as_tibble(cdc_vax)
}
