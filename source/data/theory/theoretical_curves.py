import numpy as np
import click
import csv

from nist_lookup import xraydb_plugin as xdb


@click.command()
@click.argument("spectrum_file", type=click.Path(exists=True))
@click.option("--design_energy", type=int, default=100,
              help="design energy (keV)")
@click.option("--talbot_order", type=int, default=1,
              help="talbot order")
@click.option("--thickness", type=float, default=1.2,
              help="thickness of the SiO2 (cm)")
@click.option("--additional_filter_material",
              help="additional filter for the source")
@click.option("--additional_filter_density", type=float,
              help="density of the additional filter (g/cm^3)")
@click.option("--additional_filter_thickness", type=float,
              help="thickness of the additional filter (cm)")
@click.option("--output", "-o", type=click.File("w"),
              help="output csv file name")
def calculate_spectrum(spectrum_file, design_energy, talbot_order,
                       thickness, additional_filter_material,
                       additional_filter_density,
                       additional_filter_thickness, output):
    spectrum = np.loadtxt(spectrum_file, delimiter=",", skiprows=1)
    output_csv = csv.writer(output)
    output_csv.writerow(
        ["energy", "photons", "n_squared", "beta", "visibility",
            "detector_efficiency", "absorbed_in_sample", "total_weight",
            "total_weight_no_vis"])
    for energy, photons in spectrum:
        visibility = 2 / np.pi * np.fabs(
            np.sin(np.pi / 2 * design_energy / energy)**2 *
            np.sin(talbot_order * np.pi / 2 * design_energy / energy))
        delta, beta, sio2_atlen = xdb.xray_delta_beta(
            'SiO2', 2.65, energy * 1e3)
        delta_air, beta_air, _ = xdb.xray_delta_beta(
            'N2', 1.27e-3, energy * 1e3)
        _, _, plastic_atlen = xdb.xray_delta_beta(
            'C2H4', 1.1, energy * 1e3)
        _, _, al_atlen = xdb.xray_delta_beta(
            'Al', 2.7, energy * 1e3)
        _, _, si_atlen = xdb.xray_delta_beta('Si', 2.33, energy * 1e3)
        detector_efficiency = 1 - np.exp(-2 / si_atlen)
        absorbed_in_sample = np.exp(-thickness / sio2_atlen)
        other_absorption = (
            np.exp(-0.2 / plastic_atlen) *
            np.exp(-0.0016 / al_atlen)
        )  # detector window, holders...
        if additional_filter_material:
            _, _, filter_atlen = xdb.xray_delta_beta(
                additional_filter_material,
                additional_filter_density,
                energy * 1e3)
            other_absorption *= np.exp(
                -additional_filter_thickness / filter_atlen)
        total_weight_no_vis = (
            photons *
            other_absorption *
            detector_efficiency *
            absorbed_in_sample
        )
        total_weight = total_weight_no_vis * visibility
        n_squared = (delta - delta_air) ** 2 + (beta - beta_air) ** 2
        output_csv.writerow(
            [energy, photons, n_squared, beta, visibility,
                detector_efficiency, absorbed_in_sample,
                total_weight, total_weight_no_vis]
        )


if __name__ == '__main__':
    calculate_spectrum()
