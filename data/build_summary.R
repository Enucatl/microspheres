#!/usr/bin/env Rscript

library(data.table)
library(jsonlite)

files = c(
    "../source/data/rawdata/S00044_S00063.csv",
    "../source/data/rawdata/S00064_S00083.csv",
    "../source/data/rawdata/S00002_S00021.csv",
    "../source/data/rawdata/S00022_S00041.csv",
    "../source/data/rawdata/S00043_S00062.csv",
    "../source/data/rawdata/S00063_S00082.csv",
    "../source/data/rawdata/S00084_S00103.csv",
    "../source/data/rawdata/S00104_S00123.csv",
    "../source/data/rawdata/S00127_S00146.csv",
    "../source/data/rawdata/S00211_S00230.csv",
    "../source/data/rawdata/S00169_S00188.csv",
    "../source/data/rawdata/S00189_S00208.csv",
    "../source/data/rawdata/S00233_S00252.csv",
    "../source/data/rawdata/S00253_S00272.csv",
    "../source/data/rawdata/S00275_S00294.csv",
    "../source/data/rawdata/S00295_S00314.csv",
    "../source/data/rawdata/S00317_S00336.csv",
    "../source/data/rawdata/S00337_S00356.csv",
    "../source/data/rawdata/S00359_S00378.csv",
    "../source/data/rawdata/S00379_S00398.csv",
    "../source/data/rawdata/S00401_S00420.csv",
    "../source/data/rawdata/S00421_S00440.csv"
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
    1.86,
    3.62,
    3.62,
    7.75,
    7.75
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
summary = summary[, file := gsub("../source/", "", file)]

summary12 = summary[sample_thickness==12]
summary45 = summary[sample_thickness==45]
write(toJSON(summary12), "summary12.json")
write(toJSON(summary45), "summary45.json")
