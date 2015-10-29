#!/usr/bin/env Rscript

library(data.table)
library(jsonlite)
library(ggplot2)
library(argparse)
library(reshape2)
source("data/model.R")

parser <- ArgumentParser(description='weighted fit')
parser$add_argument('summary', nargs=1)
parser$add_argument('output', nargs=1)
args <- parser$parse_args()


perform_fit = function(spectrum_file, mean_R, particle_size) {
    spectrum = fread(spectrum_file[1])
    norm = 1000 / spectrum[, sum(total_weight)]
    spectrum = spectrum[, total_weight := norm * total_weight]
    fit = nls(
              mean_R ~ R0 + mu_total(spectrum, C, particle_size),
              start=list(C=1e4, R0=2.3))
    return(fit)
}

summary = data.table(fromJSON(args$summary))
fit = summary[, .(fit=list(perform_fit(spectrum, mean_R,
                                       particle_size))),
              by=description]
saveRDS(fit, args$output)
