#!/bin/bash

mkdir -p ./zookeeper-logs
export LOG_DIR=./zookeeper-logs

/opt/confluent/bin/zookeeper-server-start /opt/confluent/etc/kafka/zookeeper.properties > zookeeper.log 2>&1
