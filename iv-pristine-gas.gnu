# Gnuplot script to plot data with solid circles and connecting line

# Set output (optional: to PNG)
set terminal pngcairo size 800,600 enhanced font 'Arial,12'
set output 'iv.png'

# Set titles and labels
set title "Voltage vs Current"
set xlabel "Voltage (V)"
set ylabel "Current (A)"   # microamperes

# Set grid
set grid

# Plot data (two datasets in one plot)
plot "pure-iv.dat" using 1:2 with linespoints lt 1 lw 2 pt 7 ps 1.5 lc rgb "blue" title "Pure Sample", \
     "gas-iv.dat" using 1:2 with linespoints lt 1 lw 2 pt 7 ps 1.5 lc rgb "red" title "Gas Sample"

