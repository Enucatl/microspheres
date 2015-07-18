#!/usr/bin/env Rscript

library(data.table)
library(jsonlite)

summary = data.table(fromJSON("summary.json"))
setkey(summary, "sample_thickness")
print(summary)
spectrum = function(thickness) {
    if (thickness == 12) {
        return(fread("1.2.csv"))
    }
    else if (thickness == 45) {
        return(fread("4.5.csv"))
    }
}
print(spectrum(12))
print(spectrum(45))

mu = function(A, n, D, e) {
    d = 1.24e-3 * 20e4 / 2.8 / e
    x = D / d
    f = A * n^2 * e
    if (x <= 1) {
        return(f * x)
    }
    else {
        return(A * n^2 * e * (x - sqrt(x^2 - 1)(1 + 2 / x^2) + (1 / x - 1 /
                                                                4 / x^3) *
                              log((x + (x^2 - 1)) / (x - x^2 - 1)))
    }
}
