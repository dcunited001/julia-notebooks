set terminal X11 noenhanced
set title "*spice netlister for gnetlist"
set xlabel "s"
set ylabel "V"
set grid
unset logscale x 
set xrange [0.000000e+00:5.000000e-02]
unset logscale y 
set yrange [-9.973869e-02:1.052369e+00]
#set xtics 1
#set x2tics 1
#set ytics 1
#set y2tics 1
set format y "%g"
set format x "%g"
plot 'circuits/rc2.net.data' using 1:2 with lines lw 1 title "v(n0)",\
'circuits/rc2.net.data' using 3:4 with lines lw 1 title "v(n5)"
set terminal push
set terminal png noenhanced
set out 'circuits/rc2.net.png'
replot
set term pop
replot
