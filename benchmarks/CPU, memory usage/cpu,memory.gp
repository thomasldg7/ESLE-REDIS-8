set terminal pdf
set output './cpu_memory_usage.pdf'

set xlabel 'Threads'
set ylabel 'CPU usage (%)'
set title 'CPU usage relative to the number of threads'
plot [0:105][0:100]'cpu_usage.dat' using ($1):($2) title 'cpu usage' with linespoints

set xlabel 'Threads'
set ylabel 'Memory usage (%)'
set title 'Memory usage relative to the number of threads'
plot [0:105][0:1]'memory_usage.dat' using ($1):(($2/4150)*100) title 'memory usage' with linespoints