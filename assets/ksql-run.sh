#!/bin/bash

/opt/confluent/bin/ksql-server-start /opt/confluent/etc/ksqldb/ksql-production-server.properties >> ksql.log 2>&1
