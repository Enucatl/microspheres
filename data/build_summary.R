#!/usr/bin/env Rscript

library(data.table)
library(jsonlite)
filters = c(
    "None",
    "None",
    "None",
    "None",
    "None",
    "None",
    "None",
    "None",
    "None",
    "None",
    "None",
    "None",
    "None",
    "None",
    "None",
    "None",
    "None",
    "None",
    "None",
    "None",
    "None",
    "None"
    )  # mm

datasets = data.table(
    file=files,
    particle_size=sizes,
    sample_thickness=thicknesses,
    filter=filters)
setkey(datasets, file)

summary = datasets[, `:=`(
      mean_A=fread(file)[,mean(A)],
      sd_A=fread(file)[,sd(A)],
      mean_B=fread(file)[,mean(B)],
      sd_B=fread(file)[,sd(B)],
      mean_R=fread(file)[,mean(R)],
      sd_R=fread(file)[,sd(R)]), by=file
    ]
summary = summary[, file := gsub("../source/", "", file)]

summary12 = summary[sample_thickness==12 & filter=="None"]
summary45 = summary[sample_thickness==45 & filter=="None"]
write(toJSON(summary12), "summary12.json")
write(toJSON(summary45), "summary45.json")
write(toJSON(summary), "summary.json")
