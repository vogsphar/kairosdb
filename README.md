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

## enable basic AUTH

-e BASICUSER=bob -e BASICPASS=secret

## enable HTTPS

-e JETTYCERT=/cert/file1 -e JETTYPASS -v YOUR_STOREDIR:/cert

## enable certificate based authentication at cassandra

-e TRUSTSTORE=/cert/file1 -e KEYSTORE=/cert/file2 -e STOREPASS=storesecret -v YOUR_STOREDIR:/cert


## use own config files

use config files from the current directory:

``` bash
docker run --name some-kairos1 -d -p 8080:8080 -v $PWD:/opt/kairosdb/conf vogsphar/kairosdb
```


## build custom image
``` bash
git clone https://github.com/vogsphar/kairosdb
cd kairosdb
docker build -t my-kairosdb .
docker run --name my-kairos1 -d -p 8080:8080 -e "CASSANDRA_HOST_LIST=$IP" my-kairosdb
```
