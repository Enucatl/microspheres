import click
import h5py
import numpy as np
import os
import csv

@click.command()
@click.argument('input_file', type=click.Path(exists=True))
@click.option('--crop', nargs=2, type=int)
def main(input_file, crop):
    input_dataset = h5py.File(input_file)['postprocessing/dpc_reconstruction']
    visibility = h5py.File(input_file)['postprocessing/visibility'][0, crop[0]:crop[1]]
    cropped = input_dataset[0, crop[0]:crop[1], ...]
    swapped = np.swapaxes(cropped, 0, 1)
    output_file = os.path.splitext(input_file)[0] + ".csv"
    with open(output_file, "w") as output:
        writer = csv.writer(output)
        writer.writerow(["row", "pixel", "A", "B", "R", "v"])
        for i, row in enumerate(swapped):
            for j, pixel in enumerate(row):
                a, _, b = pixel
                v = visibility[j, i]
                r = np.log(b)/np.log(a)
                writer.writerow([i, j, a, b, r, v])

if __name__ == '__main__':
    main()
