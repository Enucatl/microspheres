structure.factors.file = "data/dfec_structure_factor.csv"
structure.factors = fread(structure.factors.file)
spectrum = fread("source/data/theory/12-full-spectrum.csv")
norm = 1 / spectrum[, sum(total_weight)]
spectrum = spectrum[, total_weight := norm * total_weight]

mu.total = function(D) {
    return(sapply(D, function(D_) {
        logB = (
            spectrum[, total_weight] %*%
            structure.factors[diameter == D_, dfec_lynch]
        )
        logA = spectrum[,
                mu_a := beta * energy * 1e3,
                by=energy][
                , mu_a %*% total_weight
                ]
        return(logB / logA)
}))
}

mu.total.structure.factor = function(D) {
    return(sapply(D, function(D_) {
        logB = (
            spectrum[, total_weight] %*%
            structure.factors[diameter == D_, dfec_structure]
        )
        logA = spectrum[,
            mu_a := beta * energy * 1e3,
            by=energy][
            , mu_a %*% total_weight
            ]
        return(logB / logA)
}))
}
