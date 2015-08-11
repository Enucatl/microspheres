#!/usr/bin/env Rscript

library(data.table)
library(jsonlite)
library(ggplot2)

summary = data.table(fromJSON("summary.json"))
setkey(summary, "sample_thickness")

spectrum = function(thickness) {
    if (thickness == 12) {
        return(fread("../source/data/1.2.csv"))
    }
    else if (thickness == 45) {
        return(fread("../source/data/4.5.csv"))
    }
}

mu = function(A, n_squared, D, e, beta) {
    # distance = 20cm = 20e4 um
    # hc = 1.24e-3 um keV
    # period = 2.8 um
    autocorrelation_factor = 1.24e-3 * 20e4 / 2.8
    d = autocorrelation_factor / e
    x = D / d
    f = A * n_squared / beta
    if (x <= 1) {
        return(f * x)
    }
    else {
        return(
            f * (x - sqrt(x^2 - 1) * (1 + 1 / 2 / x^2) +
            (1 / x - 1 / 4 / x^3) *
            log((x + sqrt(x^2 - 1)) / (x - sqrt(x^2 - 1)))))
    }
}

mu_total = function(spectrum, A, D) {
    return(sapply(D, function(D_) {
        total = spectrum[, mu_e := mu(A, n_squared, D_, energy, beta), by=energy]
        return(total[, mu_e %*% total_weight])
            }))
}

perform_fit = function(thickness) {
    fit = nls(
              mean_R ~ B + mu_total(spectrum(thickness), A, particle_size),
              data=summary[sample_thickness==thickness],
              start=list(A=1e4, B=2.3))

    fit_dt = data.table(summary(fit)$parameters)
    dt = data.table(
        A=signif(1000 * fit_dt[1, "Estimate", with=FALSE][[1]], 3),
        err_A=signif(1000 * fit_dt[1, "Std. Error", with=FALSE][[1]], 2),
        B=signif(fit_dt[2, "Estimate", with=FALSE][[1]], 3),
        err_B=signif(fit_dt[2, "Std. Error", with=FALSE][[1]], 2),
        sample_thickness=thickness
        )
    prediction = data.table(particle_size=seq(0.1, 8, len=100))
    prediction$mean_R = predict(fit, prediction)
    prediction$sample_thickness = thickness
    return(list(prediction=prediction, fit_pars=dt))
}

fits = list(perform_fit(12), perform_fit(45))
prediction = rbindlist(list(fits[[1]]$prediction, fits[[2]]$prediction))
pars = rbindlist(list(fits[[1]]$fit_pars, fits[[2]]$fit_pars))
print(fits)


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
write(toJSON(pars), "fit_pars.json")

#warnings()
invisible(readLines(con="stdin", 1))
