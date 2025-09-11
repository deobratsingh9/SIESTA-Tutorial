# zero-transmission.gnu
# Plot zero-bias transmission from TranSIESTA AVTRANS files

# ---------------------------
# Input files
# ---------------------------
file1 = "Pure.AVTRANS_Left-Right"
label1 = "Pristine"
file2 = "gas.AVTRANS_Left-Right"
label2 = "Gas adsorbed (T/3)"

# Columns: col 1 = Energy [eV], col 2 = Transmission
colE = 1
colT = 2

# Energy window (around Ef=0)
ener_window = 2.0    # change as needed, e.g. 5.0

# ---------------------------
# Output
# ---------------------------
set terminal pngcairo size 1000,600 enhanced font "DejaVu Sans,12"
set output "Transmission_compare.png"

set title "Zero-bias Transmission T(E)"
set xlabel "Energy - E_{F} (eV)"
set ylabel "Transmission T(E)"
set key left top
set grid

# Energy range
set xrange [-ener_window:ener_window]

# Define custom line styles (colors + width)
set style line 1 lc rgb "blue" lw 2
set style line 2 lc rgb "red"  lw 2

# ---------------------------
# Plot
# ---------------------------
plot file1 using (column(colE)):(column(colT)) \
     title label1 with lines ls 1, \
     file2 using (column(colE)):(column(colT)/3.0) \
     title label2 with lines ls 2

unset output
print "Plot saved to Transmission_compare.png"

