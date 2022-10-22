set terminal pdf
set output './throughput.pdf'
set xlabel 'Client Threads (concurrency)'
set ylabel 'Throughput (trans/sec)'
set title 'Workload (Throughput)'
set key samplen 0.1 spacing 1.1 font ",6"

lambda1 = 475.6146231101
delta1 = 0.4809557782
kappa1 = 0.0008078391

usl(x) = (lambda1*x)/(1 + delta1*(x-1) + kappa1*x*(x-1))

set xlabel 'Threads'
set ylabel 'Throughput (trans/sec)'
set title 'Workload'
plot [0:100] [0:1300] usl(x) title 'theoretical', './seeds.dat' using ($1):($2) title 'experiment' with linespoints 
