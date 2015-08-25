.PHONY: all

VPATH = ../source/data/rawdata:../source/data/theory

all: fit_pars_hard_spectrum.json fit_pars_full_spectrum.json fit_prediction_full_spectrum.json fit_prediction_hard_spectrum.json summary-hard-spectrum.png summary-full-spectrum.png

summary-hard-spectrum.png: plot.R summary.json fit_prediction_hard_spectrum.json
	./$^ $@

summary-full-spectrum.png: plot.R summary.json fit_prediction_full_spectrum.json
	./$^ $@

fit_prediction_full_spectrum.json: print_prediction.R fit12_full_spectrum.rds fit45_full_spectrum.rds
	./$< $@ $(word 2, $^) $(word 3, $^)

fit_prediction_hard_spectrum.json: print_prediction.R fit12_hard_spectrum.rds fit45_hard_spectrum.rds
	./$< $@ $(word 2, $^) $(word 3, $^)

fit_pars_hard_spectrum.json: print_fit.R fit12_hard_spectrum.rds fit45_hard_spectrum.rds
	./$< $@ $(word 2, $^) $(word 3, $^)

fit_pars_full_spectrum.json: print_fit.R fit12_full_spectrum.rds fit45_full_spectrum.rds
	./$< $@ $(word 2, $^) $(word 3, $^)

summary.json: build_summary.R ../source/data/rawdata/*.csv
	make -C ../source/data/rawdata
	make -C ../source/data/theory
	./$<

summary12.json: build_summary.R ../source/data/rawdata/*.csv
	make -C ../source/data/rawdata
	make -C ../source/data/theory
	./$<

summary45.json: build_summary.R ../source/data/rawdata/*.csv
	make -C ../source/data/rawdata
	make -C ../source/data/theory
	./$<

fit12_full_spectrum.rds: fit.R 12-full-spectrum.csv summary12.json 
	./$^ $@

fit45_full_spectrum.rds: fit.R 45-full-spectrum.csv summary45.json 
	./$^ $@

fit12_hard_spectrum.rds: fit.R 12-hard-spectrum.csv summary12.json 
	./$^ $@

fit45_hard_spectrum.rds: fit.R 45-hard-spectrum.csv summary45.json 
	./$^ $@
