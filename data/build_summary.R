#!/usr/bin/env Rscript

library(data.table)
library(jsonlite)

files = c(
    "../source/data/S00044_S00063.csv",
    "../source/data/S00064_S00083.csv",
    "../source/data/S00002_S00021.csv",
    "../source/data/S00022_S00041.csv",
    "../source/data/S00043_S00062.csv",
    "../source/data/S00063_S00082.csv",
    "../source/data/S00084_S00103.csv",
    "../source/data/S00104_S00123.csv",
    "../source/data/S00127_S00146.csv",
    "../source/data/S00211_S00230.csv",
    "../source/data/S00169_S00188.csv",
    "../source/data/S00189_S00208.csv",
    "../source/data/S00233_S00252.csv",
    "../source/data/S00253_S00272.csv",
    "../source/data/S00275_S00294.csv",
    "../source/data/S00295_S00314.csv",
    "../source/data/S00317_S00336.csv",
    "../source/data/S00337_S00356.csv"
    )
sizes = c(
    0.166,
    0.166,
    0.261,
    0.261,
    0.507,
    0.507,
    0.690,
    0.690,
    0.890,
    0.890,
    1.18,
    1.18,
    1.54,
    1.54,
    1.70,
    1.70,
    1.86,
    1.86
    ) #um
thicknesses = c(
    45,
    12,
    12,
    45,
    12,
    45,
    12,
    45,
    12,
    45,
    12,
    45,
    12,
    45,
    12,
    45,
    12,
    45
    ) #mm

datasets = data.table(
    file=files,
    particle_size=sizes,
    sample_thickness=thicknesses)
setkey(datasets, file)

summary = datasets[, `:=`(
      mean_A=fread(file)[,mean(A)],
      sd_A=fread(file)[,sd(A)],
      mean_B=fread(file)[,mean(B)],
      sd_B=fread(file)[,sd(B)],
      mean_R=fread(file)[,mean(R)],
      sd_R=fread(file)[,sd(R)]), by=file
    ]
summary = summary[,file := gsub("../source/", "", file)]

print(toJSON(summary))
