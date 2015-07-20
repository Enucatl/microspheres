.PHONY: all

all: summary.json fit_prediction.json

fit_prediction.json: fit.R ../source/data/1.2.csv ../source/data/4.5.csv
	./$<

summary.json: build_summary.R ../source/data/*.csv
	./$< > $@

%.csv: %.hdf5 ../source/data/Makefile
	make -C ../source/data `basename $@`
