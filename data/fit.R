#!/usr/bin/env Rscript

library(data.table)
library(jsonlite)
library(ggplot2)
library(argparse)
source("model.R")

parser <- ArgumentParser(description='weighted fit')
parser$add_argument('spectrum', nargs=1)
parser$add_argument('summary', nargs=1)
parser$add_argument('output', nargs=1)
args <- parser$parse_args()

perform_fit = function(spectrum, summary) {
    return(nls(
              mean_R ~ B + mu_total(spectrum, A, particle_size),
              data=summary,
              start=list(A=1e4, B=2.3))
    )
}

summary = data.table(fromJSON(args$summary))
spectrum = fread(args$spectrum)
norm = 1000 / spectrum[, sum(total_weight)]
spectrum = spectrum[, total_weight := norm * total_weight]
fit = perform_fit(spectrum, summary)
attr(fit, "sample_thickness") = summary[1, sample_thickness]
saveRDS(fit, args$output)
