.PHONY: all

all: S00044_S00063.csv S00064_S00083.csv

S00044_S00063.csv: S00044_S00063.hdf5 hdf2csv.py
	python hdf2csv.py $< --crop 481 671

S00064_S00083.csv: S00064_S00083.hdf5 hdf2csv.py
	python hdf2csv.py $< --crop 100 1000
