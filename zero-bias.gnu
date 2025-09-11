# plot_scat.gp
set terminal pngcairo size 1000,600 enhanced font "Arial,12"
set output "scat_plot.png"

set title "Transmission vs Energy"
set xlabel "Energy [eV]"
set ylabel "Transmission [G_0]"
set grid

# Plot with line thickness 2
plot \
    "scat.TBT_UP.AVTRANS_Left-Right" using 1:2 with lines lw 2 title "TBT_{UP}", \
    "scat.TBT_DN.AVTRANS_Left-Right" using 1:2 with lines lw 2 title "TBT_{DN}"
