import click
import csv
import numpy as np
from scipy import constants

import logging
import logging.config
from structure_factors.logger_config import config_dictionary

import structure_factors.saxs as saxs
from nist_lookup import xraydb_plugin as xdb

log = logging.getLogger()


@click.command()
@click.option("--grating_pitch", type=float, default=2e-6,
              help="pitch of G2 [m]")
@click.option("--intergrating_distance", type=float, default=12e-2,
              help="pitch of G2 [m]")
@click.option("--volume_fraction", type=float, default=0.5,
              help="fraction of the total volume occupied by the spheres")
@click.option("--sphere_material", default="SiO2",
              help="chemical composition of the spheres")
@click.option("--sphere_density", type=float, default=2.0,
              help="density of the material of the spheres [g/cm³]")
@click.option("--volume_fraction", type=float, default=0.5,
              help="fraction of the total volume occupied by the spheres")
@click.option("--output", type=click.File("w"), default="-",
              help="output file for the csv data")
@click.option("--sampling", type=int, default=1024,
              help="""
              number of cells for the sampling of real and fourier space""")
@click.option("--verbose", is_flag=True, default=False)
def main(
        grating_pitch,
        intergrating_distance,
        volume_fraction,
        sphere_material,
        sphere_density,
        output,
        sampling,
        verbose
        ):
    if verbose:
        config_dictionary['handlers']['default']['level'] = 'DEBUG'
        config_dictionary['loggers']['']['level'] = 'DEBUG'
    logging.config.dictConfig(config_dictionary)
    diameters = np.array([
        0.166,
        0.261,
        0.507,
        0.69,
        0.89,
        1.18,
        1.54,
        1.70,
        1.86,
        3.62,
        7.75,
    ])
    diameters = np.concatenate((diameters, np.linspace(0.1, 8, 100)))
    energies = np.arange(20, 161)
    output_csv = csv.writer(output)
    output_csv.writerow(
        ["energy", "diameter", "dfec_lynch", "dfec_structure"]
    )
    for energy in energies:
        delta_sphere, beta_sphere, _ = xdb.xray_delta_beta(
            sphere_material,
            sphere_density,
            energy * 1e3)
        delta_chi_squared = delta_sphere ** 2 + beta_sphere ** 2
        wavelength = (
            constants.physical_constants["Planck constant in eV s"][0] *
            constants.c / (energy * 1e3)
        )
        autocorrelation_length = (
            wavelength * intergrating_distance / grating_pitch
        )
        real_space_sampling = np.linspace(
            -4 * autocorrelation_length,
            4 * autocorrelation_length,
            sampling,
            endpoint=False,
        )
        for diameter in diameters:
            dfec_lynch = saxs.dark_field_extinction_coefficient(
                wavelength,
                grating_pitch,
                intergrating_distance,
                diameter * 1e-6,
                volume_fraction,
                delta_chi_squared,
                real_space_sampling
            )
            dfec_structure = saxs.dark_field_extinction_coefficient(
                wavelength,
                grating_pitch,
                intergrating_distance,
                diameter * 1e-6,
                volume_fraction,
                delta_chi_squared,
                real_space_sampling,
                saxs.hard_sphere_structure_factor
            )
            output_csv.writerow(
                [energy, diameter, dfec_lynch, dfec_structure]
            )


if __name__ == "__main__":
    main()
