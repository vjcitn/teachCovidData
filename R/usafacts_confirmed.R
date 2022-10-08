#' get confirmed COVID-19 cases from USAfacts.org
#' @param update logical(1) if TRUE will download the data, otherwise use (or populate then use) cache
#' @examples
#' cc = usafacts_confirmed() # confirmed cases by county
#' library(dplyr)
#' MSdata = cc |> filter(State=="MS")
#' head(MSdata[,1:10])
#' dates = lubridate::as_date(names(MSdata[-c(1:4)]))
#' cumulative = apply(MSdata[,-c(1:4)],2,sum)
#' library(ggplot2)
#' mydf1 = data.frame(cumulative, dates)
#' ggplot(mydf1, aes(x=dates, y=cumulative)) + geom_point() + ggtitle("Cumulative Confirmed Covid cases in MS")
#' incid = diff(cumulative)
#' ndate = dates[-1]
#' mydf2 = data.frame(incid, ndate)
#' ggplot(mydf2, aes(x=ndate, y=incid)) + geom_point() + ggtitle("New daily cases in MS")
#' @export
usafacts_confirmed = function(update=FALSE) {
    confirmed_path = s2p_cached_url('https://static.usafacts.org/public/data/covid-19/covid_confirmed_usafacts.csv',
      update=update)
    #confirmed = data.table::fread(confirmed_path)
    read.csv(confirmed_path, check.names=FALSE)
}

#' Assemble new cases by state
#' @param statecode character(1)
#' @import dplyr
#' @examples
#' ncms = new_cases_state("MS")
#' plot(ncms)
#' @export
new_cases_state = function(statecode) {
   cc = usafacts_confirmed() # confirmed cases by county
   avail_states = unique(cc$State)
   stopifnot(statecode %in% avail_states)
   Sdata = cc |> dplyr::filter(State==statecode)
   dates = lubridate::as_date(names(Sdata[-c(1:4)]))
   cumulative = apply(Sdata[,-c(1:4)],2,sum)
#   library(ggplot2)
#   mydf1 = data.frame(cumulative, dates)
#   ggplot(mydf1, aes(x=dates, y=cumulative)) + geom_point() + ggtitle("Cumulative Confirmed Covid cases in MS")
   incid = diff(cumulative)
   date = dates[-1]
   ans = data.frame(incid, date, state=statecode)
   class(ans) = c("tcov_deltaconf_daily_state", "data.frame")
   ans
}

#' plot daily new cases for a state
#' @import ggplot2
#' @export
plot.tcov_deltaconf_daily_state = function(x, y, ...) {
 ggplot(x, aes(x=date, y=incid)) + geom_point() + ggtitle(paste("Daily new confirmed cases for", x$state[1]))
}
