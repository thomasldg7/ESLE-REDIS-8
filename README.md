# REDIS scalability study

## How to deploy Redis with Docker Swarm

### Create a Docker Swarm cluster
- `docker swarm init`

### Deploy a Redis service
- Create a network `docker network create --driver overlay esle-redis`
- Create a volume docker volume create esle-grp8`
- Create the service `docker service create --name esle-redis --network=esle-redis -p 6379:6379 redis:latest`
- Install *redis-cli* on the host https://redis.io/docs/getting-started/installation/install-redis-on-linux/

#### Test Redis
- Enter in Redis `redis-cli`
- `PING`--> should return 'PONG'

#### Create a replica node for Redis (slave)
- Create another service `docker service create --name esle-redis-slave --network=esle-redis -p 6380:6379 redis:latest redis-server --slaveof esle-redis 6379`
- Enter in the master Redis with `redis-cli`
- Enter `ìnfo replication` --> should show the IP of the Redis slave

## Benchmarking the Redis system
### Simple benchmark of the Redis system
- Using the benchmarking Redis tool with the command `redis-cli benchmark -q -n 10000 > simple_benchmark.txt` 
<br/>(-q: for just show query/sec values / -t: total number of requests)

Default: 50 clients (parallel connections) / Data size of 3 bytes for SET,GET requests

Our results can be seen in the file _simple_benchmark.txt_ and the plot _simple_benchmark.pdf_

### Benchmarking with YCSB workload
Using the benchmarking database YCSB tool, we analysed the CPU and memory usage and then the Throughput and Latency
#### CPU and memory usage
We launched a YCSB running test with the following command for 5/20/50/70/100 threads <br/>

`./bin/ycsb run redis -s -P workloads/workloada -p "redis.host=127.0.0.1" -p "redis.port=6379" -threads 5 > outputRun.txt` <br/>

The workload is 50% of READ, 15% of UPDATE, 20% of SCAN and 15% of INSERT. The datasize is 1KB and it make 1000 operations. <br/>

We monitor the CPU and memory usage with `docker stats` and `while true; do docker stats --no-stream | tee --append stats.txt; sleep 1; done` <br/>

And we plotted the results _cpu_memory_usage.pdf_

#### Throughput and Latency
We launched another YCSB running test for analysing the latency and throughput. We tried from 1 to 100 parallel clients (threads) <br>

`./bin/ycsb run redis -s -P workloads/workloada -p "redis.host=127.0.0.1" -p "redis.port=6379" -threads 5 > outputRun.txt` <br/>

With the same workload settings as previously. <br/>

We plotted the results _latency.pdf_ and _throughput.pdf_

## Universal Scalability Law
With the tool _esle-usl-1.0-SNAPSHOT.jar_ and the results of our previous experiment (_throughput.dat_), we find the parameters of the USL:</br>
**Lambda: 475,6146231101 </br> Delta: 0,4809557782 </br> Kappa: 0,0008078391**

And we can plot the theoretical throughput _throughput.pdf_

## Experimental design
#### Deploy a Redis Cluster

`mkdir 7000 7001 7002 7003 7005 7005`
inside each, create a `redis.conf` file

For each of the 6, create the container:
`docker run -v /root/7000/redis.conf:/usr/local/etc/redis/redis.conf -d --net=host --name myredis-0 redis redis-server /usr/local/etc/redis/redis.conf`

Enter in one of the container
`docker exec -it myredis-1 sh`

Create the cluster
`redis-cli --cluster create 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 --cluster-replicas 1`

## Automatisation files
- ycsb-benchmark-auto.sh : YCSB benchmark for 1 to 101 threads
- redis-benchmark-auto.sh : redi-benchmark for 1 to 101 threads, for GET and SET requests and 1000 requests, with pipelining to 15

