#!/usr/bin/env Rscript

library(data.table)
library(ggplot2)
library(argparse)
library(reshape2)
source("data/model.R")

parser <- ArgumentParser(description='weighted fit')
parser$add_argument('summary', nargs=1)
parser$add_argument('output', nargs=1)
args <- parser$parse_args()


perform_fit_structure_factor = function(mean_R, size) {
    fit = nls(
        mean_R ~ C * mu.total.structure.factor(size),
        start=list(C=1))
    return(fit)
}

perform_fit = function(mean_R, size) {
    fit = nls(
        mean_R ~ C * mu.total(size),
        start=list(C=1))
    return(fit)
}

summary = readRDS(args$summary)
print(summary)

fit = summary[,
    .(
        fit=list(perform_fit(mean_R, size)),
        fit_structure_factor=list(
            perform_fit_structure_factor(mean_R, size))
        )
    ]

print(fit[, fit])
print(fit[, fit_structure_factor])
saveRDS(fit, args$output)
