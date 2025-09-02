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
