.PHONY: all

VPATH = ../spectra

all: 12-full-spectrum.csv 45-full-spectrum.csv 12-hard-spectrum.csv 45-hard-spectrum.csv

12-full-spectrum.csv: theoretical_curves.py U210-160kVp11deg1000Air0.8Be0Al0Cu0Sn0W0Ta0Wa.csv
	python $< $(word 2, $^) --thickness 1.2 --output $@

45-full-spectrum.csv: theoretical_curves.py U210-160kVp11deg1000Air0.8Be0Al0Cu0Sn0W0Ta0Wa.csv
	python $< $(word 2, $^) --thickness 4.5 --output $@

12-hard-spectrum.csv: theoretical_curves.py U210-160kVp11deg1000Air0.8Be0Al0Cu0Sn0W0Ta0Wa-photonsmorethan50keV.csv
	python $< $(word 2, $^) --thickness 1.2 --output $@

45-hard-spectrum.csv: theoretical_curves.py U210-160kVp11deg1000Air0.8Be0Al0Cu0Sn0W0Ta0Wa-photonsmorethan50keV.csv
	python $< $(word 2, $^) --thickness 4.5 --output $@
