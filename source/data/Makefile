.PHONY: all

all: S00044_S00063.csv S00064_S00083.csv S00002_S00021.csv S00022_S00041.csv S00043_S00062.csv S00063_S00082.csv S00084_S00103.csv S00104_S00123.csv S00127_S00146.csv S00147_S00166.csv 

S00044_S00063.csv: S00044_S00063.hdf5 hdf2csv.py
	python hdf2csv.py $< --crop 481 671

S00064_S00083.csv: S00064_S00083.hdf5 hdf2csv.py
	python hdf2csv.py $< --crop 100 1000

S00002_S00021.csv: S00002_S00021.hdf5 hdf2csv.py
	python hdf2csv.py $< --crop 100 1000

S00022_S00041.csv: S00022_S00041.hdf5 hdf2csv.py
	python hdf2csv.py $< --crop 480 670

S00043_S00062.csv: S00043_S00062.hdf5 hdf2csv.py
	python hdf2csv.py $< --crop 100 1000

S00063_S00082.csv: S00063_S00082.hdf5 hdf2csv.py
	python hdf2csv.py $< --crop 480 600

S00084_S00103.csv: S00084_S00103.hdf5 hdf2csv.py
	python hdf2csv.py $< --crop 100 1000

S00104_S00123.csv: S00104_S00123.hdf5 hdf2csv.py
	python hdf2csv.py $< --crop 480 680

S00127_S00146.csv: S00127_S00146.hdf5 hdf2csv.py
	python hdf2csv.py $< --crop 100 1000

S00147_S00166.csv: S00147_S00166.hdf5 hdf2csv.py
	python hdf2csv.py $< --crop 450 650
