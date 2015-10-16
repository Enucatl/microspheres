.PHONY: all

VPATH = ../spectra

all: 12-full-spectrum.csv 45-full-spectrum.csv 12-hard-spectrum.csv 45-hard-spectrum.csv 12-iron.csv 12-iridium.csv 12-copper.csv

12-full-spectrum.csv: theoretical_curves.py U210-160kVp11deg1000Air0.8Be0Al0Cu0Sn0W0Ta0Wa.csv
	python $< $(word 2, $^) --thickness 1.2 --output $@

45-full-spectrum.csv: theoretical_curves.py U210-160kVp11deg1000Air0.8Be0Al0Cu0Sn0W0Ta0Wa.csv
	python $< $(word 2, $^) --thickness 4.5 --output $@

12-hard-spectrum.csv: theoretical_curves.py U210-160kVp11deg1000Air0.8Be0Al0Cu0Sn0W0Ta0Wa-photonsmorethan50keV.csv
	python $< $(word 2, $^) --thickness 1.2 --output $@

45-hard-spectrum.csv: theoretical_curves.py U210-160kVp11deg1000Air0.8Be0Al0Cu0Sn0W0Ta0Wa-photonsmorethan50keV.csv
	python $< $(word 2, $^) --thickness 4.5 --output $@

12-iron.csv: theoretical_curves.py U210-160kVp11deg1000Air0.8Be0Al0Cu0Sn0W0Ta0Wa.csv
	python $< $(word 2, $^) --thickness 1.2 --additional_filter_material Fe --additional_filter_density 7.874 --additional_filter_thickness 0.01 --output $@

12-iridium.csv: theoretical_curves.py U210-160kVp11deg1000Air0.8Be0Al0Cu0Sn0W0Ta0Wa.csv
	python $< $(word 2, $^) --thickness 1.2 --additional_filter_material Ir --additional_filter_density 22.65 --additional_filter_thickness 0.025 --output $@

12-copper.csv: theoretical_curves.py U210-160kVp11deg1000Air0.8Be0Al0Cu0Sn0W0Ta0Wa.csv
	python $< $(word 2, $^) --thickness 1.2 --additional_filter_material Cu --additional_filter_density 8.92 --additional_filter_thickness 0.1 --output $@
