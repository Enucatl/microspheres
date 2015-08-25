#!/usr/bin/env Rscript

library(data.table)
library(jsonlite)
library(argparse)
source("model.R")

parser <- ArgumentParser(description='print fit pars')
parser$add_argument('output', nargs=1)
parser$add_argument('fit', nargs='+')
args <- parser$parse_args()

fits = lapply(args$fit, function(filename) {
    fit <- readRDS(filename)
    fit_dt <- data.table(summary(fit)$parameters)
    match <- gregexpr("(\\d\\d)", filename)[[1]]
    sample_thickness = substring(
                          filename, match[1], match[1] + attr(match, "match.length") - 1)
    dt = data.table(
                    A=signif(fit_dt[1, "Estimate", with=FALSE][[1]], 2),
                    err_A=signif(fit_dt[1, "Std. Error", with=FALSE][[1]], 2),
                    B=signif(fit_dt[2, "Estimate", with=FALSE][[1]], 3),
                    err_B=signif(fit_dt[2, "Std. Error", with=FALSE][[1]], 2),
                    sample_thickness=as.numeric(sample_thickness)
                    )
    return(dt)
})
write(toJSON(rbindlist(fits)), args$output)
