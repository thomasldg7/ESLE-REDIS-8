Docker service REDIS, one replica

Benchamrk with ycsb
          with threads 1-5-10...100
./bin/ycsb run redis -s -P workloads/workloada -p "redis.host=127.0.0.1" -p "redis.port=6379" -threads 5 > outputRun.txt

calculating USL values with workload1.dat
Lambda: 475,6146231101 Delta: 0,4809557782 Kappa: 0,0008078391