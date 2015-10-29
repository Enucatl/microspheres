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
        err_C=signif(fit_dt[1, "Std. Error", with=FALSE][[1]], 2),
        R0=signif(fit_dt[2, "Estimate", with=FALSE][[1]], 3),
        err_R0=signif(fit_dt[2, "Std. Error", with=FALSE][[1]], 2)
    )
    return(dt)
}

fits = readRDS(args$fit)
pars = fits[
    , .(
        R0=print_pars(fit)[, R0],
        err_R0=print_pars(fit)[, err_R0],
        C=print_pars(fit)[, C],
        err_C=print_pars(fit)[, err_C]
    ), by=description]
write(toJSON(pars), args$output)
