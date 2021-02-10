#!/bin/bash

mkdir -p ./logs
export LOG_DIR=./logs

if [ -d "/opt/confluent/etc/ksqldb" ]; then
    /opt/confluent/bin/ksql-server-start /opt/confluent/etc/ksqldb/ksql-production-server.properties >> ksql.log 2>&1
else
    /opt/confluent/bin/ksql-server-start /opt/confluent/etc/ksql/ksql-production-server.properties >> ksql.log 2>&1
fi