set terminal pdf
set output './cpu_memory_usage.pdf'

set xlabel 'Threads'
set ylabel 'CPU usage (%)'
set title 'Workload (Read Operations - Latency)'
plot [0:105][0:250]'cpu_usage.dat' using ($1):($2) title 'cpu usage' with linespoints

set xlabel 'Threads'
set ylabel 'Memory usage (MB)'
set title 'Workload (Write Operations - Latency)'
plot [0:105][0:30]'memory_usage.dat' using ($1):($2) title 'memory usage' with linespoints