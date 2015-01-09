#!/bin/bash
#BSUB -J SOAD-NOBLOCK
#BSUB -W 00:15
#BSUB -n 2
#BSUB -oo output_%J.out
#BSUB -eo output_%J.err
#BSUB -R "span[ptile=1]"
#BSUB -q bsc_debug 
#BSUB -x

# set application and parameters
APP="noblock"
echo $PWD

module purge
module load gcc openmpi extrae paraver
echo "PATH is $PATH"
echo "LD_LIBRARY_PATH is $LD_LIBRARY_PATH"
echo "##################################################"

export EXTRAE_CONFIG_FILE=extrae.xml
source ${EXTRAE_HOME}/etc/extrae.sh
export LD_PRELOAD=${EXTRAE_HOME}/lib/libmpitrace.so

mpirun extrae ./$APP > out-noBlock

mpi2prv -o noBlock.prv -f TRACE.mpits set-o/
