set terminal pngcairo enhanced color dashed font "Times, 10" rounded
set output 'sqlbox-fig10.png'

set encoding utf8

# See https://github.com/Gnuplotting/gnuplot-palettes
# Line styles (colorbrewer Set1)
set style line 1 lc rgb '#E41A1C' pt 1 ps 1 lt 1 lw 2 # red
set style line 2 lc rgb '#377EB8' pt 6 ps 1 lt 1 lw 2 # blue
set style line 3 lc rgb '#4DAF4A' pt 2 ps 1 lt 1 lw 2 # green
set style line 4 lc rgb '#984EA3' pt 3 ps 1 lt 1 lw 2 # purple
set style line 5 lc rgb '#FF7F00' pt 4 ps 1 lt 1 lw 2 # orange
set style line 6 lc rgb '#FFFF33' pt 5 ps 1 lt 1 lw 2 # yellow
set style line 7 lc rgb '#A65628' pt 7 ps 1 lt 1 lw 2 # brown
set style line 8 lc rgb '#F781BF' pt 8 ps 1 lt 1 lw 2 # pink

# Palette
set palette maxcolors 8
set palette defined ( 0 '#E41A1C', 1 '#377EB8', 2 '#4DAF4A', 3 '#984EA3', 4 '#FF7F00', 5 '#FFFF33', 6 '#A65628', 7 '#F781BF' )

# Standard border
set style line 11 lc rgb '#808080' lt 1 lw 3
set border 0 back ls 11
set tics out nomirror

# Standard grid
set style line 12 lc rgb '#808080' lt 0 lw 1
set grid back ls 12
set key left bottom
set xlabel 'iterations'
set ylabel 'slowdown'

set yrange [0:*]

plot 'sqlbox-fig4.dat' u 1:($2 / $6) w lp ls 2 title 'ksql', \
                    '' u 1:($4 / $6) w lp ls 3 title 'sqlbox'
