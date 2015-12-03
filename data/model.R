mu = function(A, n_squared, D, e) {
    # distance = 20cm = 20e4 um
    # hc = 1.24e-3 um keV
    # period = 2.8 um
    autocorrelation_factor = 1.24e-3 * 20e4 / 2.8
    d = autocorrelation_factor / e
    x = D / d
    f = A * n_squared * e
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
        logB = spectrum[,
                mu_e := mu(A * 1000, n_squared, D_, energy),
                by=energy][
                , mu_e %*% total_weight
                ]
        logA = spectrum[,
                mu_a := beta * energy,
                by=energy][
                , mu_a %*% total_weight
                ]
        return(logB / logA)
            }))
}
