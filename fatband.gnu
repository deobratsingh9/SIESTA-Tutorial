set terminal pngcairo size 800,600 enhanced font 'Helvetica,14'
set output 'fatbands.png'

# Fermi energy (eV)
Efermi = -3.84757817651824

# Axes labels
set xlabel "k-path"
set ylabel "Energy (eV)"

# Y-axis range around Ef
set yrange [-4:4]
set grid ytics

# High-symmetry points
set xtics ("Γ" 0.000000, \
           "X" 0.363742, \
           "S" 1.029847, \
           "Y" 1.393588, \
           "Γ" 2.059693, \
           "S" 2.818643)

# Vertical dashed lines
set style line 1 lc rgb "#000000" lt 2 lw 1
set arrow from 0.363742, graph 0 to 0.363742, graph 1 nohead ls 1
set arrow from 1.029847, graph 0 to 1.029847, graph 1 nohead ls 1
set arrow from 1.393588, graph 0 to 1.393588, graph 1 nohead ls 1
set arrow from 2.059693, graph 0 to 2.059693, graph 1 nohead ls 1
set arrow from 2.818643, graph 0 to 2.818643, graph 1 nohead ls 1

# Plot fat bands: column1=k, column2=energy, column3=weight
plot "bands.dat" u 1:($2-Efermi):2 w points pt 4 ps variable lc rgb "blue" notitle

