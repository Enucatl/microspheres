#!/usr/bin/env Rscript

library(data.table)
library(jsonlite)
library(argparse)

parser <- ArgumentParser(description='build summary')
parser$add_argument('source', nargs=1)
parser$add_argument('output', nargs=1)
args <- parser$parse_args()

min_visibility = 0.05
table = readRDS(args$source)[v > min_visibility]

statistics = function(A, B, R, size) {
    return(list(
      mean_A=mean(A),
      sd_A=sd(A),
      mean_B=mean(B),
      sd_B=sd(B),
      mean_R=mean(R),
      sd_R=sd(R)
        )
        )
}

setkey(table, size)
summary = table[, statistics(A, B, R), by=size]
print(summary)

saveRDS(summary, args$output)
