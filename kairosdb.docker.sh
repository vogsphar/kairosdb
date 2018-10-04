#!/bin/bash
CONF=/opt/kairosdb/conf/kairosdb.properties
function conf
{
  sed -i -e "s/^$1=.*/$1=$2/" $CONF
}
if [ -n "$CASSANDRA_KEYSPACE" ] || [ -n "$CASSANDRA_KEYSPACE_RANDOM" ] ; then
# kairosdb.datastore.cassandra.hector.loadBalancingPolicy 
	[ -n "$CASSANDRA_KEYSPACE" ] &&	conf kairosdb.datastore.cassandra.keyspace "$CASSANDRA_KEYSPACE"
	[ -n "$CASSANDRA_KEYSPACE_RANDOM" ] && conf kairosdb.datastore.cassandra.keyspace $(cat /dev/urandom | tr -dc 'a-z' | fold -w 32 | head -n 1)
fi
if [ -n "$CASSANDRA_HOST_LIST" ]; then
# kairosdb.datastore.cassandra.hector.loadBalancingPolicy 
	conf kairosdb.service.datastore org.kairosdb.datastore.cassandra.CassandraModule
	conf kairosdb.datastore.cassandra.cql_host_list "$CASSANDRA_HOST_LIST"
	conf kairosdb.datastore.cassandra.read_consistency_level ONE
	conf kairosdb.datastore.cassandra.write_consistency_level ONE
	conf kairosdb.datastore.cassandra.replication_factor 1
	conf kairosdb.datastore.cassandra.write_buffer_max_size 3000
	conf kairosdb.datastore.cassandra.write_delay 1000
	conf kairosdb.datastore.cassandra.write_buffer_max_size 10000
	conf kairosdb.datastore.cassandra.single_row_read_size 10240
	conf kairosdb.datastore.cassandra.multi_row_size 2000
	conf kairosdb.datastore.cassandra.multi_row_read_size 2048
	conf kairosdb.datastore.cassandra.row_key_cache_size 10240
	conf kairosdb.datastore.cassandra.max_queue_size 500	
	conf kairosdb.queue_processor.batch_size=4000
	conf kairosdb.query_cache.cache_file_cleaner_schedule "0 *\\/30 * * * ?"		
else
# shrink kairosdb.properties
	sed -i '/\.cassandra\./d' $CONF
fi
# Overwrite logback.xml file with custom configuration 
if [ -n "$LOGBACK_CUSTOM" ]; then
  echo $LOGBACK_CUSTOM > /opt/kairosdb/conf/logging/logback-test.xml && cat /opt/kairosdb/conf/logging/logback-test.xml 
fi

cat $CONF

# remove default demo points and blast
sed -i '/\.blast\.|\.demo\./d' $CONF

exec /opt/kairosdb/bin/kairosdb.sh run
