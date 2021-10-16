set terminal X11 noenhanced
set title "* qucs 0.0.22 /usr/share/qucs-s/examples/ngspice/bjt.sch"
set xlabel "s"
set ylabel "V"
set grid
unset logscale x 
set xrange [0.000000e+00:1.000000e-03]
unset logscale y 
set yrange [-1.815754e+00:1.871747e+00]
#set xtics 1
#set x2tics 1
#set ytics 1
#set y2tics 1
set format y "%g"
set format x "%g"
plot 'circuits/qucs-npn-voltage.data' using 1:2 with lines lw 1 title "v(in)",\
'circuits/qucs-npn-voltage.data' using 3:4 with lines lw 1 title "v(out)"
set terminal push
set terminal png noenhanced
set out 'circuits/qucs-npn-voltage.png'
replot
set term pop
replot
