#!/usr/bin/env Rscript

library(data.table)
library(jsonlite)
library(argparse)
source("data/model.R")

parser <- ArgumentParser(description='print fit prediciton')
parser$add_argument('output', nargs=1)
parser$add_argument('fit', nargs='+')
args <- parser$parse_args()

fits = lapply(args$fit, function(filename) {
    fit <- readRDS(filename)
    prediction = data.table(particle_size=seq(0.1, 8, len=100))
    prediction$mean_R = predict(fit, prediction)
    return(prediction)
})

write(toJSON(rbindlist(fits)), args$output)
