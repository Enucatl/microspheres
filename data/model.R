structure.factors.file = "data/dfec_structure_factor.csv"
structure.factors = fread(structure.factors.file)

mu.total = function(spectrum, D) {
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

mu.total.structure.factor = function(spectrum, D) {
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
