set terminal pdf
set output './latency.pdf'

set xlabel 'Threads'
set ylabel 'Latency (ms)'
set title 'latency (Read)'
plot [0:100][0:300]'latency-read.dat' using ($1):($2 / 1000) title 'read' with linespoints, \
                  'latency-scan.dat' using ($1):($2 / 1000) title 'scan' with linespoints,\

set xlabel 'Threads'
set ylabel 'Latency (ms)'
set title 'latency (Write)'
plot [0:100][0:30]'latency-update.dat' using ($1):($2 / 1000) title 'update' with linespoints, \
                  'latency-insert.dat' using ($1):($2 / 1000) title 'insert' with linespoints,\
