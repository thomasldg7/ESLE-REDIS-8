set terminal pdf
set output './simple_benchmark.pdf'

set yrange [0:*]
set style fill solid
unset key

myBoxWidth = 0.8
set offsets 0,0,0.5-myBoxWidth/2.,0.5

set xlabel 'Throughput (req/sec)'
set ylabel 'Request type'
plot 'simple_benchmark.dat' using (0.5*$2):0:(0.5*$2):(myBoxWidth/2.):($0+1):ytic(1) with boxxy lc var