#!/bin/bash
#SBATCH -J 2D-BN-loop
#SBATCH -N 2
#SBATCH --ntasks-per-node=16
##SBATCH --reservation=devel
#SBATCH -t 001:00:00
#SBATCH -A naiss2025-5-112 

module load Siesta/4.1-b4-nsc2-intel-2018a-eb

# Create clean continuation directory
mkdir -p cont

# Voltage steps (adjust as needed)
VOLTS="0.20 0.40 0.60 0.80 1.00 1.20 1.40 1.60 1.80 2.00"

for i in $VOLTS; do
    echo "========================================"
    echo "Running voltage: $i eV"
    echo "========================================"

    # Set up working directory for this bias step
    cp -r cont "$i"
    cd "$i" || { echo "Failed to enter directory $i"; exit 1; }

    # Copy necessary files from previous step or initial setup
    cp ../*.ion . 2>/dev/null
    cp ../*.TSHS . 2>/dev/null
    cp ../*.TSDE . 2>/dev/null
    cp ../*.DM .   2>/dev/null

    # Generate scat.fdf input
    cat > scat.fdf <<EOF


SolutionMethod        Transiesta

SystemName  b2n2
SystemLabel scat
==================================================
==================================================
# SPECIES AND BASIS

# Number of species 
NumberOfSpecies 4
%block ChemicalSpeciesLabel
 1    5    B
 2    7    N
 3    6    C
 4    8    O
%endblock ChemicalSpeciesLabel

==================================================
==================================================
# K-points

%block kgrid_Monkhorst_Pack
 1    0    0    0.0
 0    10   0    0.0
 0    0    1    0.0
%endblock kgrid_Monkhorst_Pack


==================================================
==================================================
# Structure
NumberOfAtoms 75
LatticeConstant 1.0 Ang
%block LatticeVectors
    27.4226284199999988    0.0000510240000000    0.0000000000000000
    -0.0000155790000000    7.4873715630000000    0.0000000000000000
     0.0000000000000000    0.0000000000000000   24.0381749109999987
%endblock LatticeVectors
AtomicCoordinatesFormat  Ang

%block AtomicCoordinatesAndAtomicSpecies
      3.00503088       1.87056124      11.90590979    2    7 
      1.57198926       1.87056521      11.90593770    2    7 
      3.72131031       0.62267451      11.90665219    1    5 
      0.85568102       0.62267824      11.90667613    1    5 
      3.00502569       4.36635176      11.90590979    2    7 
      1.57198407       4.36635573      11.90593770    2    7 
      3.72130512       3.11846503      11.90665219    1    5 
      0.85567583       3.11846876      11.90667613    1    5 
      3.00502050       6.86214228      11.90590979    2    7 
      1.57197885       6.86214625      11.90593770    2    7 
      3.72129993       5.61425555      11.90665219    1    5 
      0.85567063       5.61425928      11.90667613    1    5 
      7.57546896       1.87056974      11.90590979    2    7 
      6.14242731       1.87057372      11.90593770    2    7 
      8.29174839       0.62268301      11.90665219    1    5 
      5.42611907       0.62268674      11.90667613    1    5 
      7.57546377       4.36636026      11.90590979    2    7 
      6.14242212       4.36636424      11.90593770    2    7 
      8.29420364       3.11936696      11.89503670    1    5 
      5.42681620       3.11820705      11.90675531    1    5 
      7.57847364       6.86091001      11.90565852    2    7 
      6.14378480       6.86142942      11.91009849    2    7 
      8.29506547       5.61337571      11.89926845    1    5 
      5.42607317       5.61441104      11.90888836    1    5 
     12.15038183       1.87364767      11.78112493    2    7 
     10.71683931       1.87468779      11.84992226    2    7 
     12.86378746       0.62336550      11.79302056    1    5 
     10.00350640       0.62271919      11.89642957    1    5 
     12.14858555       4.37209801      11.67999669    2    7 
     10.71462059       4.36809453      11.76817242    2    7 
     12.86454261       3.12134237      11.69133800    1    5 
     10.00161384       3.12264183      11.85028630    1    5 
     12.14936586       6.86508521      11.83223341    2    7 
     10.71751355       6.86534094      11.87578392    2    7 
     13.71182222       3.66053331      14.56774808    3    6 
     12.53221120       3.66411717      14.56231386    4    8 
     14.89451394       3.66464987      14.56299118    4    8 
     12.86552943       5.61760712      11.73070748    1    5 
     10.00148157       5.61657030      11.85716770    1    5 
     16.71646578       1.87363311      11.84582815    2    7 
     15.28408929       1.87359247      11.77870840    2    7 
     17.42738732       0.62260223      11.89895225    1    5 
     14.56965333       0.62403255      11.79217853    1    5 
     16.71947282       4.36789946      11.75881118    2    7 
     15.28584509       4.37170822      11.67590441    2    7 
     17.43260191       3.12161698      11.84843795    1    5 
     14.57102116       3.12128488      11.69085805    1    5 
     16.71527704       6.86586723      11.87441906    2    7 
     15.28366262       6.86524847      11.83000925    2    7 
     17.43191677       5.61746399      11.85689040    1    5 
     14.56996028       5.61681592      11.72990131    1    5 
     21.28669734       1.87138221      11.90665235    2    7 
     19.85344171       1.87189124      11.91184734    2    7 
     22.00240742       0.62319711      11.90641053    1    5 
     19.13382550       0.62534634      11.91976011    1    5 
     21.28773646       4.36666990      11.90817125    2    7 
     19.85460782       4.36619636      11.90788174    2    7 
     22.00305741       3.11849905      11.90665219    1    5 
     19.13742809       3.11850277      11.90667613    1    5 
     21.28677276       6.86217630      11.90590979    2    7 
     19.85373114       6.86218027      11.90593770    2    7 
     22.00305222       5.61428956      11.90665219    1    5 
     19.13742290       5.61429330      11.90667613    1    5 
     25.85722123       1.87060376      11.90590979    2    7 
     24.42417960       1.87060773      11.90593770    2    7 
     26.57350068       0.62271703      11.90665219    1    5 
     23.70787136       0.62272076      11.90667613    1    5 
     25.85721603       4.36639428      11.90590979    2    7 
     24.42417441       4.36639825      11.90593770    2    7 
     26.57349549       3.11850755      11.90665219    1    5 
     23.70786617       3.11851128      11.90667613    1    5 
     25.85721084       6.86218480      11.90590979    2    7 
     24.42416921       6.86218877      11.90593770    2    7 
     26.57349027       5.61429807      11.90665219    1    5 
     23.70786097       5.61430180      11.90667613    1    5 
%endblock AtomicCoordinatesAndAtomicSpecies


==================================================
==================================================
#======= General variables ======
PAO.BasisSize     DZP
PAO.SplitTailNorm true
PAO.SplitNormH          0.30

MeshCutoff            250.0 Ry
XC.functional         GGA
XC.authors            PBE
ElectronicTemperature     25 meV
UseSaveData           .true.
SpinPolarized         .true.
PAO.EnergyShift      0.15 eV

#============== MD variables =======
MD.TypeOfRun          CG
MD.NumCGsteps         0
MD.MaxForceTol        0.01 eV/Ang
MD.MaxStressTol       0.05 GPa
MD.UseSaveXV          .true.
MD.FinalTimeStep      1
#MD.UseStructFile      .true.
#=================================
#======== SCF variables ==========
# SCF variables

DM.MixSCF1   T
MaxSCFIterations      1000           # Maximum number of SCF iter
DM.MixingWeight       0.1          # New DM amount for next SCF cycle
DM.Tolerance          1.d-4         # Tolerance in maximum difference
DM.UseSaveDM          true          # to use continuation files
DM.NumberPulay        3
TS.MixH               yes

==================================================
#Other options
TS.HS.Save          .true.
TS.DE.Save          .true.
ParallelOverK       .true.
#User.Basis          .true.    #when species.ion present in the current directory
Diag.ParallelOverK  .true. 
==================================================
==================================================
# Output variables

WriteMullikenPop                1
WriteBands                      .false.
SaveRho                         .true.
SaveDeltaRho                    .true.
SaveHS                          .false.
SaveElectrostaticPotential      .true. 
SaveTotalPotential              no
WriteCoorXmol                   .true.
WriteMDXmol                     .true.
WriteMDhistory                  .false.
WriteEigenvalues                yes
WriteForces                     .true.


==================================================
==================================================
TBT.Elecs.Eta    0.0001 eV

TS.Elecs.Bulk true
TS.Elecs.DM.Update none
TS.Elecs.GF.ReUse false
TS.Elecs.Neglect.Principal true
%block TS.Elecs
  Left
  Right
%endblock TS.Elecs

%block TS.Elec.Left
  TSHS ./leads.TSHS
#  chem-pot Left
  semi-inf-dir -a1
  elec-pos begin 1
  used-atoms 12
%endblock TS.Elec.Left

%block TS.Elec.Right
  TSHS ./leads.TSHS
#  chem-pot Right
  semi-inf-dir +a1
  elec-pos end -1
  used-atoms 12
%endblock TS.Elec.Right

%block TBT.k
  diag 10 10 1
%endblock


TBT.DOS.A.All T
TS.SolutionMethod btd
TS.BTD.Pivot atom+Left

%block TBT.Contours
    line
%endblock TBT.Contours
%block TBT.Contour.line
  part line
     from -2. eV to 2. eV
      delta 0.01 eV
        method mid-rule
%endblock TBT.Contour.line

%block TBT.Atoms.Device
atom [13 -- 63]
%endblock

# TS OPTIONS
TS.Voltage $i eV

EOF

    # Remove stale output to prevent crash
    [ -f scat.TBT.nc ] && rm scat.TBT.nc

    # Run tbtrans
    echo "Running tbtrans for $i eV..."
    mpprun tbtrans < scat.fdf > TBT.out
    if [ $? -ne 0 ]; then
        echo "tbtrans failed at voltage $i"
        exit 1
    fi

    # Extract IV data
    grep "Left -> Right" TBT.out | awk '{print $9, $11, $12}' >> ../IV.dat
    # Copy output to continuation directory for next run
    cp scat.TBT.nc ../cont/
    cp scat.TSHS ../cont/
    cp scat.TSDE ../cont/
    cp scat.DM ../cont/

    cd ..
done
