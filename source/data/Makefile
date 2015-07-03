.PHONY: all

all: S00044_S00063.csv

S00044_S00063.csv: S00044_S00063.hdf5 hdf2csv.py
	python hdf2csv.py S00044_S00063.hdf5 --crop 481 671
