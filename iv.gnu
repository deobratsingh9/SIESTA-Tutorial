# Gnuplot script to plot data with solid circles and connecting line

# Set output (optional: to PNG)
set terminal pngcairo size 800,600 enhanced font 'Arial,12'
set output 'plot.png'

# Set titles and labels
set title "Voltage vs Current"
set xlabel "Voltage (V)"
set ylabel "Current (µA)"   # microamperes

# Set grid
set grid

# Plot data
# 'with linespoints' connects points with a line and shows points
# pt 7 = solid circle
# lw = line width
# ps = point size
plot "iv.dat" using 1:2 with linespoints lt 1 lw 2 pt 7 ps 1.5 lc rgb "blue" title "Current"
