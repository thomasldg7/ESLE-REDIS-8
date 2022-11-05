#!/bin/bash

echo '' > results/final/throughput-get.txt
echo '' > results/final/latency-get.txt
echo '' > results/final/throughput-set.txt
echo '' > results/final/latency-set.txt

for x in {1..101..5}
do
  redis-benchmark -p 6379 -t get -n 1000 -d 1 -P 15 -c $x > results/benchmark-$x.txt
  echo $x', ' | tr -d '\n' >>  results/final/throughput-get.txt
  grep 'throughput summary: ' results/benchmark-$x.txt | grep -Eo "[-+]?([0-9]*\.[0-9]+|[0-9]+)" >> results/final/throughput-get.txt
  echo $x', ' | tr -d '\n' >>  results/final/latency-get.txt
  grep -Pzo '.*Summary(.*\n)*' results/benchmark-$x.txt | sed -n '5p' | grep -Eo "[-+]?([0-9]*\.[0-9]+|[0-9]+)" | head -1 >> results/final/latency-get.txt
done

for x in {1..101..5}
do
  redis-benchmark -p 6379 -t set -n 1000 -d 1 -P 15 -c $x > results/benchmark-$x.txt
  echo $x', ' | tr -d '\n' >>  results/final/throughput-set.txt
  grep 'throughput summary: ' results/benchmark-$x.txt | grep -Eo "[-+]?([0-9]*\.[0-9]+|[0-9]+)" >> results/final/throughput-set.txt
  echo $x', ' | tr -d '\n' >>  results/final/latency-set.txt
  grep -Pzo '.*Summary(.*\n)*' results/benchmark-$x.txt | sed -n '5p' | grep -Eo "[-+]?([0-9]*\.[0-9]+|[0-9]+)" | head -1 >> results/final/latency-set.txt
done
