.PHONY: all

VPATH = ../source/data/rawdata:../source/data/theory

all: summary.json fit_pars_full_spectrum.json fit_pars_hard_spectrum.json

fit_pars_full_spectrum.json: fit.R 12-full-spectrum.csv 45-full-spectrum.csv
	make -C ../source/data/rawdata
	make -C ../source/data/theory
	./$^ $@ $(subst pars,prediction,$@)

fit_pars_hard_spectrum.json: fit.R 12-hard-spectrum.csv 45-hard-spectrum.csv
	make -C ../source/data/rawdata
	make -C ../source/data/theory
	./$^ $@ $(subst pars,prediction,$@)

summary.json: build_summary.R ../source/data/rawdata/*.csv
	make -C ../source/data/rawdata
	make -C ../source/data/theory
	./$< > $@
