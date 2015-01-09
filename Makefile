all: build

build: noblock block

noblock: mpisend-noblock.c
	mpicc -o noblock mpisend-noblock.c

block: mpisend-block.c
	mpicc -o block  mpisend-block.c

submit-block:
	bsub < jobBlock.sh

submit-noblock:
	bsub < jobNoBlock.sh

clean:
	rm -fr set-0 *.pcf *.row *.prv TRACE* trace* output* out-* block noblock
