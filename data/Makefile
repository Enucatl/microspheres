summary.json: build_summary.R ../source/data/*.csv
	./build_summary.R > summary.json

%.csv: %.hdf5 ../source/data/Makefile
	make -C ../source/data `basename $@`
