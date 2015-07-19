.PHONY: all

all: summary.json fit_prediction.json

fit_prediction.json: fit.R 1.2.csv 4.5.csv
	./fit.R

summary.json: build_summary.R ../source/data/*.csv
	./build_summary.R > summary.json

1.2.csv: theoretical_curves.py
	python $< "spectra/U210 - 160kVp 45deg 1000Air 0Be 0Al 0Cu 0Sn 0W 0Ta 0Wa.csv" --thickness 1.2

4.5.csv: theoretical_curves.py
	python $< "spectra/U210 - 160kVp 45deg 1000Air 0Be 0Al 0Cu 0Sn 0W 0Ta 0Wa.csv" --thickness 4.5

%.csv: %.hdf5 ../source/data/Makefile
	make -C ../source/data `basename $@`
