set terminal pdf
set output './workload.pdf'

set xlabel 'Threads'
set ylabel 'Latency (ms)'
set title 'Workload (Read Operations - Latency)'
plot [0:100][0:250]'latency-read.dat' using ($1):($2 / 1000) title 'read' with linespoints, \
                  'latency-scan.dat' using ($1):($2 / 1000) title 'scan' with linespoints,\

set xlabel 'Threads'
set ylabel 'Latency (ms)'
set title 'Workload (Write Operations - Latency)'
plot [0:100][0:30]'latency-update.dat' using ($1):($2 / 1000) title 'update' with linespoints, \
                  'latency-insert.dat' using ($1):($2 / 1000) title 'insert' with linespoints,\
