#!/bin/bash
#SBATCH -J BN-mol
#SBATCH -N 2 --exclusive
#SBATCH --ntasks-per-node=16
##SBATCH --reservation=devel
#SBATCH -t 02:00:00
#SBATCH -A naiss2025-5-112 
#ln -s lead.fdf INPUT_DEBUG
module load Siesta/4.1-b4-nsc2-intel-2018a-eb 
mpprun siesta  < lead.fdf > Relax.out
