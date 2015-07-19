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
    # distance = 20cm = 20e4 um
    # hc = 1.24e-3 um keV
    # period = 2.8 um
    autocorrelation_factor = 1.24e-3 * 20e4 / 2.8
    d =  autocorrelation_factor / e
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

perform_fit = function(thickness) {
    fit = nls(
              mean_R ~ B + mu_total(spectrum(thickness), A, particle_size),
              data=summary[sample_thickness==thickness],
              start=list(A=1e5, B=2))

    print(summary(fit))
    prediction = data.table(particle_size=seq(0.1, 8, len=100))
    prediction$mean_R = predict(fit, prediction)
    prediction$sample_thickness = thickness
    return(prediction)
}

prediction = rbindlist(list(perform_fit(12), perform_fit(45)))

plot = ggplot(summary) + 
    geom_point(aes(x=particle_size, y=mean_R, group=sample_thickness,
                   colour=factor(sample_thickness)), size=5) +
    geom_errorbar(aes(x=particle_size, ymax=mean_R + sd_R, ymin=mean_R -
                      sd_R)) +
    geom_line(data=prediction, aes(x=particle_size, y=mean_R,
                                   group=sample_thickness,
                                   colour=factor(sample_thickness))) +
    labs(
         x="particle size (μm)",
         y="ratio of the logs",
         colour="sample thickness (mm)")
X11(width=14, height=10)
print(plot)
write(toJSON(prediction), "fit_prediction.json")

warnings()
invisible(readLines(con="stdin", 1))
