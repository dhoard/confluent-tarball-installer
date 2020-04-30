#!/bin/bash

mkdir -p ./kafka-logs
export LOG_DIR=./kafka-logs

/opt/confluent/bin/kafka-server-start /opt/confluent/etc/kafka/server.properties >> kafka.log 2>&1
