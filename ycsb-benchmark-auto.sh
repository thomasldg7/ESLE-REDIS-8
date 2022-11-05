#!/bin/bash

echo '' > results/final/throughput.txt
echo '' > results/final/latency-read.txt
echo '' > results/final/latency-update.txt
echo '' > results/final/latency-insert.txt
echo '' > results/final/latency-scan.txt

for x in {1..6..5}
do
  ./bin/ycsb run redis -s -P workloads/workloada -p "redis.host=127.0.0.1" -p "redis.port=6379" -threads $x > results/outputRun-$x.txt
  echo $x', ' | tr -d '\n' >>  results/final/throughput.txt
  grep '\[OVERALL\], Throughput(ops/sec),' results/outputRun-$x.txt | cut -d\   -f3 >> results/final/throughput.txt
  echo $x', ' | tr -d '\n' >>  results/final/latency-read.txt
  grep '\[READ\], AverageLatency(us),' results/outputRun-$x.txt | cut -d\   -f3 >> results/final/latency-read.txt
  echo $x', ' | tr -d '\n' >>  results/final/latency-update.txt
  grep '\[UPDATE\], AverageLatency(us),' results/outputRun-$x.txt | cut -d\   -f3 >> results/final/latency-update.txt
  echo $x', ' | tr -d '\n' >>  results/final/latency-insert.txt 
  grep '\[INSERT\], AverageLatency(us),' results/outputRun-$x.txt | cut -d\   -f3 >> results/final/latency-insert.txt
  echo $x', ' | tr -d '\n' >>  results/final/latency-scan.txt
  grep '\[SCAN\], AverageLatency(us),' results/outputRun-$x.txt | cut -d\   -f3 >> results/final/latency-scan.txt
done
