#!/bin/bash
#SBATCH -J b2n2-zero
#SBATCH -N 2 
#SBATCH --ntasks-per-node=16
##SBATCH --reservation=devel
#SBATCH -t 001:10:00
#SBATCH -A xxx
#ln -s lead.fdf INPUT_DEBUG
module load Siesta/4.1-b4-nsc2-intel-2018a-eb
mpprun siesta < scat1.fdf > Trans.out
mpprun tbtrans < scat1.fdf > TBT.out
