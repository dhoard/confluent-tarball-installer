#!/bin/bash

export LOG_DIR=./logs

/opt/confluent/bin/ksql-server-start /opt/confluent/etc/ksql/ksql-production-server.properties 2>&1 | tee -a ksql.log
