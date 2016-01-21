#!/usr/bin/env Rscript

library(data.table)
library(jsonlite)
library(argparse)

parser <- ArgumentParser(description='build summary')
parser$add_argument('source', nargs=1)
parser$add_argument('output', nargs=1)
args <- parser$parse_args()

datasets = fread(args$source)
setkey(datasets, csv)

min_visibility = 0.06

statistics = function(csv) {
    dt = fread(csv)[v > min_visibility]
    return(list(
      mean_A=dt[, mean(A)],
      sd_A=dt[, sd(A)],
      mean_B=dt[, mean(B)],
      sd_B=dt[, sd(B)],
      mean_R=dt[, mean(R)],
      sd_R=dt[, sd(R)]
        )
        )
}

summary = datasets[, c(
    "mean_A", "sd_A", "mean_B", "sd_B", "mean_R", "sd_R"
    ) := statistics(csv), by=csv]

summary = summary[, file := gsub("source/", "", csv)]
write(toJSON(summary), args$output)
