# kairosdb

## minimal configuration

``` bash
IP=$(hostname -I) # 
docker run -it -e CASSANDRA_BROADCAST_ADDRESS=$IP -e CASSANDRA_START_RPC=true -p 9160:9160  --name some-cassandra1 cassandra
docker run --name some-kairos1 -d -p 8080:8080 -e "CASSANDRA_HOST_LIST=$IP" vogsphar/kairosdb
```

now you can point your browser to http://localhost:8080

## changing keyspace name

using `-e "CASSANDRA_KEYSPACE=bob"` can be used to change the default keyspace name "kairosdb" to a "bob".

## build custom image
``` bash
git clone https://github.com/vogsphar/kairosdb
cd kairosdb
docker build --build-arg SRC=https://github.com/kairosdb/kairosdb/releases/download/v1.1.1/kairosdb-x.x.x-x.tar.gz -t my-kairosdb -f Dockerfile.kairosdb .
docker run --name my-kairos1 -d -p 8080:8080 -e "CASSANDRA_HOST_LIST=$IP" my-kairosdb
```
