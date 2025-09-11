#!/bin/bash
#SBATCH -J b2n2-lead
#SBATCH -N 1
#SBATCH --ntasks-per-node=32
##SBATCH --reservation=devel
#SBATCH -t 048:00:00
#SBATCH -A naiss2025-5-112 
#ln -s lead.fdf INPUT_DEBUG
module load Siesta/4.1-b4-nsc2-intel-2018a-eb 
mpprun siesta --electrode < lead.fdf > Relax.out
