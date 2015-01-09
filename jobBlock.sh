#!/bin/bash
#BSUB -J SOAD-BLOCK
#BSUB -W 00:15
#BSUB -n 2
#BSUB -oo output_%J.out
#BSUB -eo output_%J.err
#BSUB -R "span[ptile=1]"
#BSUB -q bsc_debug 
#BSUB -x

# set application and parameters
APP="block"
echo $PWD

module purge
module load gcc openmpi extrae paraver

export EXTRAE_CONFIG_FILE=extrae.xml
source ${EXTRAE_HOME}/etc/extrae.sh
export LD_PRELOAD=${EXTRAE_HOME}/lib/libmpitrace.so

mpirun extrae ./$APP > out-block
mpi2prv -o block.prv -f TRACE.mpits set-o/
