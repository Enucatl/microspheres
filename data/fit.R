#!/usr/bin/env Rscript

library(data.table)
library(jsonlite)
library(ggplot2)

summary = data.table(fromJSON("summary.json"))
setkey(summary, "sample_thickness")

spectrum = function(thickness) {
    if (thickness == 12) {
        return(fread("1.2.csv"))
    }
    else if (thickness == 45) {
        return(fread("4.5.csv"))
    }
}

mu = function(A, n_squared, D, e) {
    d = 1.24e-3 * 20e4 / 2.8 / e
    x = D / d
    f = A * n_squared * e
    if (x <= 1) {
        return(f * x)
    }
    else {
        return(
            A * n_squared * e *
            (x - sqrt(x^2 - 1) * (1 + 2 / x^2) +
            (1 / x - 1 / 4 / x^3) *
            log((x + sqrt(x^2 - 1)) / (x - sqrt(x^2 - 1)))))
    }
}

mu_total = function(spectrum, A, D) {
    return(sapply(D, function(D_) {
        total = spectrum[, mu_e := mu(A, n_squared, D_, energy), by=energy]
        return(total[, mu_e %*% total_weight])
            }))
}

print(mu_total(spectrum(12), 1, 1))

fit = nls(
        mean_R ~ mu_total(spectrum(12), A, particle_size),
        data=summary[sample_thickness==12],
        start=list(A=1e5))

print(summary(fit))
prediction = data.frame(particle_size=seq(0.1, 8, len=100))
prediction$mean_R = predict(fit, prediction)

plot = ggplot(summary[sample_thickness==12]) + 
    geom_point(aes(x=particle_size, y=mean_R)) +
    geom_errorbar(aes(x=particle_size, ymax=mean_R + sd_R, ymin=mean_R -
                      sd_R)) +
    geom_line(data=prediction, aes(x=particle_size, y=mean_R))
print(plot)
warnings()
invisible(readLines(con="stdin", 1))
