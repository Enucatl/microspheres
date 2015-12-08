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

# structure factor from http://pubs.acs.org/doi/pdf/10.1021/ma00139a013
η <- 0.5
α <- function(η) { return((1 + 2 * η) ^ 2 / (1 - η) ^ 4)}
β <- function(η) { return(-6 * η * (1 + 0.5 * η) ^ 2 / (1 - η) ^ 4)}
γ <- function(η) { return(0.5 * η * (1 + 2 * η) ^ 2 / (1 - η) ^ 4)}

G <- function(A, η) {
    return(
        α(η) / A ^ 2 * (sin(A) - A * cos(A)) +
        β(η) / A ^ 3 * (2 * A * sin(A) + (2 - A ^ 2) * cos(A) - 2) +
        γ(η) / A ^ 5 * (
            -A ^ 4 * cos(A) +
            4 * (3 * (A ^ 2) - 6) * cos(A) +
            4 * (A ^ 3 - 6 * A) * sin(A) +
            24)
    )
}

S <- function(A, η) {
    return(1 / (1 + 24 * η * G(A, η) / A))
}

structure.factor <- function(particle_size, energy) {
    p <- 2.8e-6  # grating G2 period (m)
    L <- 18e-2  # intergrating distance (m)
    hc <- 1.24e-3  # um * keV
    λ <- hc / energy  # um
    Q <- 2 * pi / λ * p / L  # um^-1
    R <- particle_size / 2
    A <- Q * particle_size
    return(S(A, η))
}

mu.total = function(spectrum, A, D) {
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

mu.total.structure.factor = function(spectrum, A, D) {
    return(sapply(D, function(D_) {
        logB = spectrum[,
            mu_e := (
                mu(A * 1000, n_squared, D_, energy) * 
                structure.factor(D_, energy)
                ),
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
