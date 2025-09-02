# SIESTA-Tutorial
Structure Relaxation in SIESTA

This example demonstrates how to perform atomic structure relaxation using the SIESTA software package. Structure relaxation is an essential step in Density Functional Theory (DFT) simulations, allowing the system to find its lowest-energy atomic configuration under given boundary conditions.

What is Structure Relaxation?

In DFT calculations, the initial atomic positions may not correspond to the equilibrium configuration. Structure relaxation (also called geometry optimization) iteratively updates atomic positions until the forces on atoms and the stress on the unit cell fall below predefined thresholds.

SIESTA achieves this by:
Computing Hellmann-Feynman forces on atoms.
Updating atomic positions using optimization algorithms (e.g., conjugate gradient or quasi-Newton).
Optionally relaxing the cell shape and volume (variable-cell relaxation).

Typical Workflow in SIESTA
Prepare input files:
system.fdf: Defines the system geometry, pseudopotentials, basis sets, and relaxation parameters.
*.psf: Pseudopotential files for each element.
Initial atomic structure (.fdf or .xyz format).

Key input parameters:
MD.TypeOfRun → CG (conjugate gradient) or Broyden for relaxation.
MD.NumCGSteps → maximum number of optimization steps.
MD.MaxForceTol → force tolerance for convergence (e.g., 0.01 eV/Å).
MD.VariableCell → true if cell relaxation is required.

Run SIESTA:

/path-to-siesta/siesta < system.fdf > Relax.out


Check convergence:
Monitor forces and stresses in the output file.
Ensure the system reaches the desired tolerance.

Final relaxed structure:
Saved in system.STRUCT_OUT or system.xyz files.

Can be used as input for further calculations (band structure, DOS, transport, etc.).
******************************************************************************************************************************************************************
Band Structure and DOS/PDOS Calculations in SIESTA

After obtaining a relaxed atomic structure, it is common to analyze the electronic properties of the system. Two important quantities are the band structure and the density of states (DOS/PDOS).

1. Band Structure
What is it?

The band structure shows the allowed electronic energy levels of a periodic system as a function of crystal momentum (k-points) along high-symmetry paths in the Brillouin Zone (BZ).

It reveals the band gap, band dispersion, and possible metallic, semiconducting, or insulating behavior.

How SIESTA computes it

Relax the structure first.

Define a k-point path through the BZ in an input file (BandPoints.fdf).

Run SIESTA with MD.TypeOfRun = BandStructure or by re-using the converged Hamiltonian from a self-consistent run.

The eigenvalues along the path are written to .EIG or .bands files.

Key inputs
%block BandPoints
   1     0.0  0.0  0.0   Γ
   100   0.5  0.0  0.0   X
   100   0.5  0.5  0.0   M
   100   0.0  0.0  0.0   Γ
%endblock BandPoints

BandLinesScale ReciprocalLatticeVectors


Here, each line gives the number of points, fractional k-coordinates, and optional labels (Γ, X, M, etc.).

2. Density of States (DOS)
What is it?

The DOS describes how many electronic states exist at each energy level.

It gives complementary information to the band structure and is useful for estimating electronic and optical properties.

How SIESTA computes it

Perform a self-consistent calculation with a dense k-point mesh (e.g., 10×10×10).

Request DOS output with:

SaveDOS    .true.
DOS.Energy.Min -10 eV
DOS.Energy.Max  10 eV
DOS.Energy.Step 0.02 eV


The result is written to system.DOS.

3. Projected DOS (PDOS)
What is it?

The PDOS projects the DOS onto atomic orbitals or specific atoms.

This helps identify which atoms or orbitals (s, p, d, f) contribute to states near the Fermi level.

How SIESTA computes it

In your input:

ProjectDensityOfStates    .true.
%block ProjectedDensityOfStates
   -10.0  10.0  0.02 eV 3500
%endblock ProjectedDensityOfStates


The output is written to files like system.PDOS.atomX, with contributions from individual atoms/orbitals.

Workflow Summary

Relax structure → system.fdf with MD.TypeOfRun = CG.

Self-consistent calculation → obtain charge density and Hamiltonian.

Band structure run → along high-symmetry path.

DOS/PDOS run → using dense k-point mesh.

Post-processing → plot band structure and DOS/PDOS using tools like gnuplot, matplotlib, or SIESTA utilities (bands.x, gnubands).
>gnuplot bands.gnu
>gnuplot fatbands.gnu
******************************************************************************************************************************************************************
This commit adds input files and scripts for calculating current–voltage (I–V) transport properties using TranSIESTA, the transport module of the SIESTA code.

The I–V transport calculation is based on the Non-Equilibrium Green’s Function (NEGF) formalism combined with Density Functional Theory (DFT). The system is divided into three regions:

Left electrode (semi-infinite lead)

Right electrode (semi-infinite lead)

Central scattering region (molecule, interface, or device channel)

The procedure involves:

Electrode calculations

Perform self-consistent calculations for the left and right electrodes to obtain surface Green’s functions and electrode Hamiltonians.

Central region calculation

Include part of each electrode plus the active scattering region.

Ensure consistent basis sets and pseudopotentials with electrode calculations.

Bias-dependent transport

Apply a finite bias voltage between left and right electrodes.

TranSIESTA computes the transmission spectrum T(E,V) for each bias.

The current I(V) is obtained by integrating T(E,V) over the bias window.

Post-processing

Transmission spectra are written to *.TBT.nc files.

Tools such as TBtrans or custom scripts extract:

Transmission vs. energy at different biases

I–V curve from integrated currents
>gnuplot iv.gnu
Projected transmissions (atom- or orbital-resolved contributions)
