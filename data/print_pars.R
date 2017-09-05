#!/usr/bin/env Rscript

library(data.table)
library(jsonlite)
library(argparse)
source("data/model.R")

parser <- ArgumentParser(description='print fit pars')
parser$add_argument('fit', nargs=1)
parser$add_argument('output', nargs=1)
args <- parser$parse_args()

fits = readRDS(args$fit)

print_pars = function(fit) {
    fit_dt <- data.table(summary(fit[[1]])$parameters)
    dt = data.table(
        C=signif(fit_dt[1, "Estimate", with=FALSE][[1]], 2),
        err_C=signif(fit_dt[1, "Std. Error", with=FALSE][[1]], 2)
    )
    return(dt)
}

pars = fits[
    , .(
        C=print_pars(fit)[, C],
        err_C=print_pars(fit)[, err_C]
    )]
write(toJSON(pars), args$output)
