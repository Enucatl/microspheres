#!/usr/bin/env Rscript

library(data.table)
library(jsonlite)
library(argparse)
source("model.R")

parser <- ArgumentParser(description='print fit prediciton')
parser$add_argument('output', nargs=1)
parser$add_argument('fit', nargs='+')
args <- parser$parse_args()

fits = lapply(args$fit, function(filename) {
    fit <- readRDS(filename)
    match <- gregexpr("(\\d\\d)", filename)[[1]]
    sample_thickness = substring(
                          filename, match[1], match[1] + attr(match, "match.length") - 1)
    prediction = data.table(particle_size=seq(0.1, 8, len=100))
    prediction$mean_R = predict(fit, prediction)
    prediction$sample_thickness = as.numeric(sample_thickness)
    return(prediction)
})
write(toJSON(rbindlist(fits)), args$output)
