
stubrmd = function(titletext="A2 Acquiring data on COVID-19 using downloads and 'APIs'",
    estring="%\\VignetteEngine{knitr::rmarkdown}", vistring="%\\VignetteIndexEntry") {
qt = dQuote(titletext)
stub = "
---
title: %s
author: 'Vincent J. Carey, stvjc at channing.harvard.edu'
date: '`r Sys.Date()`'
output:
vignette: >
  %s
  %s{%s}
  BiocStyle::html_document:
    highlight: pygments
    number_sections: yes
    theme: united
    toc: yes
---

# Introduction

[Add material]
"
sprintf(stub, qt, estring, vistring, titletext)
}

runstubs = function(stublist) {
  tst = stublist[[1]]
  stopifnot(all(names(tst)==c("filename", "title")))
  lapply(stublist, function(x) {title=x[[2]]; fn=x[[1]]; writeLines(stubrmd(title), con=paste0(fn, ".Rmd"))})
}
stublist1 = list(
  c(filename="A3dictionaries", title="A3 Dictionaries and metadata on COVID-19 resources"),
  c(filename="B1Inftiming", title="B1 US Infection reports: timing"),
  c(filename="B2InfGeo", title="B2 US Infection reports: geography"),
  c(filename="B3InfDemog", title="B3 US Infection reports: demographics"),
  c(filename="C1Vacctypes", title="C1 US Vaccination: types and series"),
  c(filename="C2Vacctiming", title="C2 US Vaccination timing/geography"),
  c(filename="C3VaccDemog", title="C3 US Vaccination demographics"),
  c(filename="D1Pathobasics", title="D1 Pathogen evolution: basic concepts"),
  c(filename="D2GSAIDdata", title="D2 GISAID, Nextstrain and other tracking resources"),
  c(filename="D3VOC", title="D3 Defining 'variants of concern'"),
  c(filename="E1SeroEpi", title="E3 Vaccine strategies: seroepidemiology"),
  c(filename="E2VacTrials", title="E2 Vaccine clinical trials"),
  c(filename="E3CorrProt", title="E3 Defining vaccine protection"))

runstubs(stublist1)
 
#
#---
#title: "A2 Acquiring data on COVID-19 using downloads and 'APIs'"
#author: "Vincent J. Carey, stvjc at channing.harvard.edu"
#date: "`r format(Sys.time(), '%B %d, %Y')`"
#vignette: >
#  %\VignetteEngine{knitr::rmarkdown}
#  %\VignetteIndexEntry{A2 Acquiring data on COVID-19 using downloads and 'APIs'}
#  %\VignetteEncoding{UTF-8}
#output:
#  BiocStyle::html_document:
#    highlight: pygments
#    number_sections: yes
#    theme: united
#    toc: yes
#---
#
#```{r setup, echo=FALSE, results="hide"}
#suppressMessages({
#suppressPackageStartupMessages({
#library(teachCovidData)
#library(ggplot2)
#})
#})
#```
#
## Introduction
#
