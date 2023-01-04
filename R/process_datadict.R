#' produce tables from xlsx data dictionary
#' @import readxl
#' @param path character(1) path to xlsx file with data dictionary in several sheets
#' @param quiet logical(1) if TRUE (default) suppress messages about column names from read_xlsx
#' @param simplify_names logical(1) if TRUE (default) remove inessential elements of sheet names
#' @note Original xlsx file retrieved from \url{https://data.cdc.gov/api/views/unsk-b7fc/files/bfb13090-4148-4f48-9d5a-e1d1c2fb93b3?download=true&filename=DataDictionary_v36_12082022.xlsx} in early 2023.
#' @return list of data.frames
#' @examples
#' pa = system.file("cdc/VACCDataDictionary_v36_12082022.xlsx", package="teachCovidData")
#' pd = process_datadict(pa)
#' names(pd)
#' head(pd[[1]])
#' @export
process_datadict = function(path, quiet=TRUE, simplify_names=TRUE) {
 sh = excel_sheets(path)
 nsh = length(sh)
 wr = force
 if (quiet) wr = suppressMessages
 ans = wr(lapply(seq_len(nsh), function(i) as.data.frame(read_xlsx(path, sheet=i))))
 if (simplify_names) {
  sh = gsub("Vaccination_", "", sh)
  sh = gsub("_", " ", sh)
  }
 names(ans) = sh
 ans
}

#' produce shiny app from processed data dictionary
#' @import shiny
#' @param pd output of \code{\link{process_datadict}}
#' @examples
#' if (interactive()) {
#'  pa = system.file("cdc/VACCDataDictionary_v36_12082022.xlsx", package="teachCovidData")
#'  pd = process_datadict(pa)
#'  datadict_app(pd)
#' }
#' @export
datadict_app = function(pd) {
 ui = fluidPage(
  sidebarLayout(
   sidebarPanel(
    helpText("Select a page of the CDC Vaccination Trends data dictionary:"),
    selectInput("type", "page", choices=names(pd)), width=2
   ),
   mainPanel(
    tabsetPanel(
     tabPanel("dict",
      DT::dataTableOutput("curtab")),
     tabPanel("about", helpText("From https://data.cdc.gov/api/views/unsk-b7fc/files/bfb13090-4148-4f48-9d5a-e1d1c2fb93b3?download=true&filename=DataDictionary_v36_12082022.xlsx"))
      )
     )
    )
   )
 server = function(input, output) {
  output$curtab = DT::renderDataTable({
   DT::datatable(pd[[input$type]], options=list(lengthMenu=c(50,100)))
  })
 }
 runApp(list(ui=ui, server=server))
}
 
