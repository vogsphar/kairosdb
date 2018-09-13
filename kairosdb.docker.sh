#!/bin/bash
CONF=/opt/kairosdb/conf/kairosdb.properties
function conf
{
  sed -i -e "s/^$1=.*/$1=$2/" $CONF
}
if [ -n "$CASSANDRA_KEYSPACE" ]; then
# kairosdb.datastore.cassandra.hector.loadBalancingPolicy 
	conf kairosdb.datastore.cassandra.keyspace "$CASSANDRA_KEYSPACE"
fi
if [ -n "$CASSANDRA_HOST_LIST" ]; then
# kairosdb.datastore.cassandra.hector.loadBalancingPolicy 
	conf kairosdb.datastore.cassandra.read_consistency_level ONE
	conf kairosdb.datastore.cassandra.write_consistency_level ONE
	conf kairosdb.datastore.cassandra.replication_factor 1
	conf kairosdb.service.datastore org.kairosdb.datastore.cassandra.CassandraModule
	conf kairosdb.query_cache.cache_file_cleaner_schedule "0 *\\/30 * * * ?"
	conf kairosdb.datastore.cassandra.write_buffer_max_size 3000
	conf kairosdb.datastore.cassandra.cql_host_list "$CASSANDRA_HOST_LIST"
fi
cat $CONF
exec /opt/kairosdb/bin/kairosdb.sh run