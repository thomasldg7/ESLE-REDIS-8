set terminal pdf
set output './throughput-8.pdf'
set xlabel 'Client Threads (concurrency)'
set ylabel 'Throughput (req/sec)'
set title 'Workload (Throughput)'
set key samplen 0.1 spacing 1.1 font ",6"

lambda_get = 200999.9999993841
delta_get = 0.5073850694
kappa_get = 0.0003325613

lambda_set = 196529.7933042712
delta_set = 0.7694473653
kappa_set = -0.0007003522

usl_get(x) = (lambda_get*x)/(1 + delta_get*(x-1) + kappa_get*x*(x-1))
usl_set(x) = (lambda_set*x)/(1 + delta_set*(x-1) + kappa_set*x*(x-1))

set xlabel 'Threads'
set ylabel 'Throughput (trans/sec)'
set title 'Workload'
plot [0:101] [0:600000] usl_get(x) title 'theoretical-get', usl_set(x) title 'theoretical-set', './experience 8/throughput-get.dat' using ($1):($2) title 'get' with linespoints, \
                                                    './experience 8/throughput-set.dat' using ($1):($2) title 'set' with linespoints 
