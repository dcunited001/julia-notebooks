set terminal X11 noenhanced
set title "* qucs 0.0.22 /usr/share/qucs-s/examples/ngspice/bjt.sch"
set xlabel "Hz"
set grid
set logscale x
set xrange [1e+02:1e+07]
set mxtics 10
set grid mxtics
unset logscale y 
set yrange [-8.770627e+00:6.271727e-01]
#set xtics 1
#set x2tics 1
#set ytics 1
#set y2tics 1
set format y "%g"
set format x "%g"
plot 'circuits/qucs-npn-gain.data' using 1:2 with lines lw 1 title "v(in)",\
'circuits/qucs-npn-gain.data' using 3:4 with lines lw 1 title "v(out)",\
'circuits/qucs-npn-gain.data' using 5:6 with lines lw 1 title "k"
set terminal push
set terminal png noenhanced
set out 'circuits/qucs-npn-gain.png'
replot
set term pop
replot
