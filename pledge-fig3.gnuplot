set terminal png truecolor noenhanced font "Times,13"
set output "pledge-fig3.png"
set border linewidth 1.5
set style line 1 lc rgb '#800000' lt 1 lw 2
set style line 2 lc rgb '#ff0000' lt 1 lw 2
set style line 3 lc rgb '#ff4500' lt 1 lw 2
set style line 4 lc rgb '#ffa500' lt 1 lw 2
set style line 5 lc rgb '#006400' lt 1 lw 2
set style line 6 lc rgb '#0000ff' lt 1 lw 2
set style line 7 lc rgb '#9400d3' lt 1 lw 2
set style line 11 lc rgb '#808080' lt 1
set border 19 back ls 11
set tics nomirror out scale 0.75
set style line 12 lc rgb'#808080' lt 0 lw 1
set grid back ls 12
set xrange [0:1]
set yrange [0:1]
set xtics ("easy" 0, "hard" 1)
set ytics ("coarse" 0, "fine" 1)
set tics font "Helvetica,11"
set xlabel "ease of interfacing" font "Helvetica,11"
set ylabel "coverage of capabilities" font "Helvetica,11"
plot "pledge-fig3.dat" u 1:2:3 w labels notitle
