#!/usr/bin/env Rscript

library(data.table)
library(jsonlite)
library(argparse)
source("data/model.R")

parser <- ArgumentParser(description='print fit prediction')
parser$add_argument('fit', nargs='+')
parser$add_argument('output', nargs=1)
args <- parser$parse_args()

structure.factors.file = "data/dfec_structure_factor.csv"
structure.factors = fread(structure.factors.file, header=TRUE)
to.predict = tail(structure.factors, nrow(structure.factors) - 11)


predict_dt = function(fit) {
    prediction = data.table(particle_size=to.predict[, diameter])
    prediction$mean_R = predict(fit[[1]], prediction)
    return(prediction)
}

fits = readRDS(args$fit)
prediction = fits[
    , .(
    mean_R=predict_dt(fit)[, mean_R],
    mean_R_structure_factor=predict_dt(fit_structure_factor)[, mean_R],
    particle_size=predict_dt(fit)[, particle_size]
    ), by=description]

write(toJSON(prediction), args$output)
