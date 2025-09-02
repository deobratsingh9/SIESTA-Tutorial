# Band structure plotting script for SIESTA
set terminal pngcairo size 800,600 enhanced font 'Helvetica,14'
set output 'bands.png'

# Fermi energy
Efermi = -3.84757817651824

# Labels for high-symmetry points
set xtics ("Γ" 0.000000, \
           "X" 0.363742, \
           "S" 1.029847, \
           "Y" 1.393588, \
           "Γ" 2.059693, \
           "S" 2.818643)

# Vertical dashed lines at symmetry points
set style line 1 lc rgb "#000000" lt 2 lw 1
set arrow from 0.363742, graph 0 to 0.363742, graph 1 nohead ls 1
set arrow from 1.029847, graph 0 to 1.029847, graph 1 nohead ls 1
set arrow from 1.393588, graph 0 to 1.393588, graph 1 nohead ls 1
set arrow from 2.059693, graph 0 to 2.059693, graph 1 nohead ls 1
set arrow from 2.818643, graph 0 to 2.818643, graph 1 nohead ls 1

# Axes labels
set xlabel "k-path"
set ylabel "Energy (eV)"

# Shift Fermi energy to 0
set yrange [-6:6]   # adjust depending on your bands
set grid ytics

# Plot: assumes Si_bands.dat has k-point in column 1, energy in column 2
plot "bands.dat" u 1:($2-Efermi) w l lc rgb "blue" notitle

