#!/bin/bash
#SBATCH -J b2n2-zb
#SBATCH -N 2 
#SBATCH --ntasks-per-node=4
##SBATCH --reservation=devel
#SBATCH -t 000:10:00
#SBATCH -A naiss2025-5-112
#ln -s lead.fdf INPUT_DEBUG
module load Siesta/4.1-b4-nsc2-intel-2018a-eb
mpprun siesta < scat1.fdf > Trans.out
mpprun tbtrans < scat1.fdf > TBT.out
