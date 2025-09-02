#!/bin/bash
#SBATCH -J Band
#SBATCH -N 1
#SBATCH --ntasks-per-node=32
##SBATCH --reservation=devel
#SBATCH -t 002:00:00
#SBATCH -A XXXXXXXX 
#ln -s lead.fdf INPUT_DEBUG
module load Siesta/4.1-b4-nsc2-intel-2018a-eb 
mpprun siesta  < lead.fdf > Band.out