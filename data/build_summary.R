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

summary = datasets[, `:=`(
      mean_A=fread(csv)[,mean(A)],
      sd_A=fread(csv)[,sd(A)],
      mean_B=fread(csv)[,mean(B)],
      sd_B=fread(csv)[,sd(B)],
      mean_R=fread(csv)[,mean(R)],
      sd_R=fread(csv)[,sd(R)]), by=csv
    ]

summary = summary[, file := gsub("source/", "", csv)]
write(toJSON(summary), args$output)
